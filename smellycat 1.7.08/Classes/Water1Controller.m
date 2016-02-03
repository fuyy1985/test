//
//  Water1Controller.m
//  navag
//
//  Created by Heiby He on 09-3-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Water1Controller.h"
#import "MyTableCell.h"
#import "Const.h"
#import "WaterTableController.h"
#import "smellycatViewController.h"

static Water1Controller *me=nil;
@implementation Water1Controller

@synthesize myScroll,myPage,AllPages,myLabel;
@synthesize orderby,totalCount,waterType,isFirstLoad,hisc,closePage,numPages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withArray:(NSMutableArray *)myArray{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		[myArray retain];
		[self.hisc release];
		self.hisc = myArray;
		[myArray release];
		self.totalCount = [NSString stringWithFormat:@"%d",self.hisc.count];
		me=self;
		isFirstLoad = YES;
		closePage = 0;
		
		//add close button
		UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		[myButton setBackgroundImage:[UIImage imageNamed:@"close_normal.png"] forState:UIControlStateNormal];
		[myButton setBackgroundImage:nil forState:UIControlStateSelected];
		[myButton addTarget:self action:@selector(dismissPopover) forControlEvents:UIControlEventTouchUpInside];
		UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:myButton];
		self.navigationItem.rightBarButtonItem = right;
		[right release];
		[myButton release];
	}
	return self;
}
+(id)sharedWater1{
	return me;
}

-(void)dismissPopover{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon dismissWater];
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */
-(void)viewWillAppear:(BOOL)animated{
	self.contentSizeForViewInPopover = CGSizeMake(320, 368);
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if (isFirstLoad) {
		[self reloadData];
		isFirstLoad = NO;
	}else {
		NSInteger temPage = closePage;
//		NSLog(@"WaterTableController*************%d",temPage);
		if (nil == ((WaterTableController *)[AllPages objectAtIndex:temPage]).view.superview) {
			//restore the scroll property
			myScroll.pagingEnabled = YES;
			myScroll.directionalLockEnabled=YES;
			[myScroll setContentOffset:CGPointMake(myScroll.frame.size.width*temPage, myScroll.frame.size.height)];
			myScroll.contentSize = CGSizeMake(myScroll.frame.size.width * numPages, myScroll.frame.size.height);
			myScroll.showsHorizontalScrollIndicator = NO;
			myScroll.showsVerticalScrollIndicator = NO;
			myScroll.scrollsToTop = YES;
			myScroll.clipsToBounds=YES;
			myScroll.delegate = self;
			myPage.numberOfPages = numPages;
			myPage.currentPage = temPage;
			//set offset
			[self loadScrollViewWithPage:temPage-1];
			[self loadScrollViewWithPage:temPage];
			[self loadScrollViewWithPage:temPage+1];
		}
	}

}

- (void)viewDidLoad{
	//[mySeg setEnabled:NO forSegmentAtIndex:1];	
}

-(void)reloadData{
	CGRect frame=[myScroll frame];
	frame.size.height=308;
	[myScroll removeFromSuperview];
	if(myScroll!=nil)[myScroll release];
	myScroll=[[UIScrollView alloc] initWithFrame:frame];
	[self.view addSubview:myScroll];
	
	NSInteger count=[totalCount integerValue];
	numPages=(count%NUMPAGE==0?count/NUMPAGE:count/NUMPAGE+1);
	[self loadPages];
	
	//NSRange r = [self.navigationItem.title rangeOfString:@"("];
	//NSString *sTitle = [self.navigationItem.title substringToIndex:r.location];
	//self.navigationItem.title=[NSString stringWithFormat:@"%@(%d个)",sTitle,count];
	
	// Set the label
	if([self.waterType isEqualToString:@"1"])
		[myLabel setText:@"超 限"];
	else
		[myLabel setText:@"超 警"];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning 
{
	// Calculate the current page in scroll view
    int currentPage = myPage.currentPage;
	
	// unload the pages which are no longer visible
	for (int i = 0; i < [AllPages count]; i++) 
	{
		WaterTableController *viewController = [AllPages objectAtIndex:i];
        if((NSNull *)viewController != [NSNull null])
		{
			if(i < currentPage-1 || i > currentPage+1)
			{
				[viewController.view removeFromSuperview];
				[AllPages replaceObjectAtIndex:i withObject:[NSNull null]];
			}
		}
	}
	
}


//////////////////////
-(void)loadPages{
    // in the meantime, load the array with placeholders which will be replaced on demand
	//if(viewControllers!=nil)[viewControllers release];
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < numPages; i++) {
		 [controllers addObject:[NSNull null]];
    }
	self.AllPages = controllers;
    [controllers release];
    // a page is the width of the scroll view
    myScroll.pagingEnabled = YES;
	myScroll.directionalLockEnabled=YES;
    myScroll.contentSize = CGSizeMake(myScroll.frame.size.width * numPages, myScroll.frame.size.height);
    myScroll.showsHorizontalScrollIndicator = NO;
    myScroll.showsVerticalScrollIndicator = NO;
    myScroll.scrollsToTop = YES;
	myScroll.clipsToBounds=YES;
    myScroll.delegate = self;
	
    myPage.numberOfPages = numPages;
    myPage.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= numPages) return;
	
    // replace the placeholder if necessary
	if([AllPages count]!=0){
		WaterTableController *controller = [AllPages objectAtIndex:page];
		if((NSNull *)controller == [NSNull null]){
			WaterTableController *controller = [WaterTableController alloc];
			controller = [controller initWithPageNumber:page withTotalArray:self.hisc];
			controller.navagController=self.navigationController;
			[AllPages replaceObjectAtIndex:page withObject:controller];
			[controller release];
		}
		//RainTableController *controller = [[AllPages objectAtIndex:page] retain];
		// add the controller's view to the scroll view
		if (nil == ((WaterTableController *)[AllPages objectAtIndex:page]).view.superview) {
			CGRect frame = myScroll.frame;
			frame.origin.x = frame.size.width * page;
			frame.origin.y = 0;
			((WaterTableController *)[AllPages objectAtIndex:page]).view.frame = frame;
			[myScroll addSubview:((WaterTableController *)[AllPages objectAtIndex:page]).view];
			[((WaterTableController *)[AllPages objectAtIndex:page]) getDataOnNewThread];
		}
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = myScroll.frame.size.width;
    int page = floor((myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    myPage.currentPage = page;
	
	//memory the current page before close
	for (int i = 0; i<self.numPages; i++) {
		if(i == myPage.currentPage) {
			closePage = i;
			break;
		}
	}
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = myPage.currentPage;
	
	//memory the current page before close
	for (int i = 0; i<self.numPages; i++) {
		if(i == myPage.currentPage) {
			closePage = i;
			break;
		}
	}
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = myScroll.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [myScroll scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}


- (void)dealloc {
	[AllPages release];
	//[ntitle release];
	[waterType release];
	[myScroll release];
	[myPage release];
	[orderby release];
	[totalCount release];
	[super dealloc];
}


@end
