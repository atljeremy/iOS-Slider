//
//  PropertyLeadThankYouViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRMViewController.h"
#import "ListingTableViewCell.h"

@interface PropertyLeadThankYouViewController : PRMViewController

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *thankYouListings;

- (IBAction)continueBtn:(id)sender;
- (IBAction)dismissThankYouScreen:(id)sender;

@end
