#ifndef Vh
    #include "AuxiliaryValues.h"
#endif
/* This file is part of niqlow. Copyright (C) 2011-2023 Christopher Ferrall */

/** Create a new element of &chi;, the space of auxiliary outcomes.

@param L label

@see DP::AuxiliaryOutcomes

**/
AuxiliaryValue::AuxiliaryValue(L) {
	this.L = L;
	track = logf   = pos = UnInitialized;
    indata = FALSE;
	v      = .NaN;
    Volume = SILENT;
	}

/** Default realized auxililary variable, sets <code>v=1.0</code>.
@param y, the current realized outcome, &upsilon;.
**/	
AuxiliaryValue::Realize(y) {	v = 1.0; }

/** Default contribution to likelihood.
@param y, the current realized outcome, &upsilon;.
@return 1.0
**/	
AuxiliaryValue::Likelihood(y) { return 1.0; }

/** Realized utility, U().**/
RealizedUtility::RealizedUtility() { 	AuxiliaryValue("U"); 	}

RealizedUtility::Realize(y) {	
    I::curth->ThetaUtility();
    v = Alpha::aI!=UnInitialized ? I::curth->Utility()[Alpha::aI]
                                 : I::curth->Utility();	
    }

MultiIndicator::MultiIndicator(targlist,nvec,iobj,prefix) {
    decl t,i;
     this.target = targlist;
    this.myval = nvec;
    this.iobj = iobj;
    ttype = <>;
    foreach(t in targlist[i]) {
        ttype  |=  TypeCheck(t,ilistnames[:ActInt],TRUE);
        prefix |= "_"+sprint("%02u",nvec[i]);
        }
    if ((iacted = isclass(iobj))) {
        iacted = TypeCheck(iobj,ilistnames,TRUE);
        AuxiliaryValue(prefix+"_"+abbrev(iobj.L)); 	
        }
    else
        AuxiliaryValue(prefix); 	
    }
/** Create an indicator (or indicator interacted with another outcome).
@param target State or Action variable to create indicator value for
@param myval value to indicate
@param iobj integer (no indicator) or an outcome to interact.
@param prefix string for column matching or integer (not in data)
**/
Indicator::Indicator(target,myval,iobj,prefix) { 	
    ttype = TypeCheck(target,ilistnames[:ActInt],TRUE);
    if (!isint(myval)) oxrunerror("DDP Error. interaction value must be an integer");
    this.target = target;
    this.myval = myval;
    this.iobj = iobj;
    prefix = (isstring(prefix) ? prefix : abbrev(target.L))+"_"+sprint("%02u",myval);
    if ((iacted = isclass(iobj))) {
        iacted = TypeCheck(iobj,ilistnames,TRUE);
        AuxiliaryValue(prefix+"_"+abbrev(iobj.L)); 	
        }
    else
        AuxiliaryValue(prefix); 	
    }

Indicator::Realize(y) {
    decl aIU = Alpha::aI==UnInitialized;
    if (ttype==ActInt) {
        v = aIU ? (myval .== CV(target)) : (myval== target->myEV());
        }
    else
        v = myval==CV(target);
    switch(iacted) {
        case ActInt   : v .*= aIU ? AV(iobj) : iobj->myEV(); break;
        case AuxInt   : iobj->Realize(y);
                            v .*= iobj.v;
                            break;
        case StateInt : v .*= AV(iobj); break;
            default       : break;
        }
    }

MultiIndicator::Realize(y) {
    decl n,t,aIU = Alpha::aI==UnInitialized;
    v=1;
    foreach(t in target[n])
        if (ttype[n]==ActInt)
            v .*= aIU ? (myval[n] .== CV(t))  : (myval[n] == t->myEV());
        else
            v .*= myval[n]==CV(t);
    switch(iacted) {
            case ActInt   : v .*= aIU ? AV(iobj) : iobj->myEV(); break;
            case AuxInt   : iobj->Realize(y);
                            v .*= iobj.v;
                            break;
            case StateInt : v .*= AV(iobj); break;
            default       : break;
            }
    }

/** Create an wrapper for a static function `AV`()-compatible object.
@param L label string<br/>integer: get label from
@param target static function of the form <code>target()</code><br>
**/
StaticAux::StaticAux(L,target) {
    AuxiliaryValue(L);
    this.target = target;
    }
StaticAux::Realize(y) {
    v = target();
    if (rows(v)>1 &&  Alpha::aI!=UnInitialized) v = v[Alpha::aC];
    }

/** Create an auxiliary value that adds normally-distributed noise to the actual value.
@param truevalue `AV`()-compatible object
@param sigma    `CV`()-compatible standard deviation
@param Linear TRUE error is additive<br/>FALSE error is multiplicative and log-normal
@param Label if truevalue does not have a L member this will be used
**/
Noisy::Noisy(truevalue,sigma,Linear,Label) {
    AuxiliaryValue("noisy-"+ (ismember(truevalue,"L") ? truevalue.L : Label ) );
    this.truevalue = truevalue;
    this.sigma=sigma;
    this.Linear=Linear;
    }

Noisy::Realize(y) {
    if (isclass(truevalue,"AuxiliaryValue"))
        truevalue->Realize(y);
    v = AV(truevalue);
    if (rows(v)>1 &&  Alpha::aI!=UnInitialized) v = v[Alpha::aC];
    eps = rann(1,1)*CV(sigma);
    v = Linear ? v+eps : exp(eps)*v;
    }

/** likelihood contribution of a noisy auxiliary value . **/
Noisy::Likelihood(y) {
    if (isnan(y.aux[pos])) return 1.0;
    if (isclass(truevalue,"AuxiliaryValue"))
        truevalue->Realize(y);
    v = AV(truevalue);
    if (rows(v)>1 &&  Alpha::aI!=UnInitialized) v = v[Alpha::aC];
    eps = Linear
            ? y.aux[pos]-v
            : log(y.aux[pos])-log(v);
    return densn(eps/CV(sigma))/CV(sigma);
    }
