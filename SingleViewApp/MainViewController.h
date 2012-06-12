//
//  MainViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

#import "PRMViewController.h"
#import "LeftViewController.h"
#import "MenuViewControllerDelegate.h"
#import "RightViewController.h"
#import "GCDiscreetNotificationView.h"
#import "DiscreteNotifications.h"

#import "PropertyDetailsView.h"
#import "PropertyDetailsViewController.h"
#import "MainMapViewController.h"

@interface MainViewController : PRMViewController <MenuViewControllerDelegate, MKMapViewDelegate, DiscreetNotifications>

- (void)setPinAtLocation:(CLLocationCoordinate2D)location onMap:(MKMapView *)mapView withDescription:(NSString *)desc andAddress:(NSString *)address;
- (IBAction)revealMenu:(id)sender;
- (void)revealMenuAndShowDetails;
- (IBAction)revealUnderRight:(id)sender;
- (IBAction)tappedToggle:(id)sender;
- (void)performNearbySearch;
- (void)loadMapView;

@property (nonatomic, strong) LeftViewController *menuViewController;
@property (nonatomic, strong) RightViewController *underRightViewController;
@property (assign, nonatomic) IBOutlet UIImageView *rightSliderImage;
@property (assign, nonatomic) IBOutlet UIImageView *leftSliderImage;
@property (assign, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) UIView *detailsView;
@property (nonatomic, strong) PropertyDetailsViewController *detailsViewController;
@property (nonatomic, strong) MainMapViewController *mainMapViewController;
@property (nonatomic, strong) GCDiscreetNotificationView *notificationView;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (assign, nonatomic) IBOutlet UIView *mainViewContainer;

@end
