#include "GetStarted.ox"
#include "GetStartedData.ox"
#import "AllTest"
//#import "RustEmet1987new"
#import "RustEmet1987"
#import "RustEmet1987mle"
#import "WolpinJPE1984"
#import "WolpinEmet1987"
#import "KeaneWolpinREStat1994"
#import "KennetJAE1994"
#import "BerkovecSternEmet1991"
#import "GilleskieEmet1998"
//#import "ReEmpExp"
#import "IJCEmet2009"
#include "StataMNP.ox"
#include "TestGHK.ox"
//#include "TestSystemSolve.ox"
#import "MVNormal"
//#import "WstarTest"
#import "WstarTestb"
#import "DynamicWstar"
#import "AllTestOpt"
#import "AguirregabiriaMira2002"
//#import "MortTest"
#include "ClientServerTestA.ox"
#include "PeerCommunicationTestA.ox"

static const decl sep = "\n---------------------------\n";
enum{prompt,call,submenu}
static decl tests, reps;
