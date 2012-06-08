//
//  FirstTopViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "MenuViewControllerDelegate.h"
#import "UnderRightViewController.h"
#import "GCDiscreetNotificationView.h"
#import "DiscreteNotifications.h"

#import "PropertyDetailsView.h"
#import "PropertyDetailsViewController.h"
#import "MainMapViewController.h"

@interface FirstTopViewController : UIViewController <MenuViewControllerDelegate, MKMapViewDelegate, DiscreetNotifications>

- (void)setPinAtLocation:(CLLocationCoordinate2D)location onMap:(MKMapView *)mapView withDescription:(NSString *)desc andAddress:(NSString *)address;
- (IBAction)revealMenu:(id)sender;
- (void)revealMenuAndShowDetails;
- (IBAction)revealUnderRight:(id)sender;
- (IBAction)tappedToggle:(id)sender;
- (void)performNearbySearch;

@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) UnderRightViewController *underRightViewController;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *rightSliderImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *leftSliderImage;
@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) UIView *detailsView;
@property (nonatomic, strong) PropertyDetailsViewController *detailsViewController;
@property (nonatomic, strong) MainMapViewController *mainMapViewController;
@property (nonatomic, strong) GCDiscreetNotificationView *notificationView;
@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *toggle;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainViewContainer;


@end
