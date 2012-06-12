//
//  TransparentToolbar.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransparentToolbar.h"

@interface TransparentToolbar()
- (void) applyTranslucentBackground;
@end

@implementation TransparentToolbar

// Override draw rect to avoid
// background coloring
- (void)drawRect:(CGRect)rect {
    // do nothing in here
}

// Set properties to make background
// translucent.
- (void) applyTranslucentBackground{
    
	self.backgroundColor = [UIColor clearColor];
	self.opaque = NO;
	self.translucent = YES;
}

// Override init.
- (id) init{
    
	self = [super init];
	[self applyTranslucentBackground];
	return self;
}

// Override initWithFrame.
- (id) initWithFrame:(CGRect) frame{
    
	self = [super initWithFrame:frame];
	[self applyTranslucentBackground];
	return self;
}

// Override initWithCoder
- (id)initWithCoder:(NSCoder *)decoder { 
    
    self = [super initWithCoder:decoder]; 
    
    if (self) { 
        [self applyTranslucentBackground]; 
    } 
    return self; 
}


@end
