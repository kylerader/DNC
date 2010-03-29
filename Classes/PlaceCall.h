//
//  PlaceCall.h
//  DNC
//
//  Created by krader on 3/26/10.
//  Copyright 2010 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaceCall : UIViewController {
	NSString *supporterID;
	NSString *supporterPhone;
	NSString *supporterName;
	NSString *candidateName;
	IBOutlet UILabel *candidateNameLabel;
	IBOutlet UIButton *callSupporter;
	IBOutlet UILabel *script;
	IBOutlet UISwitch *yesNoSwitch;
	

}
@property (nonatomic, retain) NSString *supporterID;
@property (nonatomic, retain) NSString *supporterPhone;
@property (nonatomic, retain) NSString *supporterName;
@property (nonatomic, retain) NSString *candidateName;

- (IBAction)placeTheCall:(id)sender;

@end
