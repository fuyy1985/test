//
//  Around1Controller.m
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Around1Controller.h"
#import "Rain2Controller.h"
#import "AroundListViewController.h"
#import "Const.h"
#import "smellycatViewController.h"

static Around1Controller *me;
@implementation Around1Controller

@synthesize numPages,myScroll,myPage,AllPages,orderBy,isFirstLoad,hisc;
@synthesize  hours,totalCount,closePage;
@synthesize typeNm = _typeNm;


@synthesize activityShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withArray:(NSMutableArray *)myArray{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		// remove the count info - winder
		[myArray retain];
		[self.hisc release];
		self.hisc = myArray;
		[myArray release];
		self.totalCount = [NSString stringWithFormat:@"%d",self.hisc.count];
		AllPages=[[NSMutableArray alloc] init];
		me=self;
		orderBy=@"desc";
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

+(id)sharedRain1{
	return me;
}

-(void)dismissPopover{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon dismissAround];
}

-(void)viewWillAppear:(BOOL)animated{
	self.contentSizeForViewInPopover = CGSizeMake(285, 321);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
	if (isFirstLoad) {
		[activityShow startAnimating];
		[self reloadData];
		isFirstLoad = NO;
	}else {
		NSInteger temPage = closePage;
//		NSLog(@"Rain1Controller*************%d",temPage);
		if (nil == ((AroundListViewController *)[AllPages objectAtIndex:temPage]).view.superview) {
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

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidLoad{
	//[self reloadData];
}
	

-(void)reloadData{
	CGRect frame=[myScroll frame];
	frame.size.height=288; //34*9
	[myScroll removeFromSuperview];
	if(myScroll!=nil)[myScroll release];
	myScroll=[[UIScrollView alloc] initWithFrame:frame];
	[self.view addSubview:myScroll];
	
	int countrain=[self.totalCount intValue];
	numPages=(countrain%(NUMPAGE-3)==0?countrain/(NUMPAGE-3):countrain/(NUMPAGE-3)+1);
	[self loadPages];
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning 
{
//	NSLog(@"Rain1Controller ------------- %d",[self.hisc count]);
	if ([self.hisc count]>0){
//		NSLog(@"Rain1Controller ------- %@",[[self.hisc objectAtIndex:1] objectAtIndex:0]);
	}
	
	// Calculate the current page in scroll view
	int currentPage = myPage.currentPage;
	
	// unload the pages which are no longer visible
	for (int i = 0; i < [AllPages count]; i++) 
	{
		AroundListViewController *viewController = [AllPages objectAtIndex:i];
		if((NSNull *)viewController != [NSNull null])
		{		
			//if it has dismissed, use showpage as currentpage or not use currentpage
				if (i==currentPage) {
					return;
				}else {
					[viewController.view removeFromSuperview];
					[AllPages replaceObjectAtIndex:i withObject:[NSNull null]];
				}
		}
	}
}


-(void)loadPages{
    // in the meantime, load the array with placeholders which will be replaced on demand
	//if(viewControllers!=nil)[viewControllers release];
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
    //for (int i = 0; i <= numPages; i++) {
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
	if(numPages > 1)
	{
		[self loadScrollViewWithPage:1];
	}
		
}

- (void)loadScrollViewWithPage:(int)temPage {
    if (temPage < 0||temPage >= numPages) return;
	
    // replace the placeholder if necessary
	if([AllPages count]!=0){
		AroundListViewController *controller = [AllPages objectAtIndex:temPage];
		if((NSNull *)controller == [NSNull null]){
			AroundListViewController *controller = [[AroundListViewController alloc] init];
            controller.typeNm = _typeNm;
			controller.navigationController=self.navigationController;
            controller.pageNo = temPage;
            controller.totalNum = [hisc count];
            controller.contentArray = hisc;
			[AllPages replaceObjectAtIndex:temPage withObject:controller];
			[controller release];
		}
		//AroundListViewController *controller = [[AllPages objectAtIndex:page] retain];
		// add the controller's view to the scroll view
		if (nil == ((AroundListViewController *)[AllPages objectAtIndex:temPage]).view.superview) {
			CGRect frame = myScroll.frame;
			frame.origin.x = frame.size.width * temPage;
			frame.origin.y = 0;
			((AroundListViewController *)[AllPages objectAtIndex:temPage]).view.frame = frame;
			[myScroll addSubview:((AroundListViewController *)[AllPages objectAtIndex:temPage]).view];
			
			if(numPages > 0)
			{
				[((AroundListViewController *)[AllPages objectAtIndex:temPage]) getDataOnNewThread];
			}
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

-(IBAction)OrderByRain{
	if([orderBy compare:@"desc"] == NSOrderedSame)
	{
		orderBy=@"asc";
	}
	else
	{
		orderBy=@"desc";
	}
	[self reloadData];
}

- (void)dealloc {
	[hisc release];
	[myScroll release];
	[myPage release];
	[AllPages release];
	//[alert release];
	[totalCount release];
	[hours release];
	[orderBy release];
	[super dealloc];
}
@end
