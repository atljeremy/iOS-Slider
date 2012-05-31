//
//  MenuViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController
@synthesize menuItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}







- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.slidingViewController setAnchorRightRevealAmount:300.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    //return self.menuItems.count;
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuItemCell";
    ListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ListingTableViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[ListingTableViewCell class]]) {
                cell = (ListingTableViewCell *)currentObject;
                [cell.cellImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
                [cell.cellImageView.layer setBorderWidth: 6.0];
                [cell.cellImageView.layer setShadowColor:[UIColor blackColor].CGColor];
                [cell.cellImageView.layer setShadowOffset:CGSizeMake(-6.0, 5.0)];
                [cell.cellImageView.layer setShadowRadius:3.0];
                [cell.cellImageView.layer setShadowOpacity:0.5];
                break;
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  NSString *identifier = [NSString stringWithFormat:@"%@Top", [self.menuItems objectAtIndex:indexPath.row]];
    //
    //  UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    //  
    //  [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
    //    CGRect frame = self.slidingViewController.topViewController.view.frame;
    //    self.slidingViewController.topViewController = newTopViewController;
    //    self.slidingViewController.topViewController.view.frame = frame;
    //    [self.slidingViewController resetTopView];
    //  }];
}


@end
