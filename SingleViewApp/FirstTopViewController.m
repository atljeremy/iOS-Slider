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

#define GEORGIA_TECH_LATITUDE 33.777328
#define GEORGIA_TECH_LONGITUDE -84.397348

#define ZOOM_LEVEL 14
#define ZOOM_LEVEL_MULTI 16

@interface FirstTopViewController()
{
    
}
-(void)loadMapView;

@end
@implementation FirstTopViewController
@synthesize toggle;
@synthesize mainViewContainer;
@synthesize rightSliderImage;
@synthesize leftSliderImage;
@synthesize mapView, detailsView;
@synthesize menuViewController, detailsViewController, underRightViewController, notificationView, mainMapViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        [detailsView setAlpha:0.0f];
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
    
    [self loadMapView];
    
    //Setup Discreet Notifications
    notificationView = [[GCDiscreetNotificationView alloc] initWithText: @"This Is My Notification"
                                                           showActivity: YES
                                                     inPresentationMode: GCDiscreetNotificationViewPresentationModeTop 
                                                                 inView: mainMapViewController.mkMapView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPropertyDetails:) name:@"PropertySelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(revealUnderRight:) name:@"ShowLeadForm" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performNearbySearch) name:@"searchNearby" object:nil];
    
}

- (void)viewDidUnload
{
    [self setRightSliderImage:nil];
    [self setLeftSliderImage:nil];
    [self setMapView:nil];
    [self setToggle:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PropertySelected" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShowLeadForm" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchNearby" object:nil];
    [self setMainViewContainer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (void)loadMapView{
    NSLog(@"Main View Container: wxh: %f x %f", self.mainViewContainer.bounds.size.width, self.mainViewContainer.bounds.size.height);
    mainMapViewController = [[MainMapViewController alloc] initWithNibName:@"MainMapViewController" bundle:nil];
    detailsViewController = [[PropertyDetailsViewController alloc] initWithNibName:@"PropertyDetailsViewController" bundle:nil];
    
    NSLog(@"Map View Container: wxh: %f x %f", mainMapViewController.mkMapView.bounds.size.width, mainMapViewController.mkMapView.bounds.size.height);
    
    NSLog(@"Setting Size from loadMapView");
//    [mainMapViewController.mkMapView setFrame:CGRectMake(0, 0, self.mainViewContainer.bounds.size.width, self.mainViewContainer.bounds.size.height)];
    
    mapView = mainMapViewController.mkMapView;
    detailsView = detailsViewController.view;
    [detailsView setAlpha:0.0f];
    
    [detailsViewController.propPhoto.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [detailsViewController.propPhoto.layer setBorderWidth: 6.0];
//    [detailsViewController.propPhoto.layer setShadowColor:[UIColor blackColor].CGColor];
//    [detailsViewController.propPhoto.layer setShadowOffset:CGSizeMake(-6.0, 5.0)];
//    [detailsViewController.propPhoto.layer setShadowRadius:3.0];
//    [detailsViewController.propPhoto.layer setShadowOpacity:0.5];
    
    [self.mainViewContainer addSubview:mainMapViewController.view];
    [self.mainViewContainer addSubview:detailsView];
    
    NSLog(@"HELLO");
    [mainMapViewController.view setFrame:CGRectMake(0, 0, self.mainViewContainer.bounds.size.width, self.mainViewContainer.bounds.size.height)];
    NSLog(@"Map View Container: wxh: %f x %f", mainMapViewController.mkMapView.bounds.size.width, mainMapViewController.mkMapView.bounds.size.height);
    CLLocationCoordinate2D centerCoord = { GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE };
    [mainMapViewController.mkMapView setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
    [detailsViewController.mapView setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
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
    
    [self setNotificationLabel:@"Finding Apartments Near You" withActivityIndicator:YES andAnimation:YES];
    [self showNotificationAndDismiss];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] 
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    [mainMapViewController.mkMapView addGestureRecognizer:lpgr];
    
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
    
    [self setPinAtLocation:centerCoord onMap:mainMapViewController.mkMapView withDescription:description andAddress:address];
    [self setPinAtLocation:centerCoord onMap:detailsViewController.mapView withDescription:description andAddress:address];
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"View did appear");
    CLLocationCoordinate2D centerCoord = { GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE };
    [mainMapViewController.mkMapView setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:mainMapViewController.mkMapView];   
    CLLocationCoordinate2D touchMapCoordinate = [mainMapViewController.mkMapView convertPoint:touchPoint toCoordinateFromView:mainMapViewController.mkMapView];
    
    NSString * description = @"Description";
    NSString * address = @"Address";
    
    [self setPinAtLocation:touchMapCoordinate onMap:mainMapViewController.mkMapView withDescription:description andAddress:address];
}

- (void)zoomMapToSelectedPropertyLocation:(CLLocationCoordinate2D)location
{
    [mainMapViewController.mkMapView setCenterCoordinate:location zoomLevel:ZOOM_LEVEL animated:YES];
}

- (void)updateMapViewWidthTo:(int)width
{
    CGRect f = mainMapViewController.mkMapView.frame;
    f.size.width = width;
    mainMapViewController.mkMapView.frame = f;
}

- (void)setPinAtLocation:(CLLocationCoordinate2D)location onMap:(MKMapView *)mapViewA withDescription:(NSString *)desc andAddress:(NSString *)address
{
    MyLocation *annotation = [[MyLocation alloc] initWithName:desc address:address coordinate:location];
    [mapViewA addAnnotation:annotation];
}

- (void)loadPropertyDetails:(NSNotification*)notification {
    [toggle setSelectedSegmentIndex:1];
    [self tappedToggle:nil];
}

- (void)performNearbySearch{
    [self setNotificationLabel:@"Finding Apartments Near You" withActivityIndicator:YES andAnimation:YES];
    [self showNotificationAndDismiss];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"points" ofType:@"plist"];
    NSDictionary *points = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *pointsArray = [points objectForKey:@"points"];
    CLLocationCoordinate2D theCoordinate;

    for(NSDictionary *dict in pointsArray) {
        
        double realLatitude = [[dict objectForKey:@"latitude"] doubleValue];
        double realLongitude = [[dict objectForKey:@"longitude"] doubleValue];

        theCoordinate.latitude = realLatitude;
        theCoordinate.longitude = realLongitude;
        NSString * title = @"Apartment Title";
        NSString * address = @"Address";
        
        [self setPinAtLocation:theCoordinate onMap:mainMapViewController.mkMapView withDescription:title andAddress:address];
    }
    [mainMapViewController.mkMapView setCenterCoordinate:theCoordinate zoomLevel:ZOOM_LEVEL_MULTI animated:YES];
}

#pragma mark MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [mainMapViewController.mkMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
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

/****************************************************************
 Show/Hide Discreet Notification
 ****************************************************************/
- (IBAction) showHideNotification:(id)sender {
    [self setNotificationLabel:@"YO! This is a Discreet Notification" withActivityIndicator:YES andAnimation:YES];
    [self.notificationView showAndDismissAfter:2.0];
}

- (void) showNotification  {
    [self.notificationView showAnimated];
}

 - (void) showNotificationAndDismiss  {
     [self.notificationView showAndDismissAfter:4.0];
 }

- (void) hideNotification  {
    [self.notificationView hideAnimatedAfter:0.5];
}

- (void) setNotificationLabel:(NSString *)text withActivityIndicator:(BOOL)activity andAnimation:(BOOL)animated {
    [self.notificationView setTextLabel:text andSetShowActivity:activity animated:animated];
}

- (IBAction)tappedToggle:(id)sender {
    BOOL detailsShown = NO;
    
    if ([toggle selectedSegmentIndex] == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            mainMapViewController.mkMapView.alpha = 1.0;
            detailsView.alpha = 0.0;
        }];
        
        detailsShown = NO;
    }
    else {
        [UIView animateWithDuration:0.25 animations:^{
            detailsView.alpha = 1.0;
            mainMapViewController.mkMapView.alpha = 0.0;
        }];
        
        detailsShown = YES;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ToggleLeadForm" 
                                                        object:nil 
                                                      userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:detailsShown] forKey:@"detailsShown"]];
}

@end
