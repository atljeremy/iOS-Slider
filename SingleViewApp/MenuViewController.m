//
//  MenuViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "MKMapView+ZoomLevel.h"
#import "MyLocation.h"

#define SET_RIGHT_ANCHOR_FOR_IPHONE_DETAILS 0.0f
#define SET_RIGHT_ANCHOR_FOR_LISTINGS 300.0f
#define SET_RIGHT_ANCHOR_FOR_DETAILS 650.0f
#define SET_RIGHT_ANCHOR_FOR_AVAILABILITY 985.0f
#define SET_MAPVIEW_WIDTH_FOR_LISTINGS 724
#define SET_MAPVIEW_WIDTH_FOR_PROPERTY_DETAILS 374
#define SET_MAPVIEW_WIDTH_FULL 1024
#define GEORGIA_TECH_LATITUDE 33.777328
#define GEORGIA_TECH_LONGITUDE -84.397348
#define ZOOM_LEVEL 15

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
- (void)showDetails;
- (void)showLeadForm;
@end

@implementation MenuViewController
@synthesize descTextView;
@synthesize descTitleView;
@synthesize propertyMap, detailsScrollView, detailsPhoto, menuItems, menuDelegate;

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
    [self setDetailsPhoto:nil];
    [self setDetailsScrollView:nil];
    [self setPropertyMap:nil];
    [self setDescTextView:nil];
    [self setDescTitleView:nil];
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
    [self.slidingViewController setAnchorRightRevealAmount:SET_RIGHT_ANCHOR_FOR_LISTINGS];
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
    [self showDetails];
}

- (void)showDetails
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        //[self.slidingViewController setAnchorRightRevealAmount:SET_RIGHT_ANCHOR_FOR_IPHONE_DETAILS];
        //[self.slidingViewController anchorTopViewTo:ECRight];
        [self.slidingViewController resetTopView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PropertySelected" 
                                                            object:nil 
                                                          userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"detailsShown"]];
    } else {
        [self.slidingViewController setAnchorRightRevealAmount:SET_RIGHT_ANCHOR_FOR_DETAILS];
        [self.slidingViewController anchorTopViewTo:ECRight];
        self.detailsScrollView.contentSize = CGSizeMake(350, 1000);
        [menuDelegate updateMapViewWidthTo:SET_MAPVIEW_WIDTH_FOR_PROPERTY_DETAILS];
    }
    
    [self.detailsPhoto.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.detailsPhoto.layer setBorderWidth: 6.0];
    [self.detailsPhoto.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.detailsPhoto.layer setShadowOffset:CGSizeMake(-6.0, 5.0)];
    [self.detailsPhoto.layer setShadowRadius:3.0];
    [self.detailsPhoto.layer setShadowOpacity:0.5];
    
    CLLocationCoordinate2D centerCoord = { GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE };
    [self.propertyMap setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
    
    CLLocationCoordinate2D propertyCoordinate = CLLocationCoordinate2DMake(GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE);
    
    NSString * description = @"Description";
    NSString * address = @"Address";
    
    MyLocation *annotation = [[MyLocation alloc] initWithName:description address:address coordinate:propertyCoordinate];
    [self.propertyMap addAnnotation:annotation];
    
    [menuDelegate zoomMapToSelectedPropertyLocation:propertyCoordinate];

}

- (void)showLeadForm
{
    [self.slidingViewController setAnchorRightRevealAmount:SET_RIGHT_ANCHOR_FOR_AVAILABILITY];
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)checkAvailability:(id)sender {
    [self showLeadForm];
    [menuDelegate updateMapViewWidthTo:SET_MAPVIEW_WIDTH_FULL];
}

#pragma mark MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [self.propertyMap dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if(annotationView)
        return annotationView;
    else
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:AnnotationIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"map-pin.png"]];
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(writeSomething:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView = rightButton;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        return annotationView;
    }
    return nil;
}

@end
