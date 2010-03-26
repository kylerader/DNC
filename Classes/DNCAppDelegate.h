//
//  DNCAppDelegate.h
//  DNC
//
//  Created by krader on 3/23/10.
//  Copyright ThoughtWorks 2010. All rights reserved.
//

@interface DNCAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

