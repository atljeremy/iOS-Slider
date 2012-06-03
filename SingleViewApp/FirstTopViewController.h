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

@interface FirstTopViewController : UIViewController <MenuViewControllerDelegate, MKMapViewDelegate>

- (void)setPinAtLocation:(CLLocationCoordinate2D)location withDescription:(NSString *)desc andAddress:(NSString *)address;
- (IBAction)revealMenu:(id)sender;
- (void)revealMenuAndShowDetails;
- (IBAction)revealUnderRight:(id)sender;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) UnderRightViewController *underRightViewController;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *rightSliderImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *leftSliderImage;
@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *mapView;

@end
