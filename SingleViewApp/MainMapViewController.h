//
//  MainMapViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PRMViewController.h"

@interface MainMapViewController : PRMViewController <MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mkMapView;

- (IBAction)nearbySearch:(id)sender;
- (IBAction)entrySearch:(id)sender;

@end
