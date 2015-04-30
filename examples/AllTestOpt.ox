#include "AllTestOpt.h"
/* This file is part of niqlow. Copyright (C) 2011-2015 Christopher Ferrall */

OptTestRun() {
decl s = "***************** ";
	println("\n\n",s,"A. Explore Test ",s,"\n");    new Nothing(20);
	println("\n\n",s,"A. Blackbox Test ",s,"\n");	BBTest();
	println("\n\n",s,"B. Simplex Test ",s,"\n");   SimpTest();
	println("\n\n",s,"C1. System Test ",s,"\n");    SysTest();
	println("\n\n",s,"C2. System Test With Line Max",s,"\n");  LMSysTest();
	println("\n\n",s,"D. Separable Test ",s,"\n"); SepTest();
	println("\n\n",s,"E. Inequality Test ",s,"\n"); InEqTest();
	println("\n\n",s,"F. Mixture Test ",s,"\n"); MixTest();
	}

Nothing::Nothing(Ncalls) {
    alphas = new Simplex("alph",3);
    Explore(this,Ncalls,alphas);
    }

Nothing::Solve() {
    println(".");
    }

Rosenbrock ::Rosenbrock (fn)	{
	BlackBox("Test of Blackbox");
	x = new Free("x",0.5);
	y = new Free("y",0.0);
    Parameters(x,y);
	if (!Load(fn)) Encode(0);
	}
Rosenbrock ::vfunc() {
	return -( sqr(1-x.v)+100*sqr(y.v - sqr(x.v)) );
//	return -( sqr(1-x.v)+sqr(y.v - sqr(x.v)) );
	}
BBTest() {
	println("\n\n  Black Box Rosenbrock Optimization");
	decl v = new Rosenbrock(-1);
	v.Volume = LOUD;
    decl alg;
	alg = new NelderMead(v);
	alg.Volume = NOISY;
	alg->Tune(0,0,10);
	alg->Iterate(0);
    delete alg;
    alg = new Newton(v);
	alg.Volume = NOISY;
//    alg.LM.Volume = NOISY;
    alg->Iterate(0);
	delete v,alg;
	}
	
SysTest() {
	println("\n\n  System of Equation ");
	decl v = new SystemTest (8),
		 nr = new NewtonRaphson(v),
		 br = new Broyden(v);
	format(250);
	v->ToggleParameterConstraint();
	nr.Volume = br.Volume = NOISY;
	br ->Iterate(0);
	nr ->Iterate(0);
	delete v,nr,br;
	}

LMSysTest() {
	println("\n\n  System of Equation with Line Minimization ");
	decl v = new SystemTest (1),
		 br = new Broyden(v);
	format(250);
	v->ToggleParameterConstraint();
    br.USELM = TRUE;
	br.LM.Volume = QUIET;
    br.Volume = NOISY;
    br->Tune(5);
	br ->Iterate();
	delete v,br;
	}	
	
SystemTest::SystemTest (N) {
	System("Broyden system test",N);
	x = new Coefficients("x",constant(0,1,N),0);
    Parameters(x);
	Encode(0);
	}

SystemTest::vfunc()	{
	return  (3-2*x.v).*x.v - lag0(x.v,1) - 2*lag0(x.v,-1) + 1;
	}

SepTest()	{
	println("\n\n Separable Objective Test");
	decl v = new SeparableRosenbrock(2),
		 nm = new NelderMead(v),
		 bfgs = new BFGS(v);
	nm.Volume = bfgs.Volume = v.Volume = LOUD;
	nm->Tune(0,0,40);
	nm->Iterate(0);
	bfgs->Iterate(0);
	delete v, nm, bfgs;
	}
	
SeparableRosenbrock ::SeparableRosenbrock (K)	{
	Separable("SepRosenbrock",K);
	x = new Free("x",1.01);
	y = new Free("y",0.98);
    Parameters(x,y);
//	CommonParameters(y);
	Encode(0);
	}

SeparableRosenbrock ::vfunc()	{
	 return -( sqr(1-x.v)+sqr(1-y.v) );
//	 return -( sqr(1-x.v)+100*sqr(y.v - sqr(x.v)) );
	}

InEqTest() {
	println("\n\n  SQP Optimization With an Inequality Constraint");
	decl v = new OnCircle(),
		 alg = new SQP(v);
    v.Volume=NOISY;
	alg.Volume = NOISY;
    alg->Tune(10);
	alg->Iterate(0);
	delete v,alg;
	}

OnCircle::OnCircle() {
//	Constrained("Stay on the Circle",{"2-x*x-y*y"},0);
	Constrained("Circle",1,0); //1,0
	x = new Positive("x",0.75);
	y = new Positive("y",0.75);
	Parameters(x,y);  //,z
	Volume= LOUD;
	Encode(0);
	}
	
//OnCircle::vfunc() {return -(sqr(AV(x)) + sqr(AV(y)));	}	
OnCircle::vfunc() {
//	decl a = sqr(AV(x)), b= sqr(AV(y)), c = sqr(AV(z));
//	decl ff = a+2*b+c+a*b+a*c;
//	return ff;
//    return ( 0.3*log(AV(x))+0.7*log(AV(y)) );
    return AV(x)^0.50 * AV(y)^0.50;
	}	

//OnCircle::equality() {
//	decl a = sqr(AV(x)), b= sqr(AV(y)), c = sqr(AV(z));
//	return (a+b+c)-25;
////	return 25-(a+b+c) | 56-(8*a+14*b+7*c) ;
//	}


OnCircle::equality() {
//	return matrix( 2*0.75-(AV(x)+AV(y)) );
	return matrix( 2*sqr(0.75)-(sqr(AV(x))+sqr(AV(y))) );
	}

SPobj::SPobj() {
	BlackBox("Simp");
	pi = new Simplex("pi",<0.25;0.25;0.5>);
    Parameters(pi);
	Encode(0);
	}
SPobj::vfunc() {
	return prodc(AV(pi).^(1/3));
	}

SimpTest() {
	println("\n\n  Simplex of Parameters ");
	decl v = new SPobj(),
	bfgs = new BFGS(v);
	v.Volume = bfgs.Volume = LOUD;
	bfgs->Iterate(0);
	delete v,bfgs;
	}
	
MX::MX() {
	decl myD = rows(pi),myK=columns(pi),d;  //columns(pi)+1 ???
	data = new array[myD];
	Mixture("Normal Mixture",myD,2,SimplexWeights,reshape(<0.4;0.6>,2,2));
	NvfuncTerms = N;
	Parameters(hatmu = new Coefficients("mu",<-1.0,0.88>,0));
	for (d=0;d<myD;++d) {
		data[d] = (ranu(N,1).<pi[d][0] .? mu[0] .: mu[1]) + sig*rann(N,1)  ;
		MyMoments(data[d]);
		}
	}
	
MX::vfunc() {
	return densn( (data[Dvar.v]-AV(hatmu)[Kvar.v])/sig )/sig;
	}

MixTest() {
	decl O = new MX(), d = new NelderMead(O);
	O->Encode(0);
	d.Volume = O.Volume = NOISY;
  	O->vobj(0);
	println("*** ",O.cur.v);
	d->Iterate(0);
	}
