//
//  UnderRightViewController.m
//  SingleViewApp
//
//  Created by Jeremy Fox on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UnderRightViewController.h"
#import "ImageDemoGridViewCell.h"
#import "ImageDemoFilledCell.h"

enum
{
    ImageDemoCellTypePlain,
    ImageDemoCellTypeFill,
    ImageDemoCellTypeOffset
};


@interface UnderRightViewController()
@property (nonatomic, unsafe_unretained) CGFloat peekLeftAmount;
@end

@implementation UnderRightViewController
@synthesize peekLeftAmount;
@synthesize gridView=_gridView;

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
    self.gridView = nil;
    _menuPopoverController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    self.peekLeftAmount = 50.0f;
    [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
    
    // Grid view
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.gridView.autoresizesSubviews = YES;
	self.gridView.delegate = self;
	self.gridView.dataSource = self;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        // Nothing for now
    } else {
        ImageDemoCellChooser * chooser = [[ImageDemoCellChooser alloc] initWithItemTitles: [NSArray arrayWithObjects: NSLocalizedString(@"Plain", @""), NSLocalizedString(@"Filled", @""), nil]];
        chooser.delegate = self;
        _menuPopoverController = [[UIPopoverController alloc] initWithContentViewController: chooser];
    }
    
    
    if ( _orderedImageNames != nil )
        return;
    
    NSArray * paths = [NSBundle pathsForResourcesOfType: @"png" inDirectory: [[NSBundle mainBundle] bundlePath]];
    NSMutableArray * allImageNames = [[NSMutableArray alloc] init];
    
    for ( NSString * path in paths )
    {
        if ( [[path lastPathComponent] hasPrefix: @"apart"] )
        {
            NSLog(@"%@", [path lastPathComponent]);
            [allImageNames addObject: [path lastPathComponent]];
        }
        else
        {
            continue;
        }
        
    }
    
    // sort alphabetically
    _orderedImageNames = [[allImageNames sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)] copy];
    _imageNames = [_orderedImageNames copy];
    
    
    [self.gridView reloadData];

}




/////////////////////////////////
// Grid View
/////////////////////////////////
- (IBAction) shuffle
{
    NSMutableArray * sourceArray = [_imageNames mutableCopy];
    NSMutableArray * destArray = [[NSMutableArray alloc] initWithCapacity: [sourceArray count]];
    
    [self.gridView beginUpdates];
    
    srandom( time(NULL) );
    while ( [sourceArray count] != 0 )
    {
        NSUInteger index = (NSUInteger)(random() % [sourceArray count]);
        id item = [sourceArray objectAtIndex: index];
        
        // queue the animation
        [self.gridView moveItemAtIndex: [_imageNames indexOfObject: item]
                               toIndex: [destArray count]
                         withAnimation: AQGridViewItemAnimationFade];
        
        // modify source & destination arrays
        [destArray addObject: item];
        [sourceArray removeObjectAtIndex: index];
    }
    
    _imageNames = [destArray copy];
    
    [self.gridView endUpdates];
    
}

- (IBAction) resetOrder
{
    [self.gridView beginUpdates];
    
    NSUInteger index, count = [_orderedImageNames count];
    for ( index = 0; index < count; index++ )
    {
        NSUInteger oldIndex = [_imageNames indexOfObject: [_orderedImageNames objectAtIndex: index]];
        if ( oldIndex == index )
            continue;       // no changes for this item
        
        [self.gridView moveItemAtIndex: oldIndex toIndex: index withAnimation: AQGridViewItemAnimationFade];
    }
    
    [self.gridView endUpdates];
    
    _imageNames = [_orderedImageNames copy];
}

- (IBAction) displayCellTypeMenu: (UIBarButtonItem *) sender
{
    if ( [_menuPopoverController isPopoverVisible] )
        [_menuPopoverController dismissPopoverAnimated: YES];
    
    [_menuPopoverController presentPopoverFromBarButtonItem: sender
                                   permittedArrowDirections: UIPopoverArrowDirectionUp
                                                   animated: YES];
}

- (IBAction) toggleLayoutDirection: (UIBarButtonItem *) sender
{
	switch ( _gridView.layoutDirection )
	{
		default:
		case AQGridViewLayoutDirectionVertical:
			sender.title = NSLocalizedString(@"Horizontal Layout", @"");
			_gridView.layoutDirection = AQGridViewLayoutDirectionHorizontal;
			break;
			
		case AQGridViewLayoutDirectionHorizontal:
			sender.title = NSLocalizedString(@"Vertical Layout", @"");
			_gridView.layoutDirection = AQGridViewLayoutDirectionVertical;
			break;
	}
	
	// force the grid view to reflow
	CGRect bounds = CGRectZero;
	bounds.size = _gridView.frame.size;
	_gridView.bounds = bounds;
	[_gridView setNeedsLayout];
}

- (void) cellChooser: (ImageDemoCellChooser *) chooser selectedItemAtIndex: (NSUInteger) index
{
    if ( index != _cellType )
    {
        _cellType = index;
        switch ( _cellType )
        {
            case ImageDemoCellTypePlain:
                self.gridView.separatorStyle = AQGridViewCellSeparatorStyleEmptySpace;
                self.gridView.resizesCellWidthToFit = NO;
                self.gridView.separatorColor = nil;
                break;
                
            case ImageDemoCellTypeFill:
                self.gridView.separatorStyle = AQGridViewCellSeparatorStyleSingleLine;
                self.gridView.resizesCellWidthToFit = YES;
                self.gridView.separatorColor = [UIColor colorWithWhite: 0.85 alpha: 1.0];
                break;
                
            default:
                break;
        }
        
        [self.gridView reloadData];
    }
    
    [_menuPopoverController dismissPopoverAnimated: YES];
}

#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return ( [_imageNames count] );
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    static NSString * FilledCellIdentifier = @"FilledCellIdentifier";
    //static NSString * OffsetCellIdentifier = @"OffsetCellIdentifier";
    
    AQGridViewCell * cell = nil;
    
    switch ( _cellType )
    {
        case ImageDemoCellTypePlain:
        {
            ImageDemoGridViewCell * plainCell = (ImageDemoGridViewCell *)[aGridView dequeueReusableCellWithIdentifier: PlainCellIdentifier];
            if ( plainCell == nil )
            {
                plainCell = [[ImageDemoGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 200.0, 150.0)
                                                         reuseIdentifier: PlainCellIdentifier];
                plainCell.selectionGlowColor = [UIColor blueColor];
            }
            
            plainCell.image = [UIImage imageNamed: [_imageNames objectAtIndex: index]];
            
            cell = plainCell;
            break;
        }
            
        case ImageDemoCellTypeFill:
        {
            ImageDemoFilledCell * filledCell = (ImageDemoFilledCell *)[aGridView dequeueReusableCellWithIdentifier: FilledCellIdentifier];
            if ( filledCell == nil )
            {
                filledCell = [[ImageDemoFilledCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 200.0, 150.0)
                                                        reuseIdentifier: FilledCellIdentifier];
                filledCell.selectionStyle = AQGridViewCellSelectionStyleBlueGray;
            }
            
            filledCell.image = [UIImage imageNamed: [_imageNames objectAtIndex: index]];
            filledCell.title = [[_imageNames objectAtIndex: index] stringByDeletingPathExtension];
            
            cell = filledCell;
            break;
        }
            
        default:
            break;
    }
    
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(224.0, 168.0) );
}

@end
