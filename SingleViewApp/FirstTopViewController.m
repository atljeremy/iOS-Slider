//
//  FirstTopViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstTopViewController.h"
#import "MenuViewController.h"
#import "MKMapView+ZoomLevel.h"
#import "MyLocation.h"

#define SET_RIGHT_ANCHOR_FOR_LISTINGS 300.0f
#define SET_RIGHT_ANCHOR_FOR_DETAILS 650.0f
#define SET_RIGHT_ANCHOR_FOR_AVAILABILITY 985.0f

@implementation FirstTopViewController
@synthesize rightSliderImage;
@synthesize leftSliderImage;
@synthesize mapView;
@synthesize menuViewController, underRightViewController;

#define GEORGIA_TECH_LATITUDE 33.777328
#define GEORGIA_TECH_LONGITUDE -84.397348

#define ZOOM_LEVEL 14

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
    [self setRightSliderImage:nil];
    [self setLeftSliderImage:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}




- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)revealMenuAndShowDetails
{
    [self.slidingViewController setAnchorRightRevealAmount:SET_RIGHT_ANCHOR_FOR_DETAILS];
    [self revealMenu:nil];
}

- (IBAction)revealUnderRight:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] 
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController_iPhone" bundle:nil];
        underRightViewController = [[UnderRightViewController alloc] initWithNibName:@"UnderRightViewController_iPhone" bundle:nil];
    } else {
        menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController_iPad" bundle:nil];
        underRightViewController = [[UnderRightViewController alloc] initWithNibName:@"UnderRightViewController_iPad" bundle:nil];
    }
    
    menuViewController.menuDelegate = self;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = menuViewController;
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[UnderRightViewController class]]) {
        self.slidingViewController.underRightViewController = underRightViewController;
    }
    
    CLLocationCoordinate2D centerCoord = { GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE };
    NSString * description = @"Description";
    NSString * address = @"Address";
    
    [self setPinAtLocation:centerCoord withDescription:description andAddress:address];
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CLLocationCoordinate2D centerCoord = { GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE };
    [mapView setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];   
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    NSString * description = @"Description";
    NSString * address = @"Address";
    
    [self setPinAtLocation:touchMapCoordinate withDescription:description andAddress:address];
}

- (void)zoomMapToSelectedPropertyLocation:(CLLocationCoordinate2D)location
{
    [mapView setCenterCoordinate:location zoomLevel:ZOOM_LEVEL animated:YES];
}

- (void)updateMapViewWidthTo:(int)width
{
    CGRect f = mapView.frame;
    f.size.width = width;
    mapView.frame = f;
}

- (void)setPinAtLocation:(CLLocationCoordinate2D)location withDescription:(NSString *)desc andAddress:(NSString *)address
{
    MyLocation *annotation = [[MyLocation alloc] initWithName:desc address:address coordinate:location] ;
    [self.mapView addAnnotation:annotation];
}

#pragma mark MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
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
