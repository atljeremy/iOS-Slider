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
#import "UnderRightViewController.h"

@interface FirstTopViewController : UIViewController

- (IBAction)revealMenu:(id)sender;
- (IBAction)revealUnderRight:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *rightSliderImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *leftSliderImage;
@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *mapView;

@end
