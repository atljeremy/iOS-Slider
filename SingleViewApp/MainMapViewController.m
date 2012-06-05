//
//  MainMapViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMapViewController.h"

@interface MainMapViewController()

- (CGRect)screenSize;

@end

@implementation MainMapViewController
@synthesize mkMapView;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (CGRect)screenSize {
    UIScreen *screen = [UIScreen mainScreen];
    int width = screen.applicationFrame.size.width;
    int height = screen.applicationFrame.size.height;
    
    NSLog(@"Status Bar Orientation: %d v. %d", [[UIDevice currentDevice] orientation], UIDeviceOrientationPortrait);
    
    if ( ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) || 
         ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight) ) {
        return CGRectMake(0, 0, height, width);
    }
    
    return CGRectMake(0, 0, width, height);
}

@end