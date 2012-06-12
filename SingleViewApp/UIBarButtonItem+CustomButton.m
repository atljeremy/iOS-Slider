//
//  UIBarButtonItem+CustomButton.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItem+CustomButton.h"

@implementation UIBarButtonItem (CustomButton)

+ (UIBarButtonItem *)customBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    
    UIButton *customButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    customButtonView.frame = CGRectMake(0.0f, 0.0f, 45.0f, 44.0f);
    
    [customButtonView setBackgroundImage:image 
                                forState:UIControlStateNormal];
    
    [customButtonView setBackgroundImage:image
                                forState:UIControlStateHighlighted];
    
//    [customButtonView setImage:image
//                      forState:UIControlStateNormal];
//    
//    [customButtonView setImage:image
//                      forState:UIControlStateHighlighted];
    
    [customButtonView addTarget:target action:action 
               forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButtonView];
    
    [customButtonView setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    
    //customButtonItem.imageInsets = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f);
    
    return customButtonItem;    
}

@end
