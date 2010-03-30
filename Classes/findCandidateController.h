//
//  findCandidateController.h
//  DNC
//
//  Created by krader on 3/24/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLController.h"


@interface findCandidateController : UIViewController <CLControllerDelegate>	{
	CLController *locationController;
	IBOutlet UITableView *table;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	NSMutableArray *candidates;
	NSMutableString *name;
	NSMutableString *candidateId;
	NSMutableString *latitude;
	NSMutableString *longitude;
	NSMutableString *currentLatitude;
	NSMutableString *currentLongitude;
	NSString *currentElement;
}

@property (nonatomic, retain) NSMutableString *currentLatitude;
@property (nonatomic, retain) NSMutableString *currentLongitude;
@property (nonatomic, retain) NSMutableArray *candidates;

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
- (float)findDistance:(float)latitudeCurrent :(float)longitudeCurrent :(float)latitudeCandidate :(float)longitudeCandidate;
- (void)xmlParser;

@end
