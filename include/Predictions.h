#import "database"
#import "DP"
/* This file is part of niqlow. Copyright (C) 2012-2016 Christopher Ferrall */

/** Holds information about a column in the data.
**/
struct DataColumn : Zauxiliary {
	const decl type,
		 		obj,	
		 		force0;
	decl
		 obsv,
		 ind,
		 incol,
		 label;
	DataColumn(type,obj);
	Observed(LorC);
	UnObserved();
	ReturnColumn(dlabels,incol);
	}
	
/** Contains information on an object (variable, auxiliary outcome, etc) to be tracked.
**/
struct TrackObj : Zauxiliary {
    const decl
    /** Inherited fromt the object.**/  Volume,
    /** See `DataColumnTypes` **/       type,
    /** object can have a continuous
        dynamic distribution. **/       contdist,
    /** Position in the flat list  **/  pos,
    /** `Discrete` object**/            obj,
    /** label  **/                      L,
    /** column label of index **/       LorC;
    decl
    /** **/     hN,
    /** **/     hd,
    /** **/     hv,
    /** **/     hist,
    /** **/     hvals,
    /** **/     mean,
    /** **/     sqmean;
    static Create(LorC,obj,pos);
    TrackObj(LorC,obj,pos);
    virtual Reset();
    virtual Distribution();
    virtual Update();
    virtual print();
    }

struct oTrack : TrackObj {
    oTrack(LorC,obj,pos);
    Distribution(pobj);
    }
struct aTrack : TrackObj {
    aTrack(LorC,obj,pos);
    Distribution(pobj);
    }
struct sTrack : TrackObj {
    sTrack(LorC,obj,pos);
    Distribution(pobj);
    }
struct xTrack : TrackObj {
    xTrack(LorC,obj,pos);
    Distribution(pobj);
    }

/** Predicted distribution across states.
**/	
struct 	Prediction : Data {
	static	decl ud, lo, hi, LeakWarned, PredictFailure;
	const  	decl t;
	decl
		/** state index **/		             sind,
        /** index into sind.**/             q,
		/** **/					              p,
		/** Expanded ch. prob.**/	         ch,
        /** current ch. prob.**/            chq,
        /** current p. **/                  pq,
        /** masked weight to put on distance.**/        W,
        /** accumulated predicted moments across r **/  accmom,
        /** (unmasked) predicted moment vector**/       predmom,
        /** (unmasked) empirical moments. **/           readmom,
        /** used (masked) empiricalmoments.**/          empmom,
		/** next prediction
            in the path **/	         pnext;
	Prediction(prev);
    ~Prediction();
	Predict(tlist);
    Reset();
	Histogram(v,printit=FALSE);
    Delta(mask,printit=FALSE,tlabels=0);
	}

/** Predicted outcomes along a path.
**/
struct 	PathPrediction : Prediction {
	static	decl summand, upddens;
    const decl f, iDist;
	decl
    /** current index of random effects.**/         rcur,
    /** Empirical moments read in. **/              HasObservations,
    /** Predict() called before. **/                EverPredicted,
    /** Path length sent it.**/                     inT,
    /** .**/                                        prtlevel,
    /** list of objects to track.**/                tlist,
    /** labels of flat print. **/                   tlabels,
    /** indicator vector for observed moments.**/   mask,
    /** columns in data .     **/                   cols,
    /** the current prediction **/                  cur,
    /** length of the path. **/                     T,	
    /** flat prediction matrix.**/                  flat,
    /** Distance between predictions and emp.mom.**/ L,
    /** method to call for nested solution. **/		method,
                                                    first,
    /** the next PathPrediction   **/               fnext;
	PathPrediction(f=0,method=0,iDist=0);
    Initialize();

	~PathPrediction();
    InitialConditions();
	Predict(T=0,printit=FALSE);
    SetT();
    Empirical(inmoments,hasN=FALSE,hasT=FALSE,wght=TRUE);
    Tracking(LorC,...);
    SetColumns(dlabels,Nplace=UnInitialized,Tplace=UnInitialized);
    TypeContribution(pf=1.0,subflat=0);
    ProcessContributions(cmat=0);
	}

struct PanelPrediction : PathPrediction {
	const decl
	/** tag for the panel. **/ 				r,
    /** Weight Moments for GMM. **/         wght;
	decl
				        					fparray,
    /**length of vector returned by EconometricObjective.**/ FN,
                                             delt,
                                             aflat,
	/** array of GMM vector. **/	 	     M;
    PanelPrediction(r=0,method=0,iDist=0,wght=FALSE);
    ~PanelPrediction();
    Objective();
    Predict(T=0,printit=FALSE,subarr=0);
    Tracking(LorC,...);
    MaxPathVectorLength(inT=0);
    }

/** Stores data read in as moments and associate them with a panel of predictions.

**/
struct EmpiricalMoments : PanelPrediction {
    const decl /** label **/ label;
    decl
            /** **/                                                     flist,
            /** matrix of indices or array of labels or UseLabel  **/   UorCorL,
            /** observations column (index or label).**/                Nplace,
            /** time column (index or label).**/                        Tplace,
            /** **/                                                     FMethod;
    EmpiricalMoments(label="",method=0,UorCorL=UseLabel,iDist=0,wght=TRUE);
    Observed(as1,lc1=0,...);
    TrackingMatchToColumn(Fgroup,LorC,mom);
    TrackingWithLabel(Fgroup,InDataOrNot,mom1,...);
    Observations(NLabelorColumn,TLabelorColumn=UnInitialized);
    Read(fn);
 	virtual EconometricObjective(subp=DoAll);
    virtual Solve(subp=DoAll);
    }
