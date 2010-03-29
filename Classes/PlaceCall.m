//
//  PlaceCall.m
//  DNC
//
//  Created by krader on 3/26/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import "PlaceCall.h"
#import "MakeCallsController.h"


@implementation PlaceCall

@synthesize supporterID,supporterName,supporterPhone,candidateName;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIView *mainView = [[[[yesNoSwitch subviews] objectAtIndex:0] subviews] objectAtIndex:2];
	UILabel *onLabel = [[mainView subviews] objectAtIndex:0];
	UILabel *offLabel = [[mainView subviews] objectAtIndex:1];
	onLabel.text = @"Yes";
	offLabel.text = @"No";
	[candidateNameLabel setText:[@"Supporter for " stringByAppendingString:self.candidateName]];
	[script setText:[@"Hi, " stringByAppendingString:[self.supporterName stringByAppendingString:[@".  My name is __.  I'm a volunteer with " stringByAppendingString:[self.candidateName stringByAppendingString:@".  How are you? I'm calling to find out whether you'll be supporting him/her?"]]]]];
	[callSupporter setTitle:[@"Call " stringByAppendingString:self.supporterName] forState:UIControlStateNormal];
	//[mainView release];
	//[onLabel release];
	//[offLabel release];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (IBAction)placeTheCall:(id)sender{
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:self.supporterPhone]]];
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[supporterID release];
	[supporterPhone release];
	[supporterName release];
	[candidateName release];
	[candidateNameLabel release];
	[callSupporter release];
	[script release];
	[yesNoSwitch release];
    [super dealloc];
}


@end
