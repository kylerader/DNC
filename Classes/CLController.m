//
//  CLController.m
//  DNC
//
//  Created by krader on 3/24/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "CLController.h"

@implementation CLController

@synthesize locationManager;
@synthesize delegate;

- (id) init{
	self=[super init];
	if(self!=nil){
		self.locationManager = [[[CLLocationManager alloc] init] autorelease];
		self.locationManager.delegate = self;
	}
	return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	[self.delegate locationUpdate:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	[self.delegate locationError:error];
}

- (void)dealloc {
	[self.locationManager release];
	[super dealloc];
}

@end
