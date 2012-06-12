//
//  PRMViewController.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define TOOLBAR_HEIGHT 44.0f
#define NAVIGATIONBAR_HEIGHT_PORTRAIT 44.0f
#define NAVIGATIONBAR_HEIGHT_LANDSCAPE 32.0f

@interface PRMViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

- (void)orientationChanged:(NSNotification*)notification;

@end
