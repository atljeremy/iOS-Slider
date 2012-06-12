//
//  PropertyDetailsViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyDetailsViewController.h"
#import "MyLocation.h"
#import "UIViewController+Rotation.h"
#import "UIBarButtonItem+CustomButton.h"
#import "TransparentToolbar.h"

#define SET_LEFT_ANCHOR_FOR_LEAD_FORM 290.0f

@interface PropertyDetailsViewController()

- (void)setupToolbar;
@end

@implementation PropertyDetailsViewController
@synthesize scrollView;
@synthesize propPhoto;
@synthesize mapView;

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
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100);
    [self setupToolbar];

}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPropPhoto:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    
}

- (IBAction)checkAvailability:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ShowLeadForm" 
                                                                                         object:nil]];
}

#pragma mark - UI Configuration

- (void)setupToolbar{
    
    
    // PropertyDetails toolbar functions: Favorite, Directions, Check Availability, Call
    UIBarButtonItem *favoritesBarButtonItem = [UIBarButtonItem customBarButtonItemWithImage:[UIImage imageNamed:@"star.png"]
                                                                                     target:self
                                                                                     action:nil];
    
    UIBarButtonItem *directionsBarButtonItem = [UIBarButtonItem customBarButtonItemWithImage:[UIImage imageNamed:@"directions.png"]
                                                                                     target:self
                                                                                     action:nil];
    
    UIBarButtonItem *emailBarButtonItem = [UIBarButtonItem customBarButtonItemWithImage:[UIImage imageNamed:@"email.png"]
                                                                                     target:self
                                                                                     action:nil];

    UIBarButtonItem *callBarButtonItem = [UIBarButtonItem customBarButtonItemWithImage:[UIImage imageNamed:@"phone.png"]
                                                                                     target:self
                                                                                     action:nil];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                   target:self 
                                                                                   action:nil];

    
    [self.toolbar setItems:[NSArray arrayWithObjects:favoritesBarButtonItem, flexibleSpace, directionsBarButtonItem, flexibleSpace, emailBarButtonItem, flexibleSpace, callBarButtonItem, nil]];
    
}

#pragma mark - Rotation

- (void)orientationChanged:(NSNotification*)notification{
  
    [self.view setFrame:CGRectMake(0, 0, [self screenSize].size.width, [self screenSize].size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1500);

    NSLog(@"Frame: %@", NSStringFromCGRect(self.view.frame));
//    
//    CGFloat navBarHeight = NAVIGATIONBAR_HEIGHT_PORTRAIT;
//    
//    if ( ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) || 
//        ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight) ) {
//        navBarHeight = NAVIGATIONBAR_HEIGHT_LANDSCAPE;
//    }
//    
//    CGFloat toolBarY = self.view.frame.size.height - (TOOLBAR_HEIGHT + navBarHeight);
//    self.toolbar.frame = CGRectMake(0, toolBarY, self.view.frame.size.width, TOOLBAR_HEIGHT);
//    
//    // Resize the default rotation size to handle scrolling of the property details
//    [self.view setFrame:CGRectMake(0, 0, [self screenSize].size.width, scrollView.contentSize.height)];
    
}


#pragma mark MKMapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
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

@end
