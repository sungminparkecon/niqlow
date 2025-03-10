#include "GilleskieEmet1998.h"
/* This file is part of niqlow. Copyright (C) 2011-2023 Christopher Ferrall */

DynaHealth::NewEpisode() { return !spell.k.v; }	

/** Return FeasA x NK matrix of illness onset probabilities.
@param FeasA matrix of feasible actions.  Not used in this model because illness onset is independent of choices.
First column is the probability of k=0 state continuing.
**/
DynaHealth::PIll() {
	decl pk = exp(delt);
	return reshape(pk./sumr(pk),Alpha::N,NK);
	}

/** Return FeasA x 1 matrix of episode ending probabilities.
@param FeasA matrix of feasible actions.
First column is the probability of k=0 state continuing.
**/
DynaHealth::PWell() {
	decl vis = CV(trt),
		 work = CV(wrk),
		 tt = CV(spell.t),
		 vv = CV(visits) + vis,
		 aa = CV(absents) + (1-work),
		 xx = 1~vv~sqr(vv)~aa~sqr(aa)~(vv.*aa),
		 tpow = reshape( tt.*(1~tt.*(1~tt)), rows(vis), 3 ),
		 piw = exp( ( xx~tpow) * etas[][CV(spell.k)]);
	return piw./(1+piw);
	}

DynaHealth::Replicate() {
	Initialize(new DynaHealth()); //EVExAnte
	SetClock(Ergodic);
	SetDelta(disc);
    SickL = 1;
	Actions(wrk = new BinaryChoice("work"),
			trt = new BinaryChoice("seek")
			);
	EndogenousStates(visits = new ActionCounter("visits",MaxVisits,trt,1,DynaHealth::NewEpisode),
					 absents = new ActionCounter("absent",MaxAbsences,wrk,0,DynaHealth::NewEpisode)
					 );
	EndogenousStates(spell = new Episode("ill",NK,T,DynaHealth::PIll,DynaHealth::PWell,TRUE));
	CreateSpaces(LogitKernel,1.0);
    VISolve();
	//decl Emax = new ValueIteration(0);Emax.Volume = LOUD;Emax -> Solve(0,0);
    Delete();
	}

DynaHealth::Reachable() {
	decl tv = spell.t.v;
	if (!spell.k.v && tv) return FALSE;  //duration not tracked when well.
	if (tv < absents.v || tv < visits.v) return FALSE;
	return TRUE;
	}	

DynaHealth::Utility() {
	decl kv = spell.k.v,
		 vis = CV(trt),
		 work = CV(wrk),
		 at1 = absents.v+(1-work),
		 X = Y-phyfee*copay*vis-Y*(1-probn((1~at1)*phi)*CV(SickL)).*(1-work);
	if (!kv) return X;
//	println((1~vis~work~X),(1~vis~work~X)*alph[][kv]);
	return (1~vis~work~X)*alph[][kv];
	}

DynaHealth::FeasibleActions() {
    decl wv = CV(wrk);
	return (spell.k.v) ? ones(rows(wv),1) : (1-CV(trt)).*wv ;
	}
	
