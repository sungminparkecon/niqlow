#include "Data.h"
/* This file is part of niqlow. Copyright (C) 2011-2018 Christopher Ferrall */
#ifndef Dox
    #define Dox
    #include "Outcomes.ox"
    #include "Predictions.ox"
#endif

PathPrediction::SimulateOutcomePaths(curfpanel,N,ErgOrStateMat) {
    pathW = <>;
    cur = this;  //initialize to first prediction on the path.
    curfpanel -> FPanel::Simulate(N,UnInitialized,ErgOrStateMat,FALSE,this);
    if (!savemat("logs/flat_"+sprint("%02u",f)+".dta",pathW,tlabels[1:])) println("save of pathW failed");
//    savemat("logs/long_"+sprint("%02u",f)+".dta",curfpanel->FPanel::Flat(LONG),Panel::LFlat[LONG][1:]);
    pathW = variance(pathW);
//    savemat("logs/var_"+sprint("%02u",f)+".dta",pathW);
    pathW = invertgen(pathW,1);
    println("PathW ",f," Dimension: ",rows(pathW)," Rank: ",rank(pathW));
    savemat("pathW_"+sprint("%02u",f)+".mat",pathW);
    }

PredictionDataSet::SimulateMomentVariances(N,ErgOrStateMat) {
    decl simdata = new Panel(0,method),logdet,Tmax,scur,old;
    scur = simdata;
    decl fcur=this;
    do {
        fcur->SimulateOutcomePaths(scur,N,ErgOrStateMat);
        old = scur;
        scur = scur.fnext;
        old->~FPanel();   // delete previous simulations
        } while( isclass(fcur=fcur.fnext) );
    delete simdata;
    }
/*
PathPrediction::PathWlabels() {
    plabels = {};
    decl m,n;
    foreach(m in tlist[n])
        if (m.LorC!=NotInData && !isnan(cur.empmom[n])) {  // unmatched moments always have .NaN
    if (sizeof(plabels)) plabels |= m.obj.L+"_"+sprint("%2.0d",cur.t); else plabels = {m.obj.L+"_"+sprint("%2.0d",cur.t)};
    }
*/
PathPrediction::AppendSimulated() {
    decl m,tflat = <>,n;
   foreach(m in tlist[n])
        if (m.LorC!=NotInData && !isnan(cur.empmom[n])) {  // unmatched moments always have .NaN
            switch_single (TypeCheck(m.obj,ilistnames)) {
                case AuxInt   : tflat ~= AV(m.obj);  //simout.chi[m.obj.pos];
                case ActInt   : tflat ~= Alpha::aA[m.obj.pos];
                case StateInt : tflat ~= AV(m.obj);  //simout.state[m.obj.pos];
                default:
                }
            }
    if (!(cur.t))                  // start of new simulated path
        flat = tflat;
    else
        flat ~= tflat;
    if (isclass(cur.pnext)) {      // not end of empirical path
        cur = cur.pnext;
        return FALSE;
        }
    else {  // reset to 0
        pathW |= flat;  // flat reset on next 0
        cur = this;
        return TRUE;
        }
    }
