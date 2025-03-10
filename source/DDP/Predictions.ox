#ifndef Dh
    #include "Predictions.h"
#endif
/* This file is part of niqlow. Copyright (C) 2011-2023 Christopher Ferrall */

/**  Simple Prediction .
@param T	integer, length of panel<br>UseDefault [default], length of lifecycle or  10
probabilities<br/>Two print predictions
@param prtlevel Two [default] print predictions <br/>One print state and choice
probabilities<br/>Zero do not print, instead save to prediction moment file

This creates a `PanelPrediction` object, creates the prediction tracking all varaibles and prints out. Object is then deleted
@return flat prediction
**/
ComputePredictions(T,prtlevel) {
    decl op = new PanelPrediction("predictions"),TT,oldvol;
    TT = (T==UseDefault) ? (Flags::IsErgodic ? 10: N::T)
                         : T;
    op -> Tracking(TrackAll);
    oldvol = Data::Volume;
    if (prtlevel==Zero) Data::Volume = LOUD;
    op -> Predict(TT,prtlevel);
    Data::Volume = oldvol;
    decl f = op -> GetFlat();
    delete op;
    return f;
    }

/** Compute the predicted distribution of actions and states.
Average values of tracked objects are stored in `Prediction::predmom`
Transitions to unreachable states is tracked and logged in the Data logfile.

@return TRUE if all current states are termimal or last states.
@see TrackObj::Distribution
**/
Prediction::Predict() {

    EOoE.state[:right] = state[:right] = 0;
    if (!sizec(sind)) {     //no indices are current
        predmom[] = .NaN;
        return TRUE;
        }
	decl k,tv,s,q,qi,pp=0.0,unrch=<>,allterm=TRUE,dying, ue;
    foreach (q in sind[s]) {
        pq = p[s];
        if (!iseq(pq,0.0)) {        //changed to iseq() instead of isfeq()
            if (Settheta(q)) {      // q' is in the state space
                EOoE.state[left:right] = state[left:right] = ReverseState(q,tracking)[left:right];
                I::Set(state,FALSE);
                SyncStates(left,right);
                ue = I::curth->UseEps();
                dying = I::curth.Type>=LASTT;
                chq  = pq*I::curth->GetPandV().*( ue ? NxtExog[Qprob]' : 1.0);
                if ( I::curth->StateToStatePrediction(this) ) return  PredictFailure = TRUE;
                foreach (tv in ctlist) tv.track->Distribution(this,tv);
                haz += dying*pq;        // add up mass of states terminating this t
                allterm *= dying;       // keep track if all states are dying
                }
            else {      //q' is supposed to be unreachable!!!
                qi = ReverseState(q,tracking)[left:right];
                pp += p[s]; unrch |= qi' ;
                }
            }
        }
    foreach(tv in ctlist[k]) {
        if (tv.Volume>=LOUD) println(I::t," ",tv.L," ",tv.track.mean);
        predmom[k] = tv.track.mean;
        }
    if (!isfeq(pp,0.0)) {
        if (isfile(Data::logf)) fprintln(Data::logf,"At t= ",t," Lost prob.= ",pp," Unreachable states in transition","%cf","%9.0f","%c",Labels::Vprt[svar][left:right],unrch);
        if (!LeakWarned) {
            println("DDP Warning ??. Leakage in transition probability. At t= "+sprint(t,".Lost prob = ",pp));
            LeakWarned = TRUE;
            }
        }
/*     if (Data::Volume>LOUD) {
        decl ach = sumr(ch), posch = !isdotfeq(ach,0.0);
// This fprintln() causing an unexplained error:
//Runtime error in Predict (80): '[][2] in matrix[1][1]' index out of range
        if (isfile(Data::logf)) fprintln(Data::logf,t," States and probabilities","%r",
            {"Index","Prob."},selectifc(sind|p,!isdotfeq(p,0.0)),
            Alpha::aL1,"Non-zero Choice Probabilities ",
            "%r",Alpha::Rlabels[0][selectifr(Alpha::AIlist[0],posch)],selectifr(ach,posch));
        }
*/
    return allterm;
	}
	
Prediction::Reset() {
	p = sind = <>;
    haz =    ch[] = 0.0;
    }
Prediction::GetAcc() { return accmom; }
Prediction::IncAcc(inf,addmom) {
    if (!inf)
        accmom = addmom;
    else
        accmom += addmom;
    }
/** Initialize and if necessary set moms vectors.
@param sz length of current ctlist.
@param firsttype first or only pass integrating over gamma_r

This was added to reduce vector creation/destruction

**/
Prediction::SetMoms(sz,firsttype) {
    //println("*** ",Version::MPIserver," ",t," ",isint(predmom)," ",firsttype);
    if ( isint(predmom) ) {
        predmom = constant(.NaN,1,sz);            //create
        accmom = zeros(predmom);
        //     || columns(predmom)!=sz) {  //first OR switch in PathPrediction object        if (!isint(predmom)) { delete predmom; delete accmom;}                  //switch
        }
    else {  //reset existing vectors
        if (firsttype) accmom[] = 0.0;
        predmom[]=.NaN;
        }
    }

/** Create a new prediction.

Typically a user would create a `PathPrediction` or further derived classes which in turn creates predictions.
@param t <em>integer</em>, position in the path.
**/
Prediction::Prediction(t){
    Task();
    left = SS[tracking].left;
    right = SS[tracking].right;
	this.t = t;
	W = pnext = UnInitialized;
    ch = zeros(N::A,1);
    haz = predmom = empmom = 0;
    Reset();
	}

/**
@internal
**/
PathPrediction::SetT() {
  decl cur=this,tmp;
  if (inT>0) this.T = inT;
  InitialConditions();
  do {
	 if (!isclass(cur.pnext)) {  // no tomorrow after current
        if (inT && cur.t+1<this.T) { // predict for a fixed T
            cur.pnext = new Prediction(cur.t+1);
            }
        }
     else {
        if (inT && cur.pnext.t>=this.T)  {    //fixed panel shorter than existing
            tmp = cur.pnext;
            cur.pnext = cur.pnext.pnext;
            delete tmp;
            --this.T;
            }
        else
            cur.pnext->Reset();  //tomorrow already exists, reset it.
        }
  	 } while((isclass(cur = cur.pnext)));  //changed so that first part of loop determines if this is the last period or not.
  return TRUE;
  }

PathPrediction::tprefix(t) { return sprint("t_","%02u",t,"_"); }

PathPrediction::SetFlat(inflat,SetorInc,Cols) {
    if (Cols>=Zero) {
        if (SetorInc)
            flat[][Cols:] = inflat;
        else
            flat[][Cols:] += inflat;
        }
    else {
        if (SetorInc)
            flat = inflat;
        else
            flat += inflat;
        }
    }

/** process predictions and empirical matching when there are observations over time.
@param cmat if a matrix then get contributions from it.  This is true when running in parallel.<br/>
    Otherwise, contributions are located in the individual Prediction objects.

If aggregate moments are being tracked then the weighted values for this
    group are added to them.

@internal

**/
PathPrediction::ProcessContributions(cmat){
    decl ismat = ismatrix(cmat),  aggcur=mother,
        flatify = MakeFlat || ( !Version::MPIserver && (Data::Volume>QUIET || prtlevel) ) ;
    vdelt =<>;    dlabels = {};
    if (ismatrix(flat)) delete flat;
    if (flatify) {
        flat = constant(.NaN,T,Fcols+One+sizeof(mother.tlist));
        if (!f && aggexists) mother->SetFlat(flat);
        //mother.flat = flat;
        }
    cur=this;
    do {
        if (ismat) { cur->IncAcc(0,cmat[cur.t][]); }
        if (flatify) flat[cur.t][] = fvals~cur.t~cur->GetAcc();
        if (HasObservations) {
            if (ismatrix(pathW)) {
                dlabels |= suffix(mother.tlabels[One:],"_"+tprefix(cur.t));
                vdelt ~= cur->Delta(mother.mask,Data::Volume>QUIET,mother.tlabels[One:]);
                }
            else {
                 vdelt |= cur->Delta(mother.mask,Data::Volume>QUIET,mother.tlabels[One:]);
                 }
            }
        if (aggexists) {
            aggcur->IncAcc(f,myshare * cur->GetAcc());
            aggcur = aggcur.pnext;
            }
        cur    =    cur.pnext;
  	    } while(isclass(cur));
    if (flatify && aggexists) {
        if (!f){
            mother->SetFlat(constant(AllFixed,flat));      //set everything to -1 (get the right dimensions)
            mother->SetFlat(myshare * flat[][Fcols:],TRUE,Fcols);      //only average non fixed columns
            }
        else
            mother->SetFlat(myshare * flat[][Fcols:],FALSE,Fcols);
            // mother.flat[][Fcols:] += myshare * flat[][Fcols:];
        }
    L = (HasObservations) ? (
                ismatrix(pathW) ? outer(vdelt,pathW)
                                : norm(vdelt,'F') )
            : 0.0;
    if (flatify && HasObservations && isfile(Data::logf) ) {
        fprintln(Data::logf," Predicted Moments group ",f," ",L,
        "%c",mother.tlabels,"%cf",{"%5.0f","%12.4f"},flat[][Fcols:],  //,"%6.4F"
        "Diff between Predicted and Observed","%cf",{"%12.4f"},"%c",mother.tlabels[One:],
                ismatrix(pathW) ? reshape(vdelt,T,sizeof(mother.tlabels[One:])) : vdelt
                );
        }
    //flat |= constant(.NaN,this.T-rows(flat),columns(flat));
    }

/** Create or update a path of predicted distributions.
@param inT <em>integer</em> length of the path<br>0 (default) : predict only for
existing predictions on the Path.<br>
If existing path is longer than inT (and inT &gt; 0) then extra predictions are
deleted.
@param prtlevel Zero [default] do not print<br>One print state and choice
probabilities<br>Two print predictions
@return TRUE if everything succeeds<br/>FALSE if either the solution method or the
prediction fails

Predictions are averaged over random effect groups.

@example
<pre>
  p = new PanelPrediction();
  p-&gt;Predict(10);
</pre></dd>
**/
PathPrediction::Predict(inT,prtlevel){
    this.inT = inT;
    this.prtlevel = prtlevel;
    if (!Initialize()) return FALSE;
	if (isclass(mother.summand))
		mother.summand->Integrate(this);
	else {
        rcur = I::r;  //Added Oct. 2018
		TypeContribution();
        }
    if (PredictFailure) {
        L = +.Inf;
        flat = <>;
        return FALSE;
        }
    else {
        ProcessContributions();
        if (!Version::MPIserver && (Data::Volume>QUIET || prtlevel) ) {
            if (Version::HTopen) println("</pre><a name=\"Prediction\"/><pre>");
            println(" Predicted Moments for fixed group: ",f,"%c",mother.tlabels,"%cf",{"%5.0f","%12.4f"},flat[][Fcols:]);  //,"%6.4F"
            }
        return TRUE;
        }
  }

/** Get selected elements of the flat path prediction after it is made.
@param tvals DoAll (default) return all time periods(rows) <br/> integer or vector of t indices to report
@param mvals DoAll (default) return all moments (columns) <br/> integer or vector of moments to report
@return flat[tvals][mvals]
**/
PathPrediction::GetFlat(tvals,mvals) {
    if (tvals==DoAll) {
        if (mvals==DoAll) return flat;
        return flat[][mvals];
        }
    if (mvals==DoAll) return flat[tvals][];
    return flat[tvals][mvals];
    }

/**  Work in parallel.
@internal
**/
PanelPrediction::ParallelSolveSub(subp) {
    I::SetGroup(subp);
    decl subflat=<>, pobj = fparray[I::curg.find]; // no longer using myself    I::curg.find ? ... : this;
    pobj.rcur = I::curg.rind;
    pobj->PathPrediction::Initialize();
    pobj->TypeContribution(DP::curREdensity,&subflat);
    return subflat;
    }


/** Add empirical values to a path of predicted values.
@param inmom  Txm matrix of values.
@param hasN FALSE: no row observation column<br/>
            TRUE: second-to-last column that contains observation count used for weighting of distances.
@param hasT FALSE: no model t column<br/>
            TRUE: last column contains observation count
@param MaxT path length will equal max{MaxT,maxc{inNandMom[][C]}}
@comments
If T is greater than the current length of the path additional predictions are concatenated to the path

**/
PathPrediction::Empirical(inNandMom,hasN,hasT,MaxT) {
    decl j,inmom,totN,inN,invsd,C = columns(inNandMom)-1,influ,dt,pt,datat,negt,
    report = !Version::MPIserver && Data::Volume>SILENT && isfile(Data::logf) ;
    HasObservations = TRUE;
    influ = 0;
    if (hasT) {
        negt = inNandMom[][C].<0;
        if ( any(negt)  ) {
            if (wght!=IGNOREINFLUENCE) {
                influ = inNandMom[maxcindex(negt)][:C-2]  ;
                if (report) fprintln(Data::logf,"Influence weights","%c",mother.tlabels[One:C-2],influ);
                }
            inNandMom = deleteifr(inNandMom,negt);
            }
        datat = inNandMom[][C];
        if ( any( diff0(datat) .< 0) )
                oxrunerror("DDP Error ??. t column in moments not ascending. Check data and match to fixed groups.");
        T = max(maxc(datat)+1,rows(inNandMom),MaxT);
        if (report) MyMoments(inNandMom,mother.tlabels[One:],Data::logf);
        }
    else {
        T = max(rows(inNandMom),MaxT);
        datat = range(0,T-1)';
        influ = ones(1,C-1);
        }
    if (hasN) {
        inN = inNandMom[][C-1];
        inN = isdotnan(inN) .? 0 .: inN;
        totN = sumc(inN);
        }
    else {
        inN = ones(T,1);
        totN = 1.0;
        }
    inmom = inNandMom[][:C-hasN-hasT];
    if (isint(influ)) influ = selectifc(ones(mother.mask),mother.mask);       //if IGNOREINFLUENCE this happens & influence weights in data ingored
    for (j=0;j<columns(mother.cols);++j)//insert columns for moments not matched in the data
        if (mother.cols[j]==NotInData) {
            if (j==0) inmom = .NaN ~ inmom;
            else if (j>=columns(inmom)) inmom ~= .NaN;
            else inmom = inmom[][:j-1]~.NaN~inmom[][j:];
            }
    if (!Version::MPIserver && columns(inmom)!=columns(mother.mask))
        oxwarning("Empirical moments and mask vector columns not equal.\nPossibly labels do not match up.");
    invsd = 1.0;
    switch(wght) {
        case UNWEIGHTED : break;

        case UNCORRELATED :
        case IGNOREINFLUENCE:
                        invsd = 1.0 ./ setbounds(moments(inmom,2)[2][],0.1,+.Inf);
                        invsd = isdotnan(invsd) .? 0.0 .: invsd;  //if no observations, set weight to 0.0
                        invsd = selectifc(invsd,mother.mask);
                        break;
        case CONTEMPORANEOUS :  oxrunerror("CONTEMPORANEOUS correlated moments not implemented yet");
                                break;
        case INTERTEMPORAL :    pathW = loadmat("pathW_"+sprint("%02i",f)+".mat");
                                break;
        case AUGMENTEDPATHW :
                                pathW = loadmat("pathW_"+sprint("%02i",f)+".mat");
                                if (isint(pathW))
                                    oxwarning("File with weights for path of group "+sprint(f)+" not found ");
                                decl dd = diagonal(pathW), en = norm(dd,1);
                                dd = dd.==0 .? .01 .: dd;
                                if (!Version::MPIserver)
                                    println("Augmenting pathW.  Original |diag|: ",en," . New |diag: ",norm(dd,1));
                                pathW = setdiagonal(pathW,dd);
                                break;
            }
    if (!Version::MPIserver && Data::Volume>QUIET && isfile(Data::logf) )
        fprintln(Data::logf,"Row influence: ",influ,"Weighting by row and column",(inN/totN).*invsd.*influ);
    cur = this;
    pt = dt = 0;
    do {
        if ( dt<rows(datat) && cur.t==datat[dt]) {                         // this period has data
            cur.W = (inN[dt]/totN)*(invsd.*influ);
            cur.readmom = inmom[dt++][];                //store empirical moments and increment row
            }
        else {                                          // no data for this t
            cur.W = zeros(influ);
            cur.readmom = constant(.NaN,mother.mask);
            }
        cur.empmom = selectifc(cur.readmom,mother.mask);
        if (++pt<T) {
            if (cur.pnext==UnInitialized)
                cur.pnext = new Prediction(cur.t+1);  // add another period if required
            cur = cur.pnext;                          // point to next period
            }
        } while(pt<T);
    }

/** Set the initial conditions of a path prediction.
What happens depends on `PathPrediction::iDist`.

@internal
**/
PathPrediction::InitialConditions() {
    if (isint(iDist)) {
        if (iDist==ErgodicDist) {
            if (!Flags::IsErgodic) oxrunerror("Clock is not ergodic, can't use ergodic predictions");
            sind =  range(0,SS[tracking].size-1)';
            p = GetPinf();
            if (isnan(p)) oxrunerror("Ergodic Distribution contains NaNs, cannot compute stationary predictions");
            }
        else {
		  sind=iDist; //start at iDist
		  while (!Settheta(sind)) ++sind;  // increment until reachable state found
          sind = matrix(sind);
		  p = <1.0>;
          }
		}
	else if (ismatrix(iDist)||isarray(iDist)) {
		sind = ismatrix(iDist) ? (SS[tracking].O*iDist)' : iDist[0];
		if (!Settheta(sind[0])) oxrunerror("DDP Error 63. Initial state is not reachable");
		p = ismatrix(iDist) ? ones(sind)/sizerc(sind) : iDist[1];
		}
	else if (isclass(iDist,"Prediction")) {
		sind = iDist.sind;
		p = iDist.p;
		}
	else if (isfunction(iDist))
        iDist(this);
    else {
        //println("Argument iDist = ",iDist);
        oxrunerror("DDP Error 64. iDist must be integer, vector, function or Prediction object");
        }
    if (!Version::MPIserver && Data::Volume>LOUD && isfile(Data::logf) ) fprintln(Data::logf,"Path for Group ",f,". Initial State Indices & Prob.","%r",{"Ind.","prob."},(sind~p)',"----");
    ch[] = 0.0;
    //LeakWarned = FALSE;  Don't keep warning of leaks
    }

/** Create a path of predictions - should only be called by PanelPrediction.

@param mother  object of `PanelPrediction` that is the mother to this path.
@param f     integer: fixed group index [default=0]<br />
             AlLFixed (-1):  this aggregates (averages) predictions over
             NotInData (-2):  no prediction stored here.
@param method 0: do not call a nested solution [default]<br/>
              a solution `Method` object to be called before making predictions
@param iDist  initial distribution.<br/>
        ErgodicDist : use computed stationary distribution in ergodic dist.</br>
        non-negative integer: start at iDist and increment until a reachable state index is found.
        So <code>PathPrediction(0)</code> [default] will start the prediction at the
        lowest-indexed reachable state in
        &Theta;.<br/>
        matrix: a list of states to start the prediction from<br/>
        object of Prediction class: use `Prediction::sind` as the initial state for
        this prediction.
@param wght Code for weighting scheme for distance between empirical and predicted paths.
@param myshare either 0 or a fraction of the population if an aggregate (overall)
    prediction is being stored.

The prediction is not made until `PathPrediction::Predict`() is called.

**/
PathPrediction::PathPrediction(mother,f,method,iDist,wght,myshare){
    if (!isclass(mother,"PanelPrediction"))
        oxrunerror("PathPrediction must point to its  mother.  Cannot be created as a standalone prediction.");
    this.mother = mother;
	this.f = f;
	this.method = method;
    this.iDist = iDist;
    this.wght = wght;
    this.myshare = myshare;
	fnext = UnInitialized;
    Prediction(Zero);
    T = One;
    prtlevel = flat = pathW = inT = Zero;
    pstate = ReverseState(f,onlyfixed);
    fvals = N::F>One ? f~pstate[S[fgroup].M:S[fgroup].X]' : matrix(f); //f must be a matrix so Fcols is correct
    Fcols = columns(fvals);
    MakeFlat = HasObservations = FALSE;
	}


/** clean up.
@internal

**/
Prediction::~Prediction() {
    delete state, delete sind, delete p, delete ch, delete W,  delete predmom, delete empmom;
	}

/** clean up.
@internal

**/
PathPrediction::~PathPrediction() {
	while (isclass(pnext)) {  // delete all but first
		cur = pnext.pnext;
		delete pnext;
		pnext = cur;
		}
	~Prediction();  //delete myself
    }

/** Compute the histogram of tracked object at the prediction.
@param printit TRUE=output; FALSE=quiet
@comments
output will also be produced for any objects in tlist with Volume &gt; SILENT
**/
Prediction::Histogram(printit) {
	decl tv,k;
    Alpha::SetA();
    foreach(tv in ctlist[k] ) {
        tv->Realize();   //??added May 2019 because this was moved out of Distribution
        tv.track->Distribution(this,tv);
        predmom[k] = tv.track.v;
        if (printit) tv.track->print(tv);
        }
    Alpha::ClearA();
    oxwarning("Histogram is called but it may not be working");
    return t~predmom;
	}

/** Difference between empirical and predicted moments.
@param mask vector to mask out predictions
@printit TRUE print out results
@return  predicted-empirical<br/>
        with 0 if empirical is missing<br/>
        .Inf if prediction is undefined
@internal

**/
Prediction::Delta(mask,printit,tlabels) {
    decl df;
    decl mv = selectifc(accmom,mask);
    if (!ismatrix(empmom))  // if no data difference is zero.
        return zeros(mv);
    df = isdotnan(empmom)           //find missing empirical moments
                .? 0.0                  //difference is then 0.0
                .:  (isdotnan(mv)   // else, find mising predictions
                        .? .Inf             // difference unbounded
                        .: W.*(mv-empmom));   // weighted difference
    if (!Version::MPIserver && printit && isfile(Data::logf) )
        fprintln(Data::logf,t,"%r",{"pred.","obsv.","W","delt"},"%12.4g","%c",tlabels,mv|empmom|reshape(W,1,columns(empmom))|df);
    return df;
    }

/** Print mean and histogram of tracked object.
**/
TrackObj::print(obj) {
    fprintln(Data::logf,obj.L,"  Mean: ",mean);
    fprintln(Data::logf,"%c",{"v","pct"},"%cf",{"%8.4f","%9.6f"},obj.actual~hist);
    }

/** Add objects to track mean values over the path.
@param LorC  UseLabel: use object label to match to column.<br/>NotInData unmatched to data.<br/>
            integer: column in data set<br>string: column label<br/>
            TrackAll : track all actions, endogenous states and auxiliaries
@param ... `Discrete` objects and/or arrays or objects to track

@return a row vector of the positions of the added objects that can be sent to `PathPrediction::GetFlat` Thus
if different sets of outcomes should be extracted together as vectors call Tracking() for each set and store
the return value.

@comment
This routine can be called more than once, but once `PanelPrediction::Predict`() has
been called no more objects can be added to the list.

**/
PanelPrediction::Tracking(LorC,...
    #ifdef OX_PARALLEL
    args
    #endif
) {
    if (EverPredicted) {
        oxwarning("DDP Warning 12.\n Do not add to tracking list after predictions made ... ignored\n");
        return;
        }
    TrackingCalled = TRUE;
    decl v, newpos=<>;
    if (LorC==TrackAll) {
        println("Tracking all actions, endogenous state and auxiliary variables");
        args = SubVectors[acts]|SubVectors[endog]|Chi;
        }
    else {
        if (sizeof(args)>1 && (isstring(LorC) || LorC>UseLabel) )
            oxrunerror("DDP Error 65. Can't track with column matching more than one object at a time.  Send separately");
        }
    foreach(v in args) {
        if (isarray(v)) {
            decl w;
            foreach(w in v) Tracking(LorC,w);
            }
        else {
            v.track  = new TrackObj(LorC,v,sizeof(tlist));
            newpos ~= Fcols+One+sizeof(tlist);
            tlist   |= v;
            tlabels |= v.L;
            }
        }
    return newpos;
    }

/** Set up data columns for tracked variables.
@param dlabels array of column labels in the data.
@param Nplace number of observations (row weight) column<br/>UnInitialized no row weights
@param tplace model t column<br/>UnInitialized
**/
PanelPrediction::SetColumns(dlabels,Nplace,Tplace) {
    decl v,lc,vl,myc;
    cols = <>;
    mask = <>;
    foreach(v in tlist) {
        lc = v.track.LorC;
        if (isint(lc)){
            if (lc==NotInData) {
                mask ~= 0;
                cols ~= NotInData;
                continue;
                }
            if (lc>UseLabel) {
                cols ~= lc;
                mask ~= 1;
                continue;
                }
            vl = v.L;
            }
        else vl = lc;
        myc = strfind(dlabels,vl);
        if (myc<0 && !Version::MPIserver && Data::Volume>SILENT)
            oxwarning("DDP: moment label -"+vl+"-not found.");
        cols ~= myc;
        mask ~= 1;
        }
    if (isstring(Nplace)|| Nplace!=UnInitialized)
        cols ~= isint(Nplace) ? Nplace : strfind(dlabels,Nplace);
    else
        cols ~= .NaN;
    if (isstring(Tplace)|| Tplace!=UnInitialized)
        cols~= isint(Tplace) ? Tplace : strfind(dlabels,Tplace);
    else
        cols ~= .NaN;
    }

PanelPrediction::InitializePath(pstate) {
    EverPredicted = TRUE;
    if (!sizeof(tlist)) {
        println("Nothing tracked.  Will track everthing.");
        Tracking(TrackAll);
        }
	if (isclass(upddens)) {
		upddens->SetFE(pstate);
		summand->SetFE(pstate);
		upddens->loop();
		}
    }

/** Get ready to compute predictions along the path.
This updates every tracked object.  It updates the density over random effects for this fixed effect.

@internal

**/
PathPrediction::Initialize() {
    PredictFailure = FALSE;
    if (isclass(mother,"PanelPrediction")) mother->InitializePath(pstate);
    flat = <>;
    L = +.Inf;
    firstprediction = TRUE;
    return TRUE;
    }

/** Compute predictions and distance over the path.
@internal
@param pf
@param subf

**/
PathPrediction::TypeContribution(pf,subflat) {
  decl done, pcode,tv;
  if (isclass(mother.method)) { // Nested Solution algorithm. Solve the current problem
        if (!(mother.method->Solve(f,rcur)))   // Did solution fail?
            return FALSE;
        }
  Flags::NewPhase(PREDICTING);
  SetT();
  cur=this;
  ctlist = mother.tlist;
  ExogOutcomes::SetAuxList(ctlist);  //mother.tlist
  if (Data::Volume>LOUD) println("++ TypeContribution ",Version::MPIserver," ",pf);
  do {
     cur->SetMoms(sizeof(ctlist),firstprediction);
     foreach(tv in mother.tlist) {
        tv.track->Reset();
        if (tv.Volume>=LOUD) println(tv.L," ",tv.track.mean);
        }
     pcode = cur->Prediction::Predict();
     done =  pcode                               //all states terminal or last
            || (this.T>0 && cur.t+1 >= this.T);    // fixed length will be past it
     if (PredictFailure) break;
     cur.accmom[] += pf*cur.predmom;
     if (Data::Volume>LOUD) println(cur.accmom[]);
     if (!isint(subflat)) subflat[0] |= cur.accmom;
	 if (!done) {
          if (!isclass(cur.pnext)) { // no tomorrow after current
                cur.pnext = new Prediction(cur.t+1);
                ++this.T;
                }
        cur = cur.pnext;
        }
  	 } while(!done);
  if (pcode && isclass(cur.pnext)) {
     decl nxt = cur.pnext;
     cur.pnext = UnInitialized;
     println("Trimming path of length ",this.T," that ended early at ",cur.t+1);
     this.T = cur.t+1;
     do {
        cur = nxt.pnext;
        delete nxt;
        } while (( isclass(nxt = cur) ));
     }
  firstprediction = FALSE;
  Flags::NewPhase(INBETWEEN,Data::Volume>QUIET);
  if (Data::Volume>LOUD) println("----------------");
  return 0;
  }


/** Return the longest MPI message length sent back by a path prediction call.
@internal

**/
PanelPrediction::MaxPathVectorLength(inT) {
    decl n=0,tsize = sizeof(tlist);
    cur = first;
    do {
        n= max(n,max(inT,cur.T) * tsize);
        } while((isclass(cur = cur.fnext)));
    if (f==AggGroup) n= max(n,max(inT,T) * tsize);
    return n;
    }

/* Set an object to be tracked in predictions.
@param LorC  UseLabel: use object label to match to column.<br/>
            NotInData: unmatched to data.<br/>
            non-negative integer: column in data set<br/>
            string: column label<br/>
            TrackAll: add all actions, endogenous states, and auxliaries to the tracking list
@param ... objects or arrays of objects to be tracked
PanelPrediction::Tracking(LorC,...) {
    decl v,args=va_arglist();
    TrackingCalled = TRUE;
    cur=first;
    do {
        cur->PathPrediction::Tracking(LorC,args);
        } while( (isclass(cur=cur.fnext)) );
    if (f==AllFixed)
        PathPrediction::Tracking(LorC,args);

    }
**/

/**
@internal
**/
PanelPrediction::~PanelPrediction() {
    if (isarray(fparray)) {
       fnext = fparray[0];
	   while (isclass(fnext)) {
		  cur = fnext.fnext;
		  delete fnext;
		  fnext = cur;
		  }
        }
    delete tlist, delete tlabels;
    ~PathPrediction();
	}	

/** Create a panel of predictions.
@param label name for the data<br/>
        UseDefault [default] use classname of model class.
@param method `Method` to be called before predictions.
@param iDist initial conditions for `PathPrediction`s<br/>
        ErgodicDist : use computed stationary distribution in ergodic dist.<br/>
        0 [default]: start the prediction at the lowest-indexed reachable state in &Theta;.<br/>
        non-negative integer: start at iDist and increment until a reachable state index is found.<br/>
        matrix: a list of states to start the prediction from, uniform distribution<br/>
        array: a list of state INDICES and a list of probabilities, can be the output of a IID Transit()<br/>
        object of Prediction class: use `Prediction::sind` as the initial state for this prediction.
@param wght [default=UNCORRELATED]
@param aggshares   0 [default] equal shares of averaged moments over fixed groups<br/>
                  -1 [UnInitialized] do not compute averaged moments<br />
                  Fx1 vector, share of population
**/
PanelPrediction::PanelPrediction(label,method,iDist,wght,aggshares) {
    decl k;
    aggexists= N::F>One && (!isint(aggshares) || aggshares!=UnInitialized);
    PathPrediction(this,aggexists ? AggGroup : 0,method,iDist,wght,0);	
    EverPredicted = FALSE;
    this.method = method;
    tlabels = {"t"};  //,"S"
    tlist = {};
    pcount = first = Zero;
    label = isint(label) ? classname(userState) : label;
    PredMomFile=replace(Version::logdir+DP::L+"_PredMoments_"+label," ",""); // removed so pcount can be used +".dta";
    if (N::F>One) {
	   fparray = new array[N::F];
	   for (k=Zero;k<N::F;++k) {
            if (isclass(I::SetGroup(k*N::R))) {
                fparray[k] = new PathPrediction(this,k,method,iDist,wght,ismatrix(aggshares)? aggshares[k] : 1/N::F);
                if (!isclass(first))
                    first = cur = fparray[k];
                else
                    cur = cur.fnext = fparray[k];
                }
            }
       if (!isclass(method))
        oxwarning("DDP Warning: Solution method is not nested with fixed effects present.  Predictions may not be accurate");
       }
    else {
        fparray = 0;
        first = this;
        }
    FN = 1;
    TrackingCalled = FALSE;
    if (N::R>One || N::DynR>One ) {
        if (!isclass(method) )
            oxwarning("DDP Warning: Solution method is not nested with random effects present.  Predictions will not be accurate.");
        summand = new RandomEffectsIntegration();
        upddens = new UpdateDensity();
        }
	else {
        summand = upddens = UnInitialized;
        }
    }

/** Predict outcomes in the panel.
@param T : positive integer or matrix of lengths of paths to predict (same length as
            number of paths in then panel)
@param prtlevel : Zero [default] do not print<br/>
                One print state and choice probabilities<br/>
                Two print predictions
@param outmat matrix, predictions already made, just process contributions
@return succ TRUE no problems<br/>FALSE prediction or solution failed.
**/
PanelPrediction::Predict(inT,prtlevel,outmat) {
    decl cur, succ, nt;
    if (!TrackingCalled) PanelPrediction::Tracking();
    if (f==AggGroup) {
        vdelt =<>;    dlabels = {};
        if (ismatrix(flat)) delete flat;
        this.inT = inT;
        SetT();
        }
    aflat = {};
    M = 0.0;
    succ = TRUE;
    cur =first;
    nt = sizeof(tlist);
    if (ismatrix(outmat))
        outmat = aggregater(outmat, N::R);   //already weighted by r density
    do {  //processing each fixed group, could just be me.
        if (ismatrix(outmat))
            cur->PathPrediction::ProcessContributions(shape(outmat[][cur.f],nt,T)'); // long vector reshaped into T x nt panel of moments
        else
            succ = succ && cur->PathPrediction::Predict(inT,prtlevel);
        M += cur.L;
	    if (!Version::MPIserver && Data::Volume>QUIET) aflat |= cur->GetFlat();
        } while((isclass(cur=cur.fnext)));
     if (f==AggGroup) {  // aggregate moments
     	if (!Version::MPIserver && Data::Volume>QUIET) aflat |= this->GetFlat();
        if (HasObservations) {
            cur = this;  //processing aggregate moments over t
            do {
                if (ismatrix(pathW)) {
                    dlabels |= suffix(tlabels[One:],"_"+tprefix(cur.t));
                    vdelt ~= Delta(mask,Data::Volume>QUIET,tlabels[One:]);
                    }
                else
                    vdelt |= cur->Delta(mask,Data::Volume>QUIET,tlabels[One:]);
                cur    =    cur.pnext;
  	            } while(isclass(cur));
            L = ismatrix(pathW) ? outer(vdelt,pathW) : norm(vdelt,'F') ;
            M += L;
            if (!Version::MPIserver && HasObservations && Data::Volume>QUIET && isfile(Data::logf) ) {
                fprintln(Data::logf," Predicted Moments group ",f," ",L,
                    "%c",mother.tlabels,"%cf",{"%5.0f","%12.4f"},flat[][Fcols:],
                    "Diff between Predicted and Observed","%cf",{"%12.4f"},"%c",mother.tlabels[One:],
                    ismatrix(pathW) ? reshape(vdelt,T,sizeof(mother.tlabels[One:])) : vdelt
                    );
                }
            }
        }
    if (!Version::MPIserver && Data::Volume>QUIET) {
        decl amat = <>,k,thisfilename=PredMomFile+sprint("%02u",pcount)+".dta";
        foreach(k in aflat) amat |= k;
        savemat(thisfilename,amat,
                N::F==1 ? {"f"}|tlabels
                        : {"f"}|Labels::Vprt[svar][S[fgroup].M:S[fgroup].X]|tlabels);
        println("Panel Prediction stored in ",thisfilename,"\n Read() will read back into a PredictionDataSet if pcount=0");
        ++pcount;
        }
    M = succ ? -sqrt(M) : -.Inf;
    return succ;
    }

/** Track an object that is matched to column in the data.
@param LorC  label or column index in the data to associate with this moment.
@param mom `Discrete` object to track
**/
PredictionDataSet::TrackingMatchToColumn(LorC,mom) {
    PanelPrediction::Tracking(LorC,mom);
    }


/** Track one or more objects that are matched to columns using the object's label.
@param InDataOrNot TRUE: the <code>UseLabel</code> tag will be passed to
            `PathPrediction::Tracking`()<br/>
            FALSE: the <code>NotInData</code> tag will be sent.
@param ... objects or array of objects to track
**/
PredictionDataSet::TrackingWithLabel(InDataOrNot,...
    #ifdef OX_PARALLEL
    args
    #endif
) {
    decl v, pparg = InDataOrNot ? UseLabel : NotInData;
    PanelPrediction::Tracking(pparg,args);
    }


/** Create a panel prediction that is matched with external data.
@param UorCorL where to get fixed-effect values<br/>
        matrix of indices or array of labels<br/>
        UseLabel [default]<br/>
        NotInData only allowed if F=1, then no column contains fixed variables
@param label name for the data<br/>
        UseDefault [default] use classname of model class.
@param method solution method to call before predict<br/>
            UnInitialized [default] no method (warning if there is heterogeneity)
@param iDist initial conditions set to `PathPrediction`s
@param wght see `GMMWeightOptions`
@param aggshares FALSE [default] or a Fx1 vector of population shares for groups to
    be used when creating an aggregate prediction.
**/
PredictionDataSet::PredictionDataSet(UorCorL,label,method,iDist,wght,aggshares) {
    decl q,j;
    Tplace = Nplace = UnInitialized;
    PanelPrediction(label,method,iDist,wght,aggshares);
    if (UorCorL==NotInData) {
        if (N::F>1) oxrunerror("Multiple fixed groups but data contain no fixed columns.  ");
        flist = 0;
        }
    else if (ismatrix(UorCorL)||isarray(UorCorL)) {
        if (sizerc(UorCorL)!=S[fgroup].D) oxrunerror("DDP Error 66. column index vector wrong size");
        flist = UorCorL;
        }
    else if (UorCorL==UseLabel) {
        if (N::F==1) flist = 0;
        else {
            decl s, FF=SubVectors[fgroup];
            flist = {FF[0].L};
            for(s=1;s<S[fgroup].D;++s) flist |= FF[s].L;
            }
        }
    else oxrunerror("DDP Error 66. 3rd Argument UorCorL incorrect type");
     }

/** Define columns where observations and time values appear.
@param NLabelOrColumn  integer or string for column of data containing observation
counts.
                       This is used to adjust weight of rows in moments.
@param TLabelOrColumn  integer or string for column of data containing model t
value.<br/>
                        Data must still be sorted in time!  However, this allows
                        missing time periods to be skipped.  Further, it allows
                        for a special row containing moment influence/importance
                        adjustments.<br/>

**/
PredictionDataSet::Observations(NLabelOrColumn,TLabelOrColumn) {
    if ( (isint(NLabelOrColumn)&&(NLabelOrColumn>=0)&&isarray(flist))
        ||(isstring(NLabelOrColumn)&&ismatrix(flist)))
        oxrunerror("DP Error ??.  First argument has to be consistent with UorCorL argument sent to PredictionDataSet Creator");
    Nplace = NLabelOrColumn;
    Tplace = TLabelOrColumn;
    }

/** The default econometric objective for a panel prediction: the overall GMM
objective.
@param subp  DoAll (default), solve all subproblems and return likelihood vector<br/>
             Non-negative integer, solve only subproblem, return contribution to
             overall GMM
@return `PanelPrediction::M`
**/
PredictionDataSet::EconometricObjective(subp) {
    if (subp==DoAll) {
        PanelPrediction::Predict();
        return M;
        }
    else {
        decl vv = ParallelSolveSub(subp);
        return vv;
        }
	}

/** Read in external moments of tracked objects.
@param FNorDB  string, name of file that contains the data.<br/>A Ox database object.
@param MaxT TRUE: set length of prediction equal to the max{T} for all Paths, otherwise use individual lengths
**/
PredictionDataSet::Read(FNorDB,MaxT) {
    decl fptr,curf,inf,inmom,fcols,row,v,data,dlabels,source,fdone,incol,
    report = !Version::MPIserver && Data::Volume>SILENT && isfile(Data::logf) ;
    if (report ) {
        println("List of Empirical Moments in Data log file");
        fprintln(Data::logf,"List of Empirical Moments");
        foreach(v in tlabels[row]) fprintln(Data::logf,"   ",row,". ",v);
        }
    if (isstring(FNorDB)||isint(FNorDB)) {
        source = new Database();
        if (isint(FNorDB)) {
            println("Attempting to read from PanelPrediction Data File ",PredMomFile);
            FNorDB = PredMomFile+sprint("%02u",0)+".dta";
            }
	    if (!source->Load(FNorDB)) oxrunerror("DDP Error 66. Failed to load data from"+FNorDB);
        if (report) fprintln(Data::logf,"Reading in Moments from file ",FNorDB);
        }
    else {
        source = FNorDB;
        if (report) fprintln(Data::logf,"Reading in Moments from Ox Database");
        }
	dlabels=source->GetAllNames();
	data = source->GetAll();
    if (report ) fprintln(Data::logf,"Data columns",dlabels);
    if (isarray(flist)) {
        fcols = strfind(dlabels,flist);
        if (any(fcols.==NoMatch)) {println("***",dlabels,flist,fcols); oxrunerror("DDP Error 67. label not found");}
        }
    else
       fcols = ismatrix(flist) ? flist : 0;
    fdone = zeros( N::F+(N::F>One) ,1);
    if (ismatrix(fcols)) {
        decl c, k;
        foreach(c in fcols[k]) {
            row = rows(data);
            data = deleteifr(data,data[][c].>=SubVectors[fgroup][k].N);
            if (row>rows(data)) println("excluded some moments for fixed variable out of current range. Fixed variable: ",k," # of values: ",SubVectors[fgroup][k].N);
            }
        }
    fptr = this;
    decl hasN = isstring(Nplace)||(Nplace!=UnInitialized),
         hasT = isstring(Tplace)||(Tplace!=UnInitialized);
    SetColumns(dlabels,Nplace,Tplace);
    row = 0;
    inf = (isint(fcols)) ? 0 : I::OO[onlyfixed][S[fgroup].M:S[fgroup].X]*data[row][fcols]';
    incol = selectifc(cols,cols.>=0);
    if (MaxT && hasT) MaxT = maxc(data[][incol[columns(incol)-1]])+1;  // make all paths as long as the longest empirical path.
    if (inf<Zero) inf = N::F; //any negative value maps into N::F+1
    do {
        curf = inf;
        fptr = (curf==N::F || N::F==One) ? this : fparray[curf];
        if (fdone[curf])
            oxrunerror("DDP Error 68. reading in moments for a fixed group more than once.  moments data file not sorted properly");
        fdone[curf] = TRUE;
        inmom = <>;
        do {
            if (row<rows(data)) {  //read one more
                inf = (isint(fcols)) ? 0 :  I::OO[onlyfixed][S[fgroup].M:S[fgroup].X]*data[row][fcols]';
                if (inf<Zero) inf = N::F; //any negative value maps into N::F
                if (inf==curf ) {  //same fixed group
                    inmom |= data[row++][incol];   //add moments, increment row
                    continue;                        // don't install moments
                    }
                }
            else
                inf = NotInData;  //get out of loop after installing
            if (report) {
                    println("Reading moments for fixed group ",curf,". See log file");
                    fprintln(Data::logf,"Moments of Moments for fixed group:",curf);
                    }
            fptr->Empirical(inmom,hasN,hasT,MaxT);
            } while (inf==curf);
        } while(inf!=NotInData);
	delete source;
	}
