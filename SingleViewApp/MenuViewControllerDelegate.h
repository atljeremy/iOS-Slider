//
//  MenuViewControllerDelegate.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKMapView+ZoomLevel.h"
#import "MyLocation.h"

@protocol MenuViewControllerDelegate <NSObject>

-(void)zoomMapToSelectedPropertyLocation:(CLLocationCoordinate2D)location;
-(void)updateMapViewWidthTo:(int)width;

@end
