//
// Created by jfox on 6/12/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIViewController+Rotation.h"


@implementation UIViewController (Rotation)

- (CGRect)screenSize {

    UIScreen *screen = [UIScreen mainScreen];
    int width = screen.applicationFrame.size.width;
    int height = screen.applicationFrame.size.height;

    NSLog(@"Status Bar Orientation: %d v. %d", [[UIDevice currentDevice] orientation], UIDeviceOrientationPortrait);

    if ( ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) ||
            ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight) ) {
        return CGRectMake(0, 0, height, width);
    }

    return CGRectMake(0, 0, width, height);
}

@end