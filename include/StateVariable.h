#import "DDPShared"
/* This file is part of niqlow. Copyright (C) 2012-2023 Christopher Ferrall */

		/** . elements of array returned by `StateVariable::Transit` @name TransOutput **/
enum {Qind,Qprob,TransOutput}

static StripZeros(trans);

/**Base Class for elements of state vectors, $\epsilon$, $\eta$, $\theta$, $\gamma$ .

@see DP::ExogenousStates, DP::EndogenousStates, DP::SemiExogenousStates,  DP::GroupVariables, StateBlock
**/
struct StateVariable : Discrete	{
	StateVariable(L="s", N=1);
    const decl
    /** Trim unreachable states if finite horizon clock is detected.
        <b>Default is FALSE.</b>
        @see StateVariable::IsReachable **/ Prune;
	decl
	/** A vector of values that end decision making
		Equal to &lt; &gt; if state is not terminating.      **/     TermValues;
	MakeTerminal(TermValues);
	static  IsBlock(sv);
	static  IsBlockMember(sv);		
	virtual Transit();
	virtual UnChanged();
    virtual IsReachable();
    virtual Check();
    virtual myAV();
    Track(LorC);
	}
	
/**Container for single state variables with a statistically independent transition.

<DT>A state variable <code>q</code> is <em>autonomous</em> when:</DT>
<DD>Its conditional transition to the next value <code>q<sup>'</sup></code> is independent of all other transitions.  </DD>
<DD>That is, its transition $P_q(q^{\,\prime}; \alpha,\theta,\epsilon)$ is statistically independent of all other
transitions.</DD>
<DD>An autonomous <code>q</code> is not necessarily independent of another state variable <code>s</code> because both
transitions can depend on the current state and actions.</dd>
<DD>So <em>autonomous</em> means independent conditional on all current state variables values and actions.</DD>
<DT>The counterpart to an autonomous state variable is a `Coevolving` one</DT>


@see Coevolving
**/
struct Autonomous : StateVariable { }

/** A container class for state variables with a non-random transition.

<span class="n">DDP</span> makes no distinction between random and non-random state variables except
to organize different kinds of transitions into a taxonomy.

A non-random state variable has a transition which is 0 for all possible states except one, for which
it equals 1. Its state next period is determined by the current state and action.

@example
<code>q</code> counts how many times another state variable <code>s</code> has equalled 1 in the past.  Since
the current value of <code>s</code> is known, the value of <code>q</code> next period is (conditionally)
deterministic.
As a transition function:
$$q' = q + I\{s=1\}.$$
As a transition probability:
$$P(q'; q,s) = I\{ q' = q + I\{s=1\} \}.$$
</dd>
**/
class NonRandom : Autonomous { }


/** State variables with a non-determinisitic transition.

<span class="n">DDP</span> makes no distinction between random and non-random state variables except
to organize different kinds of transitions into a taxonomy.

A random state variable has a transition which is not always 0/1 .

Its value next period is determined stochastically by the current state and action.

**/
class Random : Autonomous	{ }

/** A binary random state variable that goes from 1 to 0 with
a `AV`-compatible probability and goes from 0 to 1 based on
the value of an action or a `CV`-compatible object.

**/
class RandomSpell : Random {
    decl ProbEnd,
         Start,
         pbend,
         pbstart;
    RandomSpell(L,ProbEnd=0.5,Start=1);
    IsReachable();
    Transit();
    }

/** State variables that augment another state variable (the base) or otherwise specialize it.

An Augmented state variable has a transition that is based on another state variable's transtion.

For example, the `Triggered` state variables have a transition that is the same as the base variable sent
when defining the augmented state variable unless a triggering condition is met.  In that case the
value next period is a special one that is not what the base transition would be.

The virtual IsReachable() for Augmented state variables is to return the base IsReachable() value.

**/
class Augmented : StateVariable {
    const decl /**base state variable.**/ b;
    decl
    /** Holds the base transition. **/ basetr;
            Augmented(Lorb,N=0);
            Synch();
    virtual Transit();
    virtual IsReachable();
    virtual Update();
    virtual SetActual(MaxV=1.0);
    }

/**A member of a state block: transition of this variable depends on transition of one or more other state variables.

@comment Coevolving variables do not have their own Transit() function.  Instead they
		 sit in a `StateBlock` that has a Transit().

@see StateBlock, Autonomous, StateBlock::AddToBlock
**/
struct Coevolving : StateVariable {
	/** StateBlock that I belong to  **/		decl block;
	/** Index into block array/vector **/    	decl bpos;
	Coevolving(Lorb, N=1);
    Transit();
    virtual myAV();
	}

/** Container for augmented state variables in which a value or an action trigger a transition
not present in the base state.
**/
class Triggered : Augmented {
    const decl /**triggering action or value.**/    t,
                /** triggering values.**/           tv,
                /** reset value of state.**/        rval;
    decl
        /** . @internal **/         ft,
        /** . @internal **/         idx,
        /** . @internal **/          idy,
        /** . @internal **/          rv,
        /** . @internal **/          nf;

            Triggered(b,t,tv=0,rval=0);
    virtual Update();
    }

/**  A state variable that augments a base transition so that the value of an action variable triggers this state to transit to a value.
    <DT>Let</DT>
    <dd><code>q</code> denote this state variable.
    <DD><code>b</code> be the base state variable to be agumented  (not added to model itself)</DD>
    <DD><code>a</code> be the action variable that is the trigger</DD>
    <DD><code>t</code> be the value of <code>a</code> that pulls the trigger.</DD>
    <DD><code>r</code> be the value to go to when triggered.</DD>

$$P(q^\prime =z ) = (1-I\{a\in t\}) Prob( b^\prime=z ) + I\{a \in t\}\}r$$

@example
<pre>
</pre></dd>

**/
class ActionTriggered : Triggered {
    ActionTriggered(b,t,tv=1,rval=0);
    virtual Transit();
    }

/** A state variable that augments a base transition so that the value of a `AV`()-compatible object triggers this state to transit to a special value.
    <DT>Transition.  Let</DT>
    <dd><code>q</code> denote this state variable.
    <DD><code>b</code> be the base state variable to be agumented (not added to model itself)</DD>
    <DD>
    <code>s</code> be the trigger object</DD>
    <DD><code>t</code> be the value of <code>s</code> that pulls the trigger.</DD>
    <DD><code>r</code> be the value to go to when triggered.</DD>
    <DD><pre>
    q&prime; = I{a&ne;t} b&prime; + (1-I{s==t}}r
    </pre></DD>
@example
<pre>
</pre></dd>

**/
class ValueTriggered : Triggered {
    ValueTriggered(b,t,tv=TRUE,rval=0);
    virtual Transit();
    }

/** When the trigger is 1 the transition resets to 0, otherwise it is the base.

A special case of `ActionTriggered` in which 1 is the trigger and the special reset value is 0.

If the trigger takes on more than two values only the value of 1 is the trigger.

**/
class Reset : ActionTriggered {
    Reset(b,t);
    }

/** A state variable that augments a base transition so that with some probability it
takes on a special value next period.

The difference with `ValueTriggered` is that this transition is random as of the current state
but `ValueTriggered` the transition is deterministic.

<DT>Transition. Let</DT>
<dd><code>q</code> denote this state variable.
<DD><code>b</code> be the base state variable to be agumented </DD>
<DD><code>&tau;</code> be the actual value of the trigger probability.</DD>
<DD><code>r</code> be the value to go to when triggered.</DD>
<DD><pre>
Prob( q&prime;= z | q,b ) =  &tau;I{z=r} + (1-&tau;)Prob(b&prime;=z)
</pre></DD>

@example
A person is employed at the start of this period if they chose to work last period and they were not randomly laid off between
periods, with a dynamically determed lay off probability.
<pre>
a = ActionVariable("work",2);
lprob = new Probability("layoff prob",0.1);
m = RandomTrigger( new LaggedAction("emp",a),lprob,0);
</pre>
</dd>

**/
class RandomTrigger : Triggered {
    RandomTrigger(b,Tprob,rval=0);
    virtual Transit();
    }

/** When a permanent condition will occur next period because an action is chosen now this state permanently becomes equal to its reset value.
This class provides a replacement for `StateVariable::IsReachable`() that trims the state space &Theta;
because only cases of the target equal to tv and this variable equal to its rval are reachable.
@comments
This state variable is designed to collapse the state space down when an event is triggered.
**/
class Forget : ActionTriggered {
    const decl FCond;
    Forget(b,t,FCond,tv=1,rval=0);
    virtual Transit();
    virtual IsReachable();
    }

/** Forget values when t==T (effective next time period).
@comments
This state variable is designed to collapse the state space down when an event is triggered.
**/
class ForgetAtT : ValueTriggered {
    const decl T;
    ForgetAtT(b,T);
    Transit();
    IsReachable();
    }

/** Unfreeze a froze variable under some condition.**/
class UnFreeze : Triggered {
    decl
        unf,
        g,
        idist;
            UnFreeze(base,trigger);
    virtual Transit();
    virtual InitDist();
    }

/** When the trigger value returns TRUE this state freezes at its current value.
**/
class Freeze : ValueTriggered {
    Freeze(b,t);
    virtual Transit();
    }

/** Let a state variable transit only in one sub-period of a Divided clock.
**/
class SubState : ValueTriggered {
    decl /** substate I transit in.**/  mys;

            SubState(b,mys);
    virtual Transit();
    virtual IsReachable();
    }

/** A Basic Offer Variable.
Acceptance of an offer is the action variable passed as Accept
If accepted, the state next period is the current offer.
Otherwise, offer occurs with a probability Pi.v values 1 ... N-1 equally likely.
Value of 0 indicates no offer (prob. 1-Pi.v)
Acceptance is a value of 1 in the AcceptAction.pos column of FeasAct
**/
struct Offer : Random	{
	const decl
	  /** &pi; Double, Parameter or static function, offer probability **/ 	Pi,
	  /**`ActionVariable` - indicates aceptance       **/ 	                Accept;
        decl offprob, accept;
	          Offer(L,N,Pi,Accept);
	  virtual Transit();
	  virtual Update();
	}

struct LogNormalOffer : Offer {
	const decl pars ;
	LogNormalOffer(L,N,Pi,Accept,pars=<0.0;1.0>);
	virtual Update();
	}

/**A Markov process.

<DT>Definition: A Markov state variable <code>q</code> is an autonomous random variable </DT>

<DD>whose a transition depends (at most) on its own current value.</DD>
<DD>That is, its transition does not depend on either the values of other state variables or the current action vector.</DD>
<DD>Because <code>q</code> is discrete and the transition to <code>q'</code> can only depend on <code>q</code>,
the transition is a square matrix.</DD>
<DD>Note that elements of the transition matrix do not have to be constant values.  They can be parameters or
functions of parameters that are evaluated each time the problem is solved,</DD>
<DD>The <span class="n">FiveO</span> function <a href="../FiveO/Parameters.ox.html#TransitionMatrix">TransitionMatrix</a>
will create and return an array of simplexes which can be sent as the transition matrix in the general Markov case.</DD>

<DT>Transition:</DT>

The transition must be square.  The number of values it takes is determined by the dimension of the column or vector.

If it is a matrix, then the rows are next period states and the columns are currents.
$$P(s'=z|s) = \Pi_{zs}$$
To be handled properly the state variable must be placed in the endogenous state vector $\theta$.

@example
A 3x3 transition matrix.
<pre>
  decl tmat =< 0.90 ~ 0.09 ~0.05;
               0.02 ~ 0.80 ~0.3;
               0.08 ~ 0.01 ~0.11>
  x = new Markov("x",tmat);
  EndogenousStates(x);
</pre></dd>

See <a href="../FiveO/Parameters.ox.html#TransitionMatrix">TransitionMatrix</a>
@see Offer
**/
struct Markov : Random {
	const decl	Pi;
    decl jprob;
		Markov(L,Pi);
		virtual Transit();
     }

/**A discrete IID process.

<DT>Transition:</DT>
$$P(s'=z|s) = \Pi_{z}$$

@example
<pre>
decl health = new IIDJump("h",<0.1;0.8;0.1>);
</pre>
</dd>

@comments Unlike a general Markov variable, a IIDJump is eligible to be an Exogenous variable, a member of $\epsilon$
added to the model with `DP::ExogenousStates`.

**/
struct IIDJump : Markov {
            IIDJump(L,Pi);
    virtual Transit();
    }	

/** A binary IID process.  It accepts a scalar as the transition.

<DT>Transition:</DT>
$$\displaylines{
P(s'=1|s) = \pi\cr
P(s'=0|s) = 1-\pi\cr
} $$


@example
A job offer is available with an estimated probability with an initial value of 0.6:
<pre>
decl poff = new Probability("op",0.6);
decl hasoffer = new IIDBinary"off",poff);
</pre></DD>

**/
struct IIDBinary : IIDJump {
            IIDBinary(L,Pi=0.5);
    virtual Transit();
    }

/** A variable **/
struct BirthAndSex : Random {
    const decl
            /**Binary ActionVariable.**/ b,
            /**2x1 proportions.**/       ratios;
    BirthAndSex(L,b,ratios);
    Transit();
    }

/** Equally likely values each period (IID).

<DT>Transition:</DT>
$$P(s' = z) = {1\over N} $$

**/
struct SimpleJump : IIDJump {
	SimpleJump(L,N);
	Transit();
	}

/**A variable that jumps to a new value with probability &pi;, otherwise stays the same.

<DT>Transition:</DT>
$$P(s'=z|s) = \pi / N  + (1-\pi)I\{z=s\}.$$

@example
</dd>

@see SimpleJump, Offer
**/
struct Jump : Markov 	{
	/**parameter for jump probability &pi; **/	 	const decl	Pi;
		Jump(L,N,Pi);
		virtual Transit();
	}

/** A placeholder for variables to be added to the model later.

This class is used internally  so that no subvector is empty.  It takes on the value 0 each period.
Since it takes on only one value it does not affect the size of state spaces, only the
length of the state vector.

The user might want to add a fixed variable to the model as placeholder for a state variable that
is not coded yet.  For example, if in the complete model <code>q</code> is a complex new state
variable that will require coding of a new <code>Transit()</code> function, then you made start
with <code>q</code> as a Fixed so formulas involving it can be completed.
**/
struct Fixed : Random {
	Fixed(L);
	Transit();
	}
	
/**A state variable that can stay the same, increase by 1 or decrease by 1.
<DT>Transition:</DT>

$$\eqalign{
    P(s^\prime = s-1) &= I\{s\gt0\}\Pi_0\cr
    P(s^\prime = s)   &=  \Pi_1 + I\{s=0\}\Pi_0 + I\{s=N-1\} \Pi_2\cr
    P(s^\prime = s+1) &=  I\{s\lt N-1\}\Pi_2\cr}$$

$\Pi$ can be a vector, a <code>Simplex parameter block</code> or a static function that returns a 3&times;1 vector.

@example  In Wolpin (1984), the stock of children (M), fertility choice (i) and
neonatal infant mortality are modeled as:
<pre>
Fertility : FiniteHorizon	{
	static decl q, i, M, x;
	static Mortality();
	}
Fertility::Initalize()	 {
	q = new Coefficients("q",);
	Actions(i = new Action("i",2));
	EndogenousState( M = new RandomUpDown("M",20,Fertility::Mortality) );
	}	
Fertility::Mortality()	{
	decl p = probn(x*q);  // x has to be updated using current age and other x values.
	decl ivals = CV(i);
	return 0 ~ (1-p*ivals) ~ p*ivals;
	}</pre></dd>
**/
struct RandomUpDown : Random	{
    enum { down, hold, up, NRUP}
	const decl fPi;
    decl fp;
	RandomUpDown(L,N,fPi,Prune=TRUE);
	virtual Transit();
    virtual IsReachable();
	}
	

/** A binary variable to code an absorbing state.
This transition from 0 to 1 happens with probability fPi, and
the transition 1 to 1 happens with probability 1.

@see PermanentChoice
**/
struct Absorbing : Random {
    const decl fPi;
    decl p;
    Absorbing(L="",fPi=0.5);
    Transit();
    }

/** A jump variable whose acutal values are quantiles of the normal distribution, $N(\mu,\sigma)$.
**/
struct Nvariable : SimpleJump {
    decl pars;
	Nvariable(L,Ndraws,pars=<0;1>);
	virtual Update();
	}

/** A single IID jump variable which will return a simulated vector of correlated normal variates.

<DT>How does this compare to  `MVNormal`?</DT>
<DD>Both are used to represent a normal vector of length $M$: $x \sim N(\mu,\Omega)$</DD>
<DD>The latter creates a block of $M$ correlated state variables. Each one takes on $N$ values.  So
a total of $M^N$ points are created.  For more than 2 or 3 dimensions this either makes the state space
very large or the approximization very coarse.</DD>

<DD>This state variable uses a given number of pseudo-random draws, $N.$  It is based on a fixed draw of $N\times M$
IID standard normal draws which are transformed by the mean and CHolesky matrix to produce $N\times M$ correlated
normals.</DD>

This variable needs to be used with care: <code>CV()</code> will return a single value which is the index between 0 and N-1.
<code>AV()</code> returns the $1\times M$ vector that corresponds to the index.

**/
struct MVNvectorized : Nvariable {
    decl zvals, Ndim, vecactual;
	MVNvectorized(L,Ndraws,Ndim,pars,seed=0);
	Update();
    myAV();
	}

/** A jump variable whose acutal values are quantiles of the standard normal distribution.
**/
struct Zvariable : Nvariable {
	Zvariable(L,Ndraws);
	//virtual Update();
	}

/** A IID jump variable whose actual values are quantiles of the exponential distribution
with decay rate $\gamma$.**/
struct Xponential : SimpleJump {
    const decl gamma;
	Xponential(L,Ndraws,gamma=1);
	Update();
	}

/** Base class for variables that take on previous values of other states or actions.

$$s^\prime = CV(Target).$$

@see LaggedState, LaggedAction
**/
struct Lagged : NonRandom	{
    const decl
	/**Variable to track. **/          Target,
    /**Order of lag (for pruning).**/  Order;
	        Lagged(L,Target,Prune=TRUE,Order=1);
	virtual Update();
	virtual Transit();	
    virtual IsReachable();
	}
	
/** Take on the current value of another state variable.

Note the Target variable must be in $\eta$ or $\theta$. It canot be added to $\epsilon$.

<DT>Transition:</DT>
$$s' = CV(Target).$$

@see LaggedAction, DP::KLaggedState
**/
struct LaggedState : Lagged	{
	LaggedState(L,Target,Prune=TRUE,Order=1);
	virtual Transit();	
	}

/** Take on the current value of an action variable.

<DT>Transition:</DT>
$$s^\prime = CV(Target).$$

<DT>IsReachable</DT>
<DD>The default initial value is <code>0</code>, so for finite horizon clocks, <code>t=0,q&gt;0</code>
is marked unreachable.   Set <code>Prune=FALSE</code> to not prune these unreachable states automatically.</DD>

@see LaggedState, DP::KLaggedAction
**/
struct LaggedAction : Lagged	{
    decl acol, nxtv;
	LaggedAction(L,Target,Prune=TRUE,Order=1);
	virtual Transit();
	}

/** Record the value of an action variable at a specified time.
<DT>Transition:</DT>
$$s' = \cases{ 0 & if t less than Tbar\cr
               Target.v & if t equals Tbar\cr
               s & if t greater than Tbar\cr}$$

<DT>IsReachable</DT>
<DD>Non-zero states are trimmed as unreachable for <code>t&le; Tbar</code></DD>
@example
<pre>
  d = new BinaryChoice("d");
  d5 = new ChoiceAtTbar("d5",d,5);
  EndogenousStates(dvals);
</pre>
Track the first four choices of d:
<pre>
  dvals = new array[4];
  decl i;
  for(i=0;i<3;++i) dvals[i] = new ChoiceAtTbar("d"+sprint(i),d,i);
  EndogenousStates(dvals);
</pre>
</dd>

@see LaggedState, DP::KLaggedAction
**/
struct ChoiceAtTbar :  LaggedAction {
    const decl Tbar;
	ChoiceAtTbar(L,Target,Tbar,Prune=TRUE);
	virtual Transit();
    virtual IsReachable();
    }

/** Record the value of an state variable q at a specified time, starting the following period.
<DT>Transition:</DT>
$$s' = \cases{ 0 & if t less than Tbar\cr
               Target.v & if t equals Tbar\cr
               s & if t greater than Tbar\cr}$$

<DT>IsReachable</DT>
<DD>Non-zero states are trimmed as unreachable for <code>t&le; Tbar</code></DD>

@see LaggedState, ChoiceAtTbar
**/
struct StateAtTbar :  LaggedState {
    const decl
            /** value of I::t to record at.**/  Tbar;

	        StateAtTbar(L,Target,Tbar,Prune=TRUE);
	virtual Transit();
    virtual IsReachable();
    }

/** Record if an action has ever been non-zero.

<DT>Transition:</DT>
$$s' = \cases{ 0 & if s==0 and CV(Target)==0\cr
               CV(Target) & if s==0 and CV(Target) $\gt$ 0\cr
               s & if s $\gt$ 0\cr}$$
**/
struct PermanentChoice : LaggedAction {
	PermanentChoice(L,Target,Prune=TRUE);
	Transit();
	}
	
/**	 Count periods value(s) of target action or state variable have occurred.
**/
struct Counter : NonRandom  {
	const decl
	/**Variable to track 				**/       Target,
	/**Values to track  				**/	      ToTrack,
	/**`AV`()-compatiable reset to 0 flag **/	  Reset;

	        Counter(L,N,Target,ToTrack,Reset,Prune=TRUE);
	virtual Transit();
    virtual IsReachable();
	}

/**	 Counts periods value(s) of target state <em>s.x</em> have occurred.

The values of <code>x</code> in $\tau$ (ToTrack)

<DT>Transition:</DT>

$$s' = s+I\{ CV(x) \in tau\}I\{s \lt N-1\}.$$

@example
<pre>
decl wks  = new ActionState("wksunemp",work,10,<0>); //track up to 10 years
EndogenousStates(wks);</pre></dd>
**/
struct StateCounter : Counter  {
	StateCounter(L,N,Target,ToTrack=<1>,Reset=FALSE,Prune=TRUE);
	virtual Transit();
}


/**	 Responsible for tracking reachability in a list of state counters for a target.

**/
struct StateCounterMaster: StateCounter  {
    decl CVSList;
	StateCounterMaster(L,N,Target,ToTrack);
	IsReachable();
    }


/**	 Track number of periods value(s) of target action variable have occurred.

<DT>Transition:</DT>

$$s' = s+I\{ CV(x) \in tau\}I\{s \lt N-1\}.$$

@example
<pre>
decl exper = new ActionCounter("Yrs Experience",10,work); //track up to 10 years working
EndogenousStates(exper);
</pre></DD>

**/
struct ActionCounter : Counter  {
    decl inc;
	ActionCounter(L,N,Target,ToTrack=<1>,Reset=FALSE,Prune=TRUE);
	virtual Transit();
	}

struct ActionCounterMaster: ActionCounter  {
    decl CVSList;
	ActionCounterMaster(L,N,Target,ToTrack);
	IsReachable();
    }


/**	 Add up the values of the target action or state up to a maximum.
<DT>Transition:</DT>
<dd class="math"><pre>
s' = min( s+ s.a, s.N<sup>-</sup>).
&Rho;(s'=z | &alpha;,&epsilon;, &theta;,&psi;) = I{z = min(s + s.a,s.N<sup>-</sup>) }.
</pre></dd>
**/
struct Accumulator : NonRandom  {
	const decl
	/**Variable to track 				**/  Target;
	Accumulator(L,N,Target);
	virtual Transit();
	}

/**	 Add up the values of a target action up to a maximum.
<DT>Transition:</DT>
@example
<pre>
decl tothrs = new ActionAccumulator("TotHrs",work,10);  //track work up to 10 hours
EndogenousStates(tothrs);
</pre></dd>
**/
struct ActionAccumulator : Accumulator  {
    decl x,y;
	ActionAccumulator(L,N,Target);
	virtual Transit();
    }

/**	 Add up the values of the target state.
<DT>Transition:</DT>
<dd class="math"><pre>
s' = min( s+ s.x, s.N<sup>-</sup>).
&Rho;(s'=z | &alpha;,&epsilon;, &theta;,&psi;) = I{z = min(s + s.x,s.N<sup>-</sup>) }.
</pre></dd>
@example
<pre>
decl totoff = new StateAccumulator("Total Offers",noffers,10);  //track total offers received up to 10
EndogenousStates(totoff);
</pre></DD>
**/
struct StateAccumulator : Accumulator  {
	StateAccumulator(L,N,Target);
	virtual Transit();
    }

/** Track number of consecutive periods an action or state variable has had the same value.

This variable requires a target s.X and the lagged value of the target, denoted s.Lx.
<DT>Transition:</DT>
$$s' = I\{ x = Lag(x)\}(s+ I\{s \lt N-1\}).$$
@example
<pre>
</pre></DD>
**/
struct Duration : Counter {
	const decl Current, Lag, isact, MaxOnce;
	decl add1, g;
	Duration(L,Current,Lag,N,MaxOnce=FALSE,ToTrack=DoAll,Prune=TRUE);
	virtual Transit();
	}

/** Store a new offer or retain its current value.
<DT>Transition:
<dd class="math"><pre>
s' = .
</pre></dd>
@example
<pre>
</pre></dd>
**/
struct RetainMatch : NonRandom {
	const decl matchvalue, acc, replace, keep;
	decl i, repl, hold;	
	RetainMatch(matchvalue,acc,replace,keep);
	virtual Transit();
	}	
	
/** A state variable with a general non-random transition.
The number of points the variable takes on equals the length of the second argument to
the creator function.
**/
struct Deterministic : NonRandom
	 {
	 /** matrix with transition. **/ decl nextValues;
	 Deterministic(L,nextValues);
	 virtual Transit();
	 }

/** Increments each period up to N&oline; then returns to 0.
<DT>Transition</DT>
$$s' = I\{s\lt N-1\}(s+1)$$
@example
<pre>
decl qtr = new Cycle("Q",4);
EndogenousStates(qtr);</pre></DD>
**/
struct Cycle : Deterministic { Cycle(L,N); }

/** Increments randomly based on Pi then returns to 0 if reset=1.
 is the reset action. $\Pi$ is the vector of non-zero increment probabilities.
<DT>Transition:</DT>
<DD>If $s\lt N-1-K$ then</DD>
$$Prob(s^\prime = (1-A)s+k ) = \Pi_k.$$
<DD>Otherwise,</DD>
$$Prob(s^\prime = N-1 ) = \sum_{k=N-s-1}^K \Pi_k.$$
@example
Rust (1987) is set up as
<pre>
Zurcher : Ergodic	{
	static decl q, i, x;
    &vellip;
	}
Zurcher::Initialize()	{
    &vellip;
	q = new Simplex("q",3);
	AddVariable(i = new Action("i",2));
	EndogenousState( x = new Renewal("x",90,i,q) );
    &vellip;
	}
</pre></dd>
**/
struct Renewal : Random {
	const decl
	/** state or action that resets the process to 0 **/ reset,
	/** block or vector of increment probabilities **/	 Pi,
	/** length of Pi                               **/   P;
	Renewal(L,N,reset,Pi);
	virtual Transit();
	}

/**Indicates a state or action took on particular values last period.
@see StateTracker, ActionTracker
**/
struct Tracker : NonRandom {
	const decl
	/**Variable to track **/ Target,
	/**Values to track  **/	 ToTrack;
	Tracker(L,Target,ToTrack,Prune=TRUE);
    IsReachable();
	}
	
/**Indicates another state variable took on a value last period.
Let <code>t</code> denote the state variable being tracked.  Let <code>r</code> denote
the value or vector of values to track.
<dd><pre>
q' = I{t &in; r}.
</pre></dd>
@see ActionTracker
**/
struct StateTracker : Tracker	{
	StateTracker(L,Target,ToTrack=<1>,Prune=TRUE);
	virtual Transit();	
	}

/**Indicates an action variable took on a value last period.
<dd><pre>
q' = I{a &in; r}.
</pre></dd>
@see StateTracker
**/
struct ActionTracker : Tracker	{
    decl d;
	ActionTracker(L,Target,ToTrack=<1>,Prune=TRUE);
	virtual Transit();
	}

/** Indicator for a condition (ever) occuring in the past.
**/
struct PermanentCondition : StateTracker {
    PermanentCondition(L,Target,ToTrack=<1>,Prune=TRUE);
	virtual Transit();
    }

/** A Block of `Coevolving` state variables.

**/
struct StateBlock : StateVariable {
	decl
	/** temporary list of states. @internal **/ 	Theta,
	/** matrix of all <em>current</em> values **/	Allv,
    /** matrix of all <em>actual</em> values.**/    Actual,
    /** vector <0:N-1>, used in AV().**/            rnge;
	StateBlock(L,...);
	AddToBlock(...);
//    Clones(N,base);
	virtual Transit();
    virtual Check();
    virtual myAV();
    virtual Update(curs,first);
	}



/**A combination of an `Offer` state variable and a status variable, <var>(w,m)</var> .

If unemployed an offer was generated with prob. &phi;.  The agent can accept an offer and become employed or reject and
continue searching again next period.  If employed the agent can quit or can be laid off with probability &lambda; or keep their job.

If quit or laid off last period, the offer stays the same for one period but transition to employment is impossible.  This
allows the previous wage to be captured and used in a block derived from this.

&phi; and &lambda; can depend on (w,m) and on &alpha;

<dd class="example"><pre>
(w,m)
m &in; `OfferWithLayoff::Status`
If m=Unemp:
   w&prime; =
   	   w with prob. a
       0 with prob. (1-a)(1-&phi;) or 1 ... N-1 with prob. (1-a)&phi;
   m&prime; = aEmp + (1-a)Unemp;
If m=Emp,
   w&prime; = w
   m&prime; =
        (1-a)Quit
		aLaidOff with prob. &lambda;
		aEmp with prob. 1-&lambda;
If m=Quit or LaidOff,
	m&prime; = Unemp
	w&prime; same as m=Unemp and a=0
</pre></dd>

@see Offer
**/
struct OfferWithLayoff : StateBlock    {
	/** Status values. @name Status **/ enum{Unemp,Quit,LaidOff,Emp,Nstatus}
	const decl
		/**Job Offer Probability **/        	Pi,
		/**Probability of reverting to 0 **/	Lambda,
		/** Number of offers. @internal	**/     NN,
		/**Action to accept offer**/ 			accept,
		/** Variable containing offer index**/	offer,
		/** searching, just laid off,
			currently holding	**/ 			status;
	Employed();
	Searching();
	OfferWithLayoff(L,N,accept,Pi,Lambda);
	virtual Transit();
	
	}

/** Component of a multi-dimensional normal StateBlock.**/
struct NormalComponent : Coevolving	{
	NormalComponent(L, N);
	}
	
/**  Container for a block of discrete multivariate IID variables (can be contemporaneously correlated).
**/
struct MVIID : StateBlock {
    const decl
	/**Number of points per variable   **/      M,
    /**total number points in the block. **/    MtoN;
	MVIID(L,N,M,base=0);
	virtual Transit();
	// Default should work?? virtual Update(curs,first);
    }

/** A discrete multivariate normal IID block of contemporaneously correlated variables.

<dd><var><pre>
x &sim; N( &mu;, C'C ).
</pre></var>
**/
struct MVNormal : MVIID {
    const decl
    /** matrix of Z vals for simulated actual values**/  zvals,
     /** . @internal**/                                  mind,
	/** vector of means &mu; **/ 					     mu,
	/** `AV`()-compatible vector-valued object which returns
        <code>vech()</code> for lower triangle of C, the Choleski decomposition
        of the variance matrix &Omega;, &Omega; = CC'.
        **/                                             CholLT;
	        MVNormal(L,N,M, mu,CholLT);
	virtual Update(curs,first);
    //virtual myAV();
	}

/** Re-occuring epsiodes with endogenous onset and ending probabilities.
The block has to coevolving states, <code>k</code> and <code>t</code>, the type of
episode and duration.  Duration is not tracked for k=0.  New episodes occur with <code>Onset</code> probability and end with
<code>End</code> probability.
@comments Based on illness episode in Gilleskie (1998).
**/
struct Episode : StateBlock {
	const decl
			/** episode onset probabilities **/ Onset,
			/** episode end  probabilities **/ 	End,
			/** all spells end at t=T-1.**/ 	Finite,
			/** `Coevolving`, current type
				of episode **/					k,
			/** `Coevolving`, duration of episode,
				NOT tracked for k.v=0 **/		t;
	decl
		/**Stores end probability at t=T-1 for non-Finite episodes **/ probT;
	Episode(L,K,T,StartProb,EndProb,Finite);
	virtual Transit();
	}

/** A one-dimensional correlated discretized normal process using Tauchen's approach.
@see MVNormal
**/
struct Tauchen : Markov {
	const decl
            /** @see NormalParams **/   pars,
            /** support.**/           M,
                                      gaps;
	decl rnge, pts, cp, Grid;
	Tauchen(L,N,M,pars=IIDZpars);
	virtual Transit();
	virtual Update();
	}

/** Rouwenhorst approximation to discretized correlated normal value.
@see Tauchen
**/
struct Rouwenhorst : Tauchen {
    const decl Nrt;
	decl n,p,pp,cp,M, Grid;
	Rouwenhorst(L,N,pars=IIDZpars);
	virtual Update();
    virtual Transit();
    }

/** Discretized interest-bearing asset.
    The <code>actual</code> vector should either be set by the user after creation of the state
    variable (if the actual asset levels are fixed), or the user should define a derived class and
    provide an <code>Update()</code> method that will keep <code>actual</code> current based on
    dynamic changes in parameters.
    <dd>Let A be the <em>actual</em> current value, <code>actual[v]</code>.
    <pre>A* = min(  max( rA + S , actual[0] ), actual[N-1] )</pre>
    Define A<sub>b</sub> &le; A* &ge; A<sub>t</sub> as the <em>actual</em> values that
    bracket A* (they are equal to each other if A* equals one of the discrete actual values).
    Define m = (A<sub>b</sub>+A<sub>t</sub>)/2.
    Let <code>b</code> and <code>t</code> be the indices of the bracketing values.
    <pre>
    Prob(a&prime; = b) = (A-A<sub>b</sub>)/m
    Prob(a&prime; = t ) = 1 - Prob(a&prime;=b).
    </pre></DD>
**/
struct Asset : Random {
	const decl
    /** `AV`()-compatible object, interest rate on current holding.**/ r;
        decl
            /** @internal **/ atom,
            /** @internal **/ top,
            /** @internal **/ bot,
            /** @internal **/ mid,
            /** @internal **/ all,
            /** @internal **/ tprob,
            /** @internal **/ bprob;
	Asset(L,N,r);
	virtual Transit(pdelt);
	}

struct FixedAsset : Asset {
	const decl
    /** `ActionVariable`. **/     delta;
    FixedAsset(L,N,r,delta);
    Transit();
    }

struct LiquidAsset : Asset {
	const decl
    /** `AV`()-compatible static function or `ActionVariable`. **/     NetSavings,
                                                                     isact;
    LiquidAsset(L,N,NetSavings);
    Transit();
    }

/** A discretized version of a continous &zeta;.

value that enters the endogenous vector &theta; depending on reservation values to keep it.
A kept random discrete version of &zeta; enters the state as this variable.

Its value is constant as long as a state variable indicates it is being held.

**/
struct KeptZeta : Random {
    const decl keep, held;
//    static decl M, kern, cdf, df, midpt, A,b, Fdif, zspot;
    decl
    /** . @internal**/ df,
    /** . @internal**/  dist,
    /** . @internal**/  cdf,
    /** . @internal**/  zspot,
    /** . @internal**/   addst,
    /** . @internal**/   DynI,
    /** . @internal**/   DynR,
    /** . @internal**/   myVV,
    /** . @internal**/   NxtI,
    /** . @internal**/   NxtR,
    /** . @internal**/   isheld,
    /** . @internal**/   NOth;
    KeptZeta(L,N,keep,held);
    virtual Update();
    virtual CDF(z);
    virtual Quantile(u);
    virtual Transit();
    virtual DynamicTransit(z);
    virtual InitDynamic(cth,VV);
    }
