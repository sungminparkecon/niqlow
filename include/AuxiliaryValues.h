#import "DDPShared"

/** Base Class for variables related to outcomes.

<DT>Auxiliary variables are typically functions of the state and action vectors that would be observed in the data.<<

For example, in a search model, suppose the worker's ability <var>x</var> and the match quality <var>m</var> are
both unobserved, but the wage, <var> w = xm</var>, is observed.  Then an auxiliary variable can be created for wage, added to
the outcome and read in along with other data.

**/
struct AuxiliaryValue : Quantity {
    decl
        /** observed in external data . **/ indata;
	
            AuxiliaryValue(L="Aux");
	virtual Realize(y=0);
    virtual Likelihood(y=0);
    virtual Track(LorC);
	}

/**A wrapper around a function that returns an auxiliary value. **/
struct StaticAux : AuxiliaryValue {
            const decl      /** static function.**/ target;

    virtual Realize(y=0);
            StaticAux(L,target);
    }

/** Built-in variable that records realized utility.
$U(\alpha,\epsilon,\eta,\theta,\gamma)$
**/
struct RealizedUtility : AuxiliaryValue {
	        RealizedUtility();
	virtual Realize(y=0);
	}

/** An auxiliary value that is an indicator for values other actions or states.
**/
struct Indicator : AuxiliaryValue {
    const decl ttype, target, myval, iobj, iacted;

            Indicator(target,myval,iobj=UnInitialized,prefix=NotInData);
    virtual Realize(y=0);
    }

/** Create
**/
struct MultiIndicator : Indicator {
    MultiIndicator(target,myval,iobj,prefix);
    Realize(y=0);
    }


/** Add normal noise to a AV() compatible target, either linear or log-linear. **/
struct Noisy : AuxiliaryValue {
    const decl
        /** Object that is measured with noise.**/      truevalue,
        /** standard deviation of the normal nois.**/   sigma,
        /** noise is additive (not multiplicative).**/  Linear;
          decl
        /** implied normal value.**/                    eps;
    Noisy(truevalue,sigma=1.0,Linear=TRUE,Label="uknown");
    Realize(y=0);
    Likelihood(y=0);
    }
