//
//  DiscreteNotifications.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDiscreetNotificationView.h"

@class GCDiscreetNotificationView;

@protocol DiscreetNotifications <NSObject>

- (void) setNotificationLabel:(NSString *)text withActivityIndicator:(BOOL)activity andAnimation:(BOOL)animated;
- (void) showNotification;
- (void) showNotificationAndDismiss;
- (void) hideNotification;

@optional
- (IBAction)showHideNotification:(id)sender;

@end
