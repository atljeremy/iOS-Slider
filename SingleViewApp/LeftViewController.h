//
//  MenuViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PRMViewController.h"
#import "ListingTableViewCell.h"
#import "MenuViewControllerDelegate.h"

//#import "ECSlidingViewController.h"

@interface LeftViewController : PRMViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, MKMapViewDelegate>

@property (assign) id<MenuViewControllerDelegate> menuDelegate;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *detailsScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *detailsPhoto;
@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *propertyMap;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *descTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *descTitleView;

- (IBAction)checkAvailability:(id)sender;
@end