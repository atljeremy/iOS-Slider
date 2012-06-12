//
//  UIToolbar+Transparency.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIToolbar+Transparency.h"

@implementation UIToolbar (Transparency)

- (void)drawRect:(CGRect)rect {
 
    [[UIColor clearColor] set];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
}

@end
