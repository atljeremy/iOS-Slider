//
//  UnderRightViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ECSlidingViewController.h"
#import "AQGridView.h"
#import "ImageDemoCellChooser.h"
#import "MenuViewControllerDelegate.h"

@class PropertyLeadFormViewController;

@interface RightViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource, ImageDemoCellChooserDelegate>
{
    NSArray * _orderedImageNames;
    NSArray * _imageNames;
    AQGridView * _gridView;
    
    NSUInteger _cellType;
    UIPopoverController * _menuPopoverController;
}

@property (assign) id<MenuViewControllerDelegate> menuDelegate;
@property (nonatomic, retain) PropertyLeadFormViewController *leadFormController;
@property (nonatomic, retain) IBOutlet AQGridView * gridView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *detailsScrollView;

- (IBAction) shuffle;
- (IBAction) resetOrder;
- (IBAction) displayCellTypeMenu: (UIBarButtonItem *) sender;
- (IBAction) toggleLayoutDirection: (UIBarButtonItem *) sender;

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *leadForm;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *myPlacesTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *leadFormTitle;

@end
