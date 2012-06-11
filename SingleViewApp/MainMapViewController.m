//
//  MainMapViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMapViewController.h"

#define TOOLBAR_HEIGHT 44.0f
#define NAVIGATIONBAR_HEIGHT_PORTRAIT 44.0f
#define NAVIGATIONBAR_HEIGHT_LANDSCAPE 32.0f

@interface MainMapViewController()

- (CGRect)screenSize;
- (void)orientationChanged:(NSNotification*)notification;

@end

@implementation MainMapViewController
@synthesize mkMapView, toolbar;

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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

#pragma mark MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [mkMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if(annotationView)
        return annotationView;
    else
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:AnnotationIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"map-pin.png"]];
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(revealMenuAndShowDetails) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView = rightButton;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        return annotationView;
    }
    return nil;
}

- (IBAction)nearbySearch:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchNearby" object:nil];
}

- (IBAction)entrySearch:(id)sender {
    
}
@end
