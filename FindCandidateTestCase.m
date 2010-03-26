#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

#import "DNCAppDelegate.h"
#import "RootViewController.h"
//#import "findCandidateController.h"
//#import "CLController.h"

@interface FindCandidateTestCase : SenTestCase{

	DNCAppDelegate *dncAppDelegate;
	UINavigationController *rootViewController;
	//findCandidateController *findcandidateContoller;
	//CLController *cLController;
	UIView *view;
}
@end

@implementation FindCandidateTestCase

-(void) setUp {
	dncAppDelegate = [[UIApplication sharedApplication] delegate];
	rootViewController = dncAppDelegate.navigationController;
	view = rootViewController.view;
}	

-(void) testDNCDelegate{
	//STAssertNotNil(dncAppDelegate, @"Cannot find the application delegate");
}
@end

	