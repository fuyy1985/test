//
//  smellycatAppDelegate.h
//  smellycat
//
//  Created by apple on 10-10-30.
//  Copyright zjdayu 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface smellycatAppDelegate : NSObject <UIApplicationDelegate,UIAlertViewDelegate> {
    UIWindow *window;
    RootViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *viewController;

@end

