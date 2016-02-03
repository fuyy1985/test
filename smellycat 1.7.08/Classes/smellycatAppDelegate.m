//
//  smellycatAppDelegate.m
//  smellycat
//
//  Created by apple on 10-10-30.
//  Copyright zjdayu 2010. All rights reserved.
//

#import "smellycatAppDelegate.h"
#import "RootViewController.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>

@implementation smellycatAppDelegate
@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
	//[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];

    // Override point for customization after app launch. 
    // Set RootViewController to window
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 6.0)
    {
        // warning: addSubView doesn't work on iOS6
        [self.window addSubview: viewController.view];
    }
    else
    {
        // use this mehod on ios6
        [self.window setRootViewController:viewController];
    }
    [window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application{
	/*
	UIAlertView	*alertview = [[UIAlertView alloc] initWithTitle:@"hahahha" message:@"hhd" delegate:self 
							  
											  cancelButtonTitle:nil otherButtonTitles:nil];
	
	[alertview show];
	[alertview release];

	[[NSNotificationCenter defaultCenter] addObserver:self									 
											 selector:@selector(applicationWillTerminate:)												 
												 name:UIApplicationWillTerminateNotification											   
											   object:self];
	 	 */
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}
- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
