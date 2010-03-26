//
//  DNCAppDelegate.m
//  DNC
//
//  Created by krader on 3/23/10.
//  Copyright ThoughtWorks 2010. All rights reserved.
//

#import "DNCAppDelegate.h"
#import "RootViewController.h"


@implementation DNCAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

