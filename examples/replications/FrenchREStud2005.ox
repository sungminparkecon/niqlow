#include "FrenchREStud2005.h"

/** Setup and solve the model.
**/	
French2005::Run()	{
	Initialize(new French2005());
	SetClock(RandomMortality,TMAX,Retirement::mprob);
	for (col = 1;col<sizerc(disc);++col) {
		SetDelta(disc[col]);
		rho = 1/tau[col];
		acteqpars = eqpars[col];
		acteqpars[][Retire:Part] = acteqpars[][Full]-acteqpars[][Retire:Part];
		println(acteqpars);
		Actions(i = new ActionVariable("i",Nactions));
		ejob = new array[Nsectors];
		ejob[Retire]= new NormalRandomEffect("etaR",nReps,0~sig2[col]);
		ejob[Part] 	= new NormalRandomEffect("etaP",nReps,0~sig2[col]);
		ejob[Full] 	= new NormalRandomEffect("etaF",nReps,0~sig2[col]);
		eI 			= new NormalRandomEffect("etaI",nReps,0~sig1[col]);
		ExogenousStates(ejob[Retire],ejob[Part],ejob[Full],eI);
		SemiExogenousStates(eS = new Zvariable("etaS",nReps) );
		EndogenousStates(retired = new ActionTracker("ret.",i,Retire),
					 parted  = new ActionTracker("ptm.",i,Part),
					 stayed  = new ActionTracker("stay",i,Stay),
					 dur = new Duration("t-s",i,stayed,Smax),
					 curs = new RetainMatch(eS,i,Part~Full,Stay) );
		CreateSpaces(NoSmoothing);
		VISolve();
		}
    Delete();
	}

French2005::mprob() {
	decl age = I::t+T0;
	return 		age==T0			? 0.0
			: 	age<65			? drates[A55_64]/HThous
			: 	age<Tstar		? drates[A65_74]/HThous
			: 	age<T2star		? drates[A75_84]/HThous
			: 	0.0;
	}
	
French2005::FeasibleActions() {
	decl age = I::t+T0, iv = Alpha::C[][i.pos];
	if (age==T0) return (iv.==Stay);  				//drawing random effect
	if (age >= Tstar) return (iv.==Retire);	  		//only retirement
	if (retired.v) return (iv.<Stay);				//can't choose to keep current job
	return ones(rows(iv),1);
	}
	
/** Duration must be feasible, do not track current eta if retired.
**/
French2005::Reachable()	{
	decl age = I::t+T0;
	if (parted.v && retired.v) return FALSE;
	if (age>Tstar && (retired.v&&!dur.v&&!stayed.v&&!curs.v)) return TRUE;
	if (age>Tstar) return 0;
	if (!I::t&&(dur.v==S0)&&!retired.v&&!parted.v) return TRUE;
	if (I::t&&(dur.v<=I::t+S0)&&!(retired.v&&curs.v)) return TRUE;
	return FALSE;
	}

/** The one period return.
**/
French2005::Utility()  {
	decl    iv = AV(i), s = dur.v, u,
			Xn =1~10~1~I::t*(1~I::t)~1~0~0,
			Xb = (Xn*acteqpars)';
	if (!I::t||I::t==TMAX-1) return zeros(Alpha::N,1);
	if (Alpha::N==Nactions) Xb |= Xb[parted.v ? Part : Full] + (s~s*s)*acteqpars[6:7][parted.v ? Part : Full];
	u =   Xb
	      +AV(eI)
		  +AV(ejob[Full])   *( iv.==Full .|| (iv.==Stay .&& !parted.v .&& !retired.v))   //take new full time or stay on one
		  +AV(ejob[Part])   *( iv.==Part .|| (iv.==Stay .&& parted.v ))   //take new part time or stay on one
		  +AV(ejob[Retire]) *( iv.==Retire )
		  +sig3[col]*AV(curs)*(iv.==Stay)
		  +(sig3[col]*AV(eS)+Changing[col])*(iv.==Full||iv.==Part);
	return u ;
	}
	
