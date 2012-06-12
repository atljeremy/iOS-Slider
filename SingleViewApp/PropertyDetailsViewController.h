//
//  PropertyDetailsViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PRMViewController.h"

@interface PropertyDetailsViewController : PRMViewController <UIScrollViewDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *propPhoto;
@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)checkAvailability:(id)sender;

@end
