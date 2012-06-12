//
//  AppDelegate.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "IIViewDeckController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;

@synthesize centerController = _viewController;
@synthesize leftController = _leftController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        //**************************
        // IPHONE INITIALIZATION
        //**************************
        self.leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController_iPhone" bundle:nil];
        RightViewController* rightController = [[RightViewController alloc] initWithNibName:@"RightViewController_iPhone" bundle:nil];
        
        MainViewController *centerController = [[MainViewController alloc] initWithNibName:@"MainViewController_iPhone" bundle:nil];
        self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
        
        IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.centerController 
                                                                                        leftViewController:self.leftController
                                                                                       rightViewController:rightController];
        deckController.rightLedge = 100;
        
        self.window.rootViewController = deckController;
        
    } else {
        
        //**************************
        // IPAD INITIALIZATION
        //**************************
        self.leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
        RightViewController* rightController = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
        
        MainViewController *centerController = [[MainViewController alloc] initWithNibName:@"MainViewController_iPad" bundle:nil];
        self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
        
        IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.centerController 
                                                                                        leftViewController:self.leftController
                                                                                       rightViewController:rightController];
        
        deckController.rightLedge = 100;
        
        self.window.rootViewController = deckController;
        
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
