//
//  PRMViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PRMViewController.h"
#import "UIViewController+Rotation.h"

@implementation PRMViewController
@synthesize toolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
    UIDevice *device = [UIDevice currentDevice];
    [device endGeneratingDeviceOrientationNotifications];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)orientationChanged:(NSNotification*)notification{

    
    self.view.frame = [self screenSize];
    
    CGFloat navBarHeight = NAVIGATIONBAR_HEIGHT_PORTRAIT;
    
    if ( ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) || 
        ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight) ) {
        navBarHeight = NAVIGATIONBAR_HEIGHT_LANDSCAPE;
    }
    
    CGFloat toolBarY = self.view.frame.size.height - (TOOLBAR_HEIGHT + navBarHeight);
    toolbar.frame = CGRectMake(0, toolBarY, self.view.frame.size.width, TOOLBAR_HEIGHT);
    
}


@end
