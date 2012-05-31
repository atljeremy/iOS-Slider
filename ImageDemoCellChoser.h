//
//  GridViewCellChoser.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridViewCellChoser;

@interface GridViewCellChoser : UITableViewController
{
    NSArray * _itemTitles;
    id<ImageDemoCellChooserDelegate> __unsafe_unretained _delegate;
}

- (id) initWithItemTitles: (NSArray *) titles;

@property (nonatomic, assign) id<ImageDemoCellChooserDelegate> delegate;

@end

@protocol ImageDemoCellChooserDelegate
- (void) cellChooser: (ImageDemoCellChooser *) chooser selectedItemAtIndex: (NSUInteger) index;
@end
