//
//  PropertyLeadThankYouViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PropertyLeadThankYouViewController.h"

@implementation PropertyLeadThankYouViewController
@synthesize thankYouListings;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setThankYouListings:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)continueBtn:(id)sender {
}

// TABLE VIEW DELEGATE/DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    //return self.menuItems.count;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuItemCell";
    ListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ListingTableViewCellThankYou" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[ListingTableViewCell class]]) {
                cell = (ListingTableViewCell *)currentObject;
                
                NSArray *array = [[NSBundle mainBundle] pathsForResourcesOfType:@".png" inDirectory:@"/."];
                NSMutableArray *items = [[NSMutableArray alloc] init];
                
                for (NSString *item in array) {
                    if ([item rangeOfString:@"apartment"].location != NSNotFound) {
                        [items addObject:item];
                    }
                }
                
                NSString *randomPath = [items objectAtIndex:arc4random() % [items count]];
                NSLog(@"%@", randomPath);
                UIImage *propPhoto = [[UIImage alloc] initWithContentsOfFile:randomPath];
                
                cell.cellImageView.image = propPhoto;
                [cell.cellImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
                [cell.cellImageView.layer setBorderWidth: 6.0];
//                [cell.cellImageView.layer setShadowColor:[UIColor blackColor].CGColor];
//                [cell.cellImageView.layer setShadowOffset:CGSizeMake(-6.0, 5.0)];
//                [cell.cellImageView.layer setShadowRadius:3.0];
//                [cell.cellImageView.layer setShadowOpacity:0.5];
                
                break;
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
