//
//  Work2Controller.m
//  navag
//
//  Created by Heiby He on 09-3-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Work2Controller.h"
#import "Work3Controller.h"
#import "MyTableCell.h"
#import "FileManager.h"
#import "Work1Controller.h"
#import "WorkTableController.h"
#import "Const.h"
#import "LocationController.h"
#import "WorkXMLParser.h"
#import "Parser.h"
#import "WebServices.h"
#import "const.h"
#import "smellycatViewController.h"

static Work2Controller *me=nil;
@implementation Work2Controller

@synthesize AllPages,ntitle,gclx,gcgm,workCount,isFirstLoad,numPages,closePage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
		self.navigationItem.backBarButtonItem = left;
		[left release];
		
		UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		[myButton setBackgroundImage:[UIImage imageNamed:@"close_normal.png"] forState:UIControlStateNormal];
		[myButton setBackgroundImage:nil forState:UIControlStateSelected];
		[myButton addTarget:self action:@selector(dismissPopover) forControlEvents:UIControlEventTouchUpInside];
		UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:myButton];
		self.navigationItem.rightBarButtonItem = right;
		[right release];
		[myButton release];
				
		isFirstLoad=YES;
		closePage = 0;
		
		me=self;
		
//		Work1Controller *work1=[Work1Controller sharedWork1];
//		self.gcgm = [work1.gcgm objectAtIndex:work1.selRowIndex];
	}
	return self;
}

+(id)sharedWork2{
	return me;
}

-(void)dismissPopover{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon dismissProject];
}

-(void)getWorkZDCount:(NSString *)item{
	self.workCount = [NSString stringWithFormat:@"%@", item];
}


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewWillAppear:(BOOL)animated{	
	self.contentSizeForViewInPopover = CGSizeMake(320-35, 368);
	[total setTitle:@""];
}
- (void)viewDidAppear:(BOOL)animated{
	if (isFirstLoad) {
		[self reloadData];
		isFirstLoad = NO;
	}else {
		NSInteger temPage = closePage;
//			NSLog(@"WorkTableController*************%d",temPage);
		if (nil == ((WorkTableController *)[AllPages objectAtIndex:temPage]).view.superview) {
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
	if ([self.navigationItem.title length]>11) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190, 30)];
		[label setTextAlignment:UITextAlignmentCenter];
		[label setFont:[UIFont boldSystemFontOfSize:16.0]];
		[label setBackgroundColor:[UIColor clearColor]];
		[label setTextColor:[UIColor whiteColor]];
		[label setText:self.navigationItem.title];
		[self.navigationController.navigationBar.topItem setTitleView:label];
		[label release];
	}
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	// Calculate the current page in scroll view
	int currentPage = myPage.currentPage;
//	printf("这页是:%d\n",currentPage);	
	// unload the pages which are no longer visible
	for (int i = 0; i < [AllPages count]; i++) 
	{
		WorkTableController *viewController = [AllPages objectAtIndex:i];
        if((NSNull *)viewController != [NSNull null])
		{
			if(i < currentPage-1 || i > currentPage+1)
			{
				[viewController.view removeFromSuperview];
				[AllPages replaceObjectAtIndex:i withObject:[NSNull null]];
			}
		}
	}
 /*
	 for(int i=0;i<[AllPages count];i++){
		 if(i!=myPage.currentPage&&i!=(myPage.currentPage+1)&&i!=(myPage.currentPage-1)){
			 printf("这个对象是:%d\n",i);
		 WorkTableController *r=[AllPages objectAtIndex:i];
			 if((NSNull *)r!=[NSNull null]&&r.view.superview!=nil)[r.view removeFromSuperview];
			 if((NSNull *)r!=[NSNull null])[AllPages replaceObjectAtIndex:i withObject:[NSNull null]];
		 }
	 }
	 [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	 // Release anything that's not essential, such as cached data
*/
}

-(void)initWork:(NSString *)titletext{
	self.gclx=titletext;
}

-(void)initWater{
	self.gclx=[NSString stringWithString:@"水库"];
	type=1;
}
- (void)initSluice{
	self.gclx=[NSString stringWithString:@"水闸"];
	type=2;
}
- (void)initRiver{
	self.gclx=[NSString stringWithString:@"河流"];
	type=3;
}
- (void)initDike{
	self.gclx=[NSString stringWithString:@"堤防（段）"];
	type=4;
}
-(void)initFormation{
	self.gclx=[NSString stringWithString:@"海堤（塘）"];
	type=5;	
}
-(void)initPowerStation{
	self.gclx=[NSString stringWithString:@"水电站"];
	type=6;
}
-(void)initIrrigation{
	self.gclx=[NSString stringWithString:@"灌区"];
	type=7;	
}
-(void)initReclamation{
	self.gclx=[NSString stringWithString:@"围垦"];
	type=8;	
}
-(void)initRankIrrigation{
	self.gclx=[NSString stringWithString:@"机电排灌站"];
	type=9;	
}
-(void)initWeiyuan{
	self.gclx=[NSString stringWithString:@"圩垸"];
	type=10;	
}
-(void)initController{
	self.gclx=[NSString stringWithString:@"控制站"];
	type=11;	
}
-(void)initFlood{
	self.gclx=[NSString stringWithString:@"蓄滞（行）洪区"];
	type=12;	
}

-(NSString *)convertUnitByProjectNm:(NSString *)projectNm;
{
    if ([projectNm isEqualToString:@"水库"]) {
        return @"座";
    } else if ([projectNm isEqualToString:@"水闸"]) {
        return @"座";
    } else if ([projectNm isEqualToString:@"电站"]||[projectNm isEqualToString:@"水电站"]) {
        return @"座";
    } else if ([projectNm isEqualToString:@"海塘"]||[projectNm isEqualToString:@"海堤（塘）"]||[projectNm isEqualToString:@"海堤"]) {
        return @"段";
    } else if ([projectNm isEqualToString:@"堤防"]||[projectNm isEqualToString:@"堤防（段）"]) {
        return @"条";
    } else if([projectNm isEqualToString:@"泵站"]) {
        return @"座";
    } else {
        return @"个";
    }
}

-(void)reloadData{
	CGRect frame=[myScroll frame];
	frame.size.height=350;
	[myScroll removeFromSuperview];
	if(myScroll!=nil)[myScroll release];
	myScroll=[[UIScrollView alloc] initWithFrame:frame];
	[self.view addSubview:myScroll];
	
	/*Work1Controller *work1=[Work1Controller sharedWork1];
	[work1 getCount];//get
	NSInteger count=0;
	if([work1.Count count]>work1.selRowIndex){
		count=[[work1.Count objectAtIndex:work1.selRowIndex] integerValue];
	}*/
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    FileManager *config=[[FileManager alloc] init];
    NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWork"]];
    NSArray *locationArray=[config getLocation];
    [config release];
    
    /*
     dscd:地区编码,如‘台州市 331000；
     projectTypeName:工程类型名称,如：水库、水电站、河流、水闸、控制站等；  
     scale：工程规模 如1、2、3 		 
     */
    NSString *convertV = [NSString stringWithFormat:@"%@|%@|%@",[locationArray objectAtIndex:0],gclx,gcgm];
    NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"ProjectStatByScale" Parameter:convertV];
	//parse XML
	WorkZDCountXMLParser *paser=[[WorkZDCountXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
	
	[pool release];
	
    NSInteger count=[workCount intValue];
    NSString *unitNm = [self convertUnitByProjectNm:self.gclx];
    self.navigationItem.title=[NSString stringWithFormat:@"%@(%d%@)",self.ntitle,count,unitNm];
    numPages=(count%WORK_NUMPAGE==0?count/WORK_NUMPAGE:count/WORK_NUMPAGE+1);
	[self loadPages];
}
-(void)loadPages{
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
- (void)loadScrollViewWithPage:(int)page{
	if (page < 0) return;
    if (page >= numPages) return;
	
    // replace the placeholder if necessary
	if([AllPages count]!=0){
		WorkTableController *controller = [AllPages objectAtIndex:page];
		if((NSNull *)controller == [NSNull null]){
			
			WorkTableController *controller = [WorkTableController alloc];
			controller=[controller initWithPageNumber:page wlx:self.gclx wgm:self.gcgm];
			controller.navagController=self.navigationController;
			[AllPages replaceObjectAtIndex:page withObject:controller];
			[controller release];
		}
		//RainTableController *controller = [[AllPages objectAtIndex:page] retain];
		// add the controller's view to the scroll view
		if (nil == ((WorkTableController *)[AllPages objectAtIndex:page]).view.superview) {
			CGRect frame = myScroll.frame;
			frame.origin.x = frame.size.width * page;
			frame.origin.y = 0;
			((WorkTableController *)[AllPages objectAtIndex:page]).view.frame = frame;
			[myScroll addSubview:((WorkTableController *)[AllPages objectAtIndex:page]).view];
			
			[((WorkTableController *)[AllPages objectAtIndex:page]) getDataOnNewThread];
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
	[ntitle release];
	[super dealloc];
}

@end
