//
//  MenuViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ECSlidingViewController.h"
#import "ListingTableViewCell.h"

@protocol MenuViewControllerDelegate;
@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (assign) id<MenuViewControllerDelegate> menuDelegate;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *detailsScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *detailsPhoto;
@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *propertyMap;
- (IBAction)checkAvailability:(id)sender;
@end

@protocol MenuViewControllerDelegate <NSObject>

-(void)zoomMapToSelectedPropertyLocation:(CLLocationCoordinate2D)location;

@end