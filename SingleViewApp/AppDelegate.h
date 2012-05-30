//
//  AppDelegate.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "InitialSlidingViewController.h"

@class ViewController;
@class FirstTopViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) FirstTopViewController *firstTopViewController;

@property (strong, nonatomic) InitialSlidingViewController *slidingViewController;

@end
