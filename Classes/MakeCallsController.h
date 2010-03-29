//
//  MakeCallsController.h
//  DNC
//
//  Created by krader on 3/25/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MakeCallsController : UIViewController {
	IBOutlet UITableView *table;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	NSMutableArray *supporters;
	NSMutableString *name;
	NSMutableString *phone;
	NSMutableString *supporterId;
	NSMutableString *candidateId;
	NSMutableString *candidateResponse;
	NSString *currentElement;
	NSXMLParser *parser;
	NSString *candidateSelection;
	NSString *candidateName;
}

@property (nonatomic, retain) NSMutableArray *supporters;
@property (nonatomic, retain) NSString *candidateSelection;
@property (nonatomic, retain) NSString *candidateName;


- (void)xmlParser;

@end

