//
//  UnderRightViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "AQGridView.h"
#import "ImageDemoCellChooser.h"

@interface UnderRightViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource, ImageDemoCellChooserDelegate>
{
    NSArray * _orderedImageNames;
    NSArray * _imageNames;
    AQGridView * _gridView;
    
    NSUInteger _cellType;
    UIPopoverController * _menuPopoverController;
}

@property (nonatomic, retain) UIView *leadForm;
@property (nonatomic, retain) IBOutlet AQGridView * gridView;

- (IBAction) shuffle;
- (IBAction) resetOrder;
- (IBAction) displayCellTypeMenu: (UIBarButtonItem *) sender;
- (IBAction) toggleLayoutDirection: (UIBarButtonItem *) sender;

@end
