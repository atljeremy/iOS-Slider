//
//  UIBarButtonItem+CustomButton.h
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomButton)

+ (UIBarButtonItem *)customBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

@end
