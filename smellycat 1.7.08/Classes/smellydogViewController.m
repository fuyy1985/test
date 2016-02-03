//
//  smellycatViewController.m
//  smellycat
//
//  Created by apple on 10-10-30.
//  Copyright zjdayu 2010. All rights reserved.
//

#import "smellydogViewController.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#import "WebServices.h"
#import "typhoonXMLParser.h"
#import "SatelliteXMLParser.h"
#import "const.h"
#import "OneTyphoonView.h"
#import "CustomHornButton.h"
#import "CSMapRouteLayerView.h"
#import "CSHisMapRouteLayerView.h"
#import "TyphoonListPopovers.h"
#import "SearchDogController.h"
#import "CSSatlliteRouterLayer.h"
#import "SatelliteOverlay.h"
#import "SatelliteOverlayView.h"
#import "HisTypAnnotation.h"
#import "NowTypAnnotation.h"
#import "SHisTypAnnotation.h"
#import "SLocationAnnotation.h"
#import "TyphoonSListPopovers.h"
#import "TyphoonNewRealPopover.h"
#import "FileManager.h"

static smellydogViewController *me = nil;
@implementation smellydogViewController
@synthesize loginView,barTyphoonBtn,barCloudBtn,refreshButton,hornButton,barSearchBtn,barTrashBtn,yearNameButton,yListShowView,hideTImgView,hideTBtn,outTFrameImgView,myYListLeftSig,myYListRightSig,myTyphScroll,outFrameImgView,hideImgView,hideBtn;
@synthesize mapView   = _mapView;
@synthesize routeView = _routeView;
@synthesize hisrouteView = _hisrouteView;
@synthesize sHisrouteView = _sHisrouteView;
@synthesize saterouteView =_saterouteView,satelliteOverlay,myTotalCStr;
@synthesize web,gestureView;
@synthesize oneYearTyphList,calibrateYear,yearListTable,yearListArray,minusType,myYLTableBottomVew,newTyphoonArray,oldTyphoonTag,popoverController,popverTyphArray,popversTyphArray,satelliteTimeView,satelliteNameBtn;
@synthesize cloudDic,historyTyphArray,tyGroupHisArray,tyHisArray,tyGroupForeChinaArray,tyForeChinaArray,tyGroupForeHongKongArray,tyForeHongKongArray,tyGroupForeTaiWanArray,tyForeTaiWanArray,tyGroupForeAmericaArray,tyForeAmericaArray,tyGroupForeJapanArray,tyForeJapanArray,lannotation,histannotation,nowShowAnnotation,newTypAnnotationsArr,sLannotation,sHistannotation;
@synthesize typhoonLayer,sTyphoonLayer,satelliteLayer,searchLayer,itsSAnno,mapTypeInt;
@synthesize hisTyphoonKey,actTyphoonKey,sHisTyphoonKey;
@synthesize wattingView,typhoonScrl;
@synthesize projectPacTypeView,projectNameButton,outPFrameImgView,hidePImgView,hidePBtn;
@synthesize lListPopoverController,sListPopoverController,hisPinPopoverController,cListPopoverController,sHisPinPopoverController,oldSearchSig;
@synthesize isVirginCheckTy;
@synthesize isNewVersion,updateBtn,updateView,updateWebView;

#pragma mark -
#pragma mark SYSTEM_METHO
- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.oneYearTyphList = [[NSMutableArray alloc] init];
	self.yearListArray = [[NSMutableArray alloc] init];
	self.newTyphoonArray = [[NSMutableArray alloc] init];
	tyGroupHisArray=[[NSMutableArray alloc] init];
	tyGroupForeChinaArray=[[NSMutableArray alloc] init];
	tyForeChinaArray=[[NSMutableArray alloc] init];
	tyGroupForeHongKongArray=[[NSMutableArray alloc] init];
	tyForeHongKongArray=[[NSMutableArray alloc] init];
	tyGroupForeTaiWanArray=[[NSMutableArray alloc] init];
	tyForeTaiWanArray=[[NSMutableArray alloc] init];
	tyGroupForeAmericaArray=[[NSMutableArray alloc] init];
	tyForeAmericaArray=[[NSMutableArray alloc] init];
	tyGroupForeJapanArray=[[NSMutableArray alloc] init];
	tyForeJapanArray=[[NSMutableArray alloc] init];
	popverTyphArray =[[NSMutableArray alloc] init];
	popversTyphArray = [[NSMutableArray alloc] init];
    
    newTypAnnotationsArr=[[NSMutableArray alloc] init];
	
	//init multiEnable control
	typhoonLayer = NO;
	sTyphoonLayer = NO;
	satelliteLayer = NO;
	mapTypeInt = 0;
    
    //更新检测
    if ([self checkIsNewVersion] == YES) {
        updateBtn.hidden = NO;
    } else {
        updateBtn.hidden = YES;
    }

	[self initAnnotationShowKey];
	[self initAllAnnoKey];
	
	me = self;
	isVirginCheckTy = YES;
	oldTyphoonTag = 0;
    
    [self initiallizeLatestTyphoonInfo];
    
	[self defaultMapRegion];
	[self addWaitting];
	[self initNowYear];
	[self performSelector:@selector(delayTest:) withObject:nil afterDelay:0.2];
	[self addGestureViewButDisabled];
	[self disabledGestureView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
		return YES;
	}else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
		return YES;
	}else {
		return NO;
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	typhoonScrl = nil;
	loginView = nil;
	barTyphoonBtn = nil;
	barCloudBtn = nil;
	barSearchBtn = nil;
	barTrashBtn = nil;
	yearNameButton = nil;
	refreshButton = nil;
	yListShowView = nil;
	hideTImgView = nil;
	hideTBtn = nil;
	outTFrameImgView = nil;
	myYListLeftSig = nil;
	myYListRightSig = nil;
	myTyphScroll = nil;
	self.mapView   = nil;
	self.routeView = nil;
	self.hisrouteView = nil;
	self.saterouteView = nil;
	self.outFrameImgView = nil;
	self.hideImgView = nil;
	self.hideBtn = nil;
	self.satelliteTimeView = nil;
	self.satelliteNameBtn = nil;
	self.wattingView = nil;
	self.typhoonScrl = nil;
	self.projectPacTypeView = nil;
	self.projectNameButton = nil;
	self.outPFrameImgView = nil;
	self.hidePImgView = nil;
	self.hidePBtn = nil;
}

- (void)dealloc {
	//IBOutlet
	[typhoonScrl release];
	[loginView release];
	[barTyphoonBtn release];
	[barCloudBtn release];
	[barSearchBtn release];
	[barTrashBtn release];
	[yearNameButton release];
	[refreshButton release];
	[yListShowView release];
	[hideTImgView release];
	[hideTBtn release];
	[outTFrameImgView release];
	[myYListLeftSig release];
	[myYListRightSig release];
	[myTyphScroll release];
	[hornButton release];
	[_mapView release];
	[outFrameImgView  release];
	[hideImgView  release];
	[hideBtn  release];
	[satelliteTimeView release];
	[satelliteNameBtn release];
    [myTotalCStr release];
	[wattingView release];
	[projectPacTypeView release];
	[projectNameButton release];
	[outPFrameImgView release];
	[hidePImgView release];
	[hidePBtn release];
	
	//Others
	[gestureView release];
	[oneYearTyphList release];
	[yearListTable release];
	[myYLTableBottomVew release];
	[yearListArray release];
	[newTyphoonArray release];
	[_hisrouteView release];
	[_sHisrouteView release];
	[_routeView release];
	[_saterouteView release];
	[satelliteOverlay release];
	[web release];
	[tyGroupHisArray release];
	[tyHisArray release];
	[tyGroupForeChinaArray release];
	[tyForeChinaArray release];
	[tyGroupForeHongKongArray release];
	[tyForeHongKongArray release];
	[tyGroupForeTaiWanArray release];
	[tyForeTaiWanArray release];
	[tyGroupForeAmericaArray release];
	[tyForeAmericaArray release];
	[tyGroupForeJapanArray release];
	[tyForeJapanArray release];
	[historyTyphArray release];
	[popoverController release];
	[lListPopoverController release];
	[sListPopoverController release]; 
	[cListPopoverController release];
	[hisPinPopoverController release];
	[sHisPinPopoverController release];
	[popverTyphArray release];
	[popversTyphArray release];
	[lannotation release];
	[histannotation release];
	[nowShowAnnotation release];
	[sLannotation release];
	[sHistannotation release];
	[cloudDic release];
    
    [updateBtn release];
    [updateView release];
    [updateWebView release];
    [super dealloc];
}

+(id)sharedDog{
	return me;
}


-(IBAction)updateViewContrller:(id)sender;
{
    [self dismissRealTyphoon];
    [self dismissHistoryTyphoon];
    [self dismissLocation];
    [self dismissSearch];
    [self dismissRWP6];
    
    updateWebView.delegate = self;
    updateWebView.scalesPageToFit = YES;
    updateWebView.userInteractionEnabled = YES;
    updateWebView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSURL *url = [NSURL URLWithString:@"http://m.zjwater.gov.cn/zjfxhd.aspx?sysType=6E32679EA81223DE"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [updateWebView loadRequest:request];
    
    if ([self.updateView superview] == nil) {
        [self.view addSubview:updateView];
    }
}

-(IBAction)dismissViewContrller:(id)sender;
{
    [self.updateView removeFromSuperview];
}

-(BOOL)checkIsNewVersion
{
    FileManager *config = [[FileManager alloc] init];
    NSString *versionID = [config getValue:@"versioncount"];
    NSString *versionNowID = VERSIONCOUNT;
    BOOL isNew = NO;
    if ([versionID length] > 0) {
        int vnew = [versionID intValue];
        int vnow = [versionNowID intValue];
        if (vnow < vnew) {
            //需要更新
            isNew = YES;
        }
    }
    return isNew;
}

-(BOOL)checkIsConnect{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags)
    {
        //NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	
    NSURL *testURL = [NSURL URLWithString:@"http://pda.zjfx.gov.cn11111/"];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
	
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
	//return (testConnection ? YES : NO);
}


#pragma mark -
#pragma mark AboutGesture
-(void)addGestureViewButDisabled{	
	gestureView = [[UIView alloc] initWithFrame:CGRectMake(0, 52, 1024, 696)];
	gestureView.backgroundColor = [UIColor clearColor];
	
	UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] 
								   initWithTarget:self action:@selector(handleGesture:)];
	tgr.numberOfTapsRequired = 1;
	tgr.numberOfTouchesRequired = 1;
	[gestureView addGestureRecognizer:tgr];
	[tgr release];
	
	[self.view insertSubview:gestureView atIndex:1];
}

-(void)enabledGestureView{
	self.gestureView.userInteractionEnabled = YES;
	self.gestureView.multipleTouchEnabled = YES;
}

-(void)disabledGestureView{
	self.gestureView.userInteractionEnabled = NO;
	self.gestureView.multipleTouchEnabled = NO;
}

-(void)handleGesture:(id)sender{ 
	if (yearListTable.hidden ==NO && yearListTable!=nil) {
		yearListTable.hidden = YES;
		[yearListTable release];yearListTable= nil;
		myYLTableBottomVew.hidden = YES;
		[myYLTableBottomVew release];myYLTableBottomVew=nil;
	}
	[self disabledGestureView];
}
#pragma mark -
#pragma mark TYPHOON
//calculate this year and evaluate the yearNameButton
-(void)initNowYear{
    /*
	NSDate *thisyear=[NSDate date];
	NSDateFormatter *dateFormat1 = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormat1 setDateFormat: @"Y"]; 
	NSString *datestr = [dateFormat1 stringFromDate:thisyear];
     */
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    int y = [dd year];
    NSString *datestr = [NSString stringWithFormat:@"%d",y];
	[self.yearNameButton setTitle:datestr forState:UIControlStateNormal];
	self.calibrateYear = [datestr intValue];
	for (int i =1945; i<(calibrateYear+1); i++) {
		NSString *tempStr = [[NSString alloc] initWithFormat:@"%d",i];
		[self.yearListArray addObject:tempStr];
		[tempStr release];
	}
}
//fetch up the absolute file path
-(NSString *)typhoonDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *userDocumentsPath = [paths objectAtIndex:0];
    if (!userDocumentsPath) {
        return nil;// can not find the document file
    }
    return [userDocumentsPath stringByAppendingPathComponent:@"latestTyphoon.plist"];
}

//initialize the latest typhoon info
-(void)initiallizeLatestTyphoonInfo
{
    NSString *p = [self typhoonDocumentPath];
    if (!p) {
        return;// can not find the "latestTyphoon.plist"
    }
    NSMutableDictionary *typhoonInfoDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"NODADA",@"TYPHOONINFO",nil];
    NSMutableDictionary *localDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:typhoonInfoDic,@"台风",nil];
    [typhoonInfoDic release];
    [localDic writeToFile:p atomically:YES];
    [localDic release];
}

//write the latest typhoonInfo to file "latestTyphoon.plist"
-(void)writeTyphoonPlistValue:(NSString *)v forKey:(NSString *)k
{
    //Example:v-8月5日6时 k-201108TIME／v－梅花 k－201108NAME；
    if ([v length] ==0&& [k length] ==0) {
        return;// Error data
    }
    NSString *p = [self typhoonDocumentPath];
    if (!p) {
        return;// can not find the "latestTyphoon.plist"
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:p];
    NSMutableDictionary *typhoonDic = [dic objectForKey:@"台风"];
    if (!typhoonDic) {
        return;// fetch the file ERROR
    }
    [typhoonDic setObject:v forKey:k];
    [dic setObject:typhoonDic forKey:@"台风"];
    [dic writeToFile:p atomically:YES];
}

//obtain the value by key
-(NSString *)fetchTyphoonPlistValue:(NSString *)k
{
    //validate the k
    if ([k length]==0) {
        return nil;
    }
    NSString *path = [self typhoonDocumentPath];
    if (!path) {
        return nil;// can not find the "latest.plist"
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSMutableDictionary *typhoonDic = [dic objectForKey:@"台风"];
    if (!typhoonDic) {
        return  nil;// fetch the file ERROR
    }
    NSString * value = [typhoonDic objectForKey:k];
    return value;  
}
                                                                                                                                       
//judge the time whether the forecast date is 24 hours date than history date
-(BOOL)validateForecastDate:(NSString *)d typhoonID:(NSString *)typhoonId
{
    //Latest typhoon time
    NSString *convertTyphoonId = [NSString stringWithFormat:@"%@TIME",typhoonId];
    NSString *historyT = [self fetchTyphoonPlistValue:convertTyphoonId];
    if (historyT == nil||[historyT length]<4||d==nil||[d length] <4) {
        return NO;
    }
    //compare with the forecast time
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M月d日H时"];
    NSDate *historicTime = [formatter dateFromString:historyT];
    NSDate *forecastTime = [formatter dateFromString:d];
    NSTimeInterval result = [historicTime timeIntervalSinceDate:forecastTime];
    
    if (result>6*3600) {
        return YES;
    } else {
        return NO;
    }
}

//deal with the forecast mutableArray
-(void)validateForecastArray:(NSMutableArray *)fArray
{
    if ([fArray count]>0) {
        TFYBList *forecastInfo = [fArray objectAtIndex:0];
        if ([self validateForecastDate:forecastInfo.YBSJ typhoonID:forecastInfo.tfID]==YES) {
            [fArray removeAllObjects];
        }
    }
}


- (void)getOneYearTyphList:(TFList *)tf{
	[oneYearTyphList addObject:tf];
}

-(void)produceOneYearTyphArray:(NSString *)oneYear{
	if (nil!=_hisrouteView) {
		[_hisrouteView removeFromSuperview];
		_hisrouteView = nil;
		[_hisrouteView release];
		oldTyphoonTag = 0;
	}
	
	if (histannotation!=nil) {
		[self.mapView removeAnnotation:histannotation];
		[histannotation release];
		histannotation = nil;
	}
	if (oneYearTyphList) [self.oneYearTyphList removeAllObjects];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    FileManager *config=[[FileManager alloc] init];
    NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mTyphoon"]];
    [config release];
    NSString *converV  = [NSString stringWithFormat:@"%@",oneYear];
    NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonList" Parameter:converV];
    
	typhoonListDogXMLParser *paser=[[typhoonListDogXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];		
	[paser release];
	[pool release];
}


-(void)produceOneYearTyphListView{
	myYListLeftSig.hidden = NO;
	myYListRightSig.hidden = NO;
	if (myTyphScroll!=nil) {
		[myTyphScroll removeFromSuperview];
		myTyphScroll = nil;
		[myTyphScroll release];
	}
	//original frame
	CGRect outTFrame = outTFrameImgView.frame;
	CGRect hideTFrame = hideTImgView.frame;
	CGRect hideTBtnFrame = hideTBtn.frame;
	CGRect yListShowFrame = yListShowView.frame;
	
	NSInteger typhoonCount = [oneYearTyphList count];
	minusType = typhoonCount;
	if (typhoonCount == 0) {
		minusType = 1;
		myYListLeftSig.hidden = YES;
		myYListRightSig.hidden = YES;
		CGFloat sWidth = 150-50;
		CGRect bottomFrame = CGRectMake(83, 3, sWidth, 55);
		CGFloat addOtherFrame = sWidth +83+6;
		
		myTyphScroll = [[UIScrollView alloc] initWithFrame:bottomFrame];
		[yListShowView addSubview:myTyphScroll];
		myTyphScroll.scrollEnabled = YES;
		myTyphScroll.showsHorizontalScrollIndicator = YES;
		myTyphScroll.showsVerticalScrollIndicator = NO;
		myTyphScroll.multipleTouchEnabled=YES;
		myTyphScroll.scrollEnabled=YES;
		myTyphScroll.clipsToBounds=YES;
		myTyphScroll.backgroundColor = [UIColor clearColor];
		myTyphScroll.delegate=self;
		
		[self.yListShowView setFrame:CGRectMake(yListShowFrame.origin.x, yListShowFrame.origin.y, addOtherFrame+30, yListShowFrame.size.height)];
		[self.outTFrameImgView setFrame:CGRectMake(outTFrame.origin.x, outTFrame.origin.y, addOtherFrame,outTFrame.size.height)];
		[self.hideTImgView setFrame:CGRectMake(addOtherFrame, hideTFrame.origin.y, hideTFrame.size.width,hideTFrame.size.height)];
		[self.hideTBtn setFrame:CGRectMake(addOtherFrame, hideTBtnFrame.origin.y, hideTBtnFrame.size.width,hideTBtnFrame.size.height)];
		
		UIImageView *temImgV = [[UIImageView alloc] initWithFrame:CGRectMake(7, 6, 90, 45)];	
		temImgV.image = [UIImage imageNamed:@"listLogo.png"];
		[myTyphScroll addSubview:temImgV];
		[temImgV release];
    } else if (typhoonCount>0&&typhoonCount<6) {
		myYListLeftSig.hidden = YES;
		myYListRightSig.hidden = YES;
		CGFloat sWidth = [oneYearTyphList count]*52-6;
		CGRect bottomFrame = CGRectMake(83, 3, sWidth, 55);
		CGFloat addOtherFrame = sWidth +83+6;
		
		myTyphScroll = [[UIScrollView alloc] initWithFrame:bottomFrame];
		[yListShowView addSubview:myTyphScroll];
		myTyphScroll.scrollEnabled = YES;
		myTyphScroll.showsHorizontalScrollIndicator = YES;
		myTyphScroll.showsVerticalScrollIndicator = NO;
		myTyphScroll.multipleTouchEnabled=YES;
		myTyphScroll.scrollEnabled=YES;
		myTyphScroll.clipsToBounds=YES;
		myTyphScroll.backgroundColor = [UIColor clearColor];
		myTyphScroll.delegate=self;
		
		[self.yListShowView setFrame:CGRectMake(yListShowFrame.origin.x, yListShowFrame.origin.y, addOtherFrame+30, yListShowFrame.size.height)];
		[self.outTFrameImgView setFrame:CGRectMake(outTFrame.origin.x, outTFrame.origin.y, addOtherFrame,outTFrame.size.height)];
		[self.hideTImgView setFrame:CGRectMake(addOtherFrame, hideTFrame.origin.y, hideTFrame.size.width,hideTFrame.size.height)];
		[self.hideTBtn setFrame:CGRectMake(addOtherFrame, hideTBtnFrame.origin.y, hideTBtnFrame.size.width,hideTBtnFrame.size.height)];
		
		for (int i=0; i<[oneYearTyphList count]; i++) {
			TFList *myList = [oneYearTyphList objectAtIndex:([oneYearTyphList count]-i-1)];
			CGRect frame = myTyphScroll.frame;
			frame.origin.x = 52* i;
			frame.origin.y = 2;
			OneTyphoonView *myTemViewa = [[OneTyphoonView alloc] initWithFrame:frame typhoonInfo:myList nowTyphoonInfo:newTyphoonArray];
			myTemViewa.delegate = self;
			[myTyphScroll addSubview:myTemViewa];
			[myTemViewa release];
			myTemViewa = nil;
		}
	} else if (typhoonCount>5) {
		minusType = 6;
		myTyphScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(97, 4, 258, 55)];
		[yListShowView addSubview:myTyphScroll];
		myTyphScroll.scrollEnabled = YES;
		myTyphScroll.showsHorizontalScrollIndicator = YES;
		myTyphScroll.showsVerticalScrollIndicator = NO;
		myTyphScroll.multipleTouchEnabled=YES;
		myTyphScroll.backgroundColor = [UIColor clearColor];
		myTyphScroll.scrollEnabled=YES;
		myTyphScroll.clipsToBounds=YES;
		myTyphScroll.delegate=self;

		[self.yListShowView setFrame:CGRectMake(0,58,405,65)];
		[self.outTFrameImgView setFrame:CGRectMake(0,0,373,65)];
		[self.hideTImgView setFrame:CGRectMake(373,0,30,65)];
		[self.hideTBtn setFrame:CGRectMake(373,0,30,65)];
		
		CGRect oldFrame = self.myTyphScroll.frame;
		myTyphScroll.contentSize = CGSizeMake(1+typhoonCount*52 -6 , oldFrame.size.height);
		for (int i=0; i<[oneYearTyphList count]; i++) {
			TFList *myList = [oneYearTyphList objectAtIndex:([oneYearTyphList count]-i-1)];
			CGRect frame = myTyphScroll.frame;
			frame.origin.x = 52* i;
			frame.origin.y = 2;
			OneTyphoonView *myTemView = [[OneTyphoonView alloc] initWithFrame:frame typhoonInfo:myList nowTyphoonInfo:newTyphoonArray];
			myTemView.delegate = self;
			[myTyphScroll addSubview:myTemView];
			[myTemView release];
			myTemView = nil;
		}
		CGSize myContentSize = myTyphScroll.contentSize;
		CGRect showRect = CGRectMake(myContentSize.width - oldFrame.size.width, 0, oldFrame.size.width, oldFrame.size.height);

		[myTyphScroll scrollRectToVisible:showRect animated:YES];
		myYListLeftSig.hidden = NO;
		myYListRightSig.hidden = YES;
	}
	[self removeWaitting];
}

-(IBAction)showTyphoonListView:(id)sender{
    if ([self checkIsConnect]==NO) {
		UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
		[myAlert show];
        return;
    } 
    
	[self disabledGestureView];
	[self dismissHistoryTyphoon];
	
	[self.sListPopoverController dismissPopoverAnimated:NO];
	
	if (self.yListShowView.superview ==nil) {
		[self addWaitting];
		[self performSelector:@selector(checkIfNewTyphoon) withObject:nil afterDelay:0.000001];
	}
}

-(void)checkIfNewTyphoon{
	if (_routeView!= nil) {
		[_routeView removeFromSuperview];
		[_routeView release];
		_routeView = nil;
	}
	
	//获取是否有当前台风以及具体信息
	[self inspectTyphoonHaveSaveInfo];
	
	if ([newTyphoonArray count]>0) {
		//获取当前台风的预测路径和当前台风的历史路径
		[self typhoonForePath];
		
		_routeView = [[CSMapRouteLayerView alloc] initWithRoute:tyGroupHisArray forNewTyphoonArray:newTyphoonArray foreChina:tyGroupForeChinaArray foreHongKong:tyGroupForeHongKongArray foreTaiWan:tyGroupForeTaiWanArray foreAmerica:tyGroupForeAmericaArray foreJapan:tyGroupForeJapanArray mapView:_mapView withNoNeedMove:NO];
		
	}else {
		[self westPacificMapRegion];
	}
	
	//Even if the yListShowView has existed , we'll also refresh the yListShowview
	[self addWaitting];
	[self performSelector:@selector(prepareShowTyphoonListView) withObject:nil afterDelay:0.001];
	
	[self addWebScroll];
	[self removeWaitting];
}

-(void)prepareShowTyphoonListView{
	[self.barTyphoonBtn setImage:[UIImage imageNamed:@"typhoon_select.png"] forState:UIControlStateNormal];
	[self performSelectorOnMainThread:@selector(hideSatelliteTimeViewView:) withObject:nil waitUntilDone:YES];
	if (yListShowView.superview!=nil) {
		[self removeTyphoonListView];
	}
	
	//new create or update yListShowView
	self.yListShowView.backgroundColor = [UIColor clearColor];
	[self.yListShowView setFrame:CGRectMake(0, 58, 388, 65)];
	[self.view addSubview:self.yListShowView];
	self.typhoonScrl.hidden = NO;
			
	//this year as param
    /*
	NSDate *thisyear=[NSDate date];
	NSDateFormatter *dateFormat1 = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormat1 setDateFormat: @"Y"]; 
	NSString *datestr = [dateFormat1 stringFromDate:thisyear];
     */
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    int y = [dd year];
    NSString *datestr = [NSString stringWithFormat:@"%d",y];
	[yearNameButton setTitle:datestr forState:UIControlStateNormal] ;

	[self produceOneYearTyphArray:datestr];
	[self produceOneYearTyphListView];

}

-(IBAction)hideTyphoonListView:(id)sender{
	[self disabledGestureView];
	[self dismissRealTyphoon];
	[self.barTyphoonBtn setImage:[UIImage imageNamed:@"typhoon_normal.png"] forState:UIControlStateNormal];
	if (yearListTable.hidden ==NO && yearListTable!=nil) {
		yearListTable.hidden = YES;
		[yearListTable release];yearListTable= nil;
		myYLTableBottomVew.hidden = YES;
		[myYLTableBottomVew release];myYLTableBottomVew=nil;
	}
	
	CGRect oldFrame = yListShowView.frame;
	oldFrame.origin.x-=oldFrame.size.width;
	
	[UIView beginAnimations:@"Move Right" context:nil];
	[UIView setAnimationDuration:0.8];
	//这里写子视图要移动什么地方的代码，只写直接改变到的点就可以例如：
	[yListShowView setFrame:oldFrame];
	if ([newTyphoonArray count]>0) {
	}else {
		self.typhoonScrl.hidden = YES;
	}

	[UIView commitAnimations];
	[self performSelector:@selector(removeTyphoonListView) withObject:nil afterDelay:0.5];
	
	//init yearnamebutton's value,for example:if now is 2010 ,set it as 2010
	[self.yearNameButton setTitle:[NSString stringWithFormat:@"%d", calibrateYear] forState:UIControlStateNormal];
}

-(void)removeTyphoonListView{
	[yListShowView removeFromSuperview];
}


-(IBAction)touchNameYearButton:(id)sender{
    if ([self checkIsConnect]==NO) {
		UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
		[myAlert show];
        return;
    } 
    
	[self dismissRealTyphoon];
	CGRect fellowFrame = yListShowView.frame;
	[self.hisPinPopoverController dismissPopoverAnimated:NO];
	if (yearListTable.hidden ==NO && yearListTable!=nil) {
		yearListTable.hidden = YES;
		[yearListTable release];yearListTable= nil;
		myYLTableBottomVew.hidden = YES;
		[myYLTableBottomVew release];myYLTableBottomVew=nil;
		[self disabledGestureView];
		return;
	}
	yearListTable = [[UITableView alloc] initWithFrame:CGRectMake(2,2, 58, 34*8) style:UITableViewStylePlain];
	yearListTable.tag = 111;
	yearListTable.userInteractionEnabled = YES;
	yearListTable.backgroundColor = [UIColor clearColor];
	yearListTable.dataSource = self;
	yearListTable.delegate = self;
	myYLTableBottomVew = [[UIImageView alloc] initWithFrame:CGRectMake(fellowFrame.origin.x+10, fellowFrame.origin.y+fellowFrame.size.height-20, 65, 34*8+6)];
	myYLTableBottomVew.image = [UIImage imageNamed:@"typhoon_background.png"];
	myYLTableBottomVew.contentMode = UIViewContentModeScaleToFill;
	myYLTableBottomVew.userInteractionEnabled = YES;
	[myYLTableBottomVew addSubview:yearListTable];
	[self.view addSubview:myYLTableBottomVew];
	//add gestureView
	[self enabledGestureView];
}


//inspect if the west Pacific Ocean is no typhoon,or is;
//It's true one;
-(void)inspectTyphoonHaveSaveInfo{
	if (newTyphoonArray) [self.newTyphoonArray removeAllObjects];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mTyphoon"]];
	[config release];
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"TyhoonActivity" Parameter:[NSString stringWithString:@""]];
	//parse XML
	typhoonNewDogXMLParser *paser=[[typhoonNewDogXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];		
	[paser release];
	[pool release];
}


/*
//Use it for test
-(void)inspectTyphoonHaveSaveInfo{
	if (newTyphoonArray!=nil) {
		[self.newTyphoonArray removeAllObjects];
	}
	
	//I set one BOOL instance called 'you' as a toggle to control the typhoon
	//button control the custom testing method
	//the .h file has an instance of "you" -- a BOOL type
	TFList *list1 = [[TFList alloc] init];
	list1.tfID = @"201107";
	list1.cNAME = @"蝎虎";
	list1.NAME = @"SANDA";
	[newTyphoonArray addObject:list1];
	[list1 release];
	
	TFList *list0 = [[TFList alloc] init];
	list0.tfID = @"201106";
	list0.cNAME = @"马鞍";
	list0.NAME = @"AREA";
	[newTyphoonArray addObject:list0];
	[list0 release];
    
//    TFList *list2 = [[TFList alloc] init];
//	list2.tfID = @"201105";
//	list2.cNAME = @"米雷";
//	list2.NAME = @"AREA";
//	[newTyphoonArray addObject:list2];
//	[list2 release];
	


	
//	TFList *list1 = [[TFList alloc] init];
//	list1.tfID = @"201014";
//	list1.cNAME = @"暹芭";
//	list1.NAME = @"ChaBa";
//	
//	TFList *list2 = [[TFList alloc] init];
//	list2.tfID = @"201013";
//	list2.cNAME = @"鲇鱼";
//	list2.NAME = @"NY";
//	
//	TFList *list3 = [[TFList alloc] init];
//	list3.tfID = @"201012";
//	list3.cNAME = @"马勒卡";
//	list3.NAME = @"Malakas";
//	TFList *list4 = [[TFList alloc] init];
//	list4.tfID = @"201011";
//	list4.cNAME = @"凡亚比";
//	list4.NAME = @"Fanapi";
//	[newTyphoonArray addObject:list1];
//	[newTyphoonArray addObject:list2];
//	[newTyphoonArray addObject:list3];
//	[newTyphoonArray addObject:list4];
//    [list1 release];
//	[list2 release];
//	[list3 release];
//	[list4 release];
}
*/

- (void)getNewTF:(TFList *)tf{
	[newTyphoonArray addObject:tf];
}

-(void)addWebScroll{
	if (web!=nil) {
		[web removeFromSuperview];
		web = nil;
		[web release];
	}
		
	NSString *iTest;
	BOOL isFirst = YES;
	if ([newTyphoonArray count]>0) {
		iTest = [NSString stringWithString:@""];
		self.actTyphoonKey= YES;
		for (int i=0; i< [tyGroupHisArray count]; i++) {
			
			//I fix the bug on May 8th
			NSArray *myHelpArray = [self.tyGroupHisArray objectAtIndex:i];
			if ([myHelpArray count]>0) 
			{
				TFPathInfo *nowPointInfo = [myHelpArray objectAtIndex:([myHelpArray count] -1) ];
				TFList *nowTyphoonList = [self.newTyphoonArray objectAtIndex:i];
			
				//typhoon real-time dealing
				CLLocationCoordinate2D theCoordinate;
				theCoordinate.latitude = [nowPointInfo.WD floatValue];
				theCoordinate.longitude = [nowPointInfo.JD floatValue];
                            
				NSString*nameStr =  [nowTyphoonList.cNAME isEqualToString:@""]?@"未命名":nowTyphoonList.cNAME;
				NSString*tfIDStr=  nowTyphoonList.tfID;
				NSString*RQSJ2Str=  [nowPointInfo.RQSJ2 isEqualToString:@""]?@"--":nowPointInfo.RQSJ2;
				NSString*WDStr=  nowPointInfo.WD;
				NSString*JDStr=  nowPointInfo.JD;
				NSString*QYStr=  [nowPointInfo.QY isEqualToString:@"0"]?@"--":nowPointInfo.QY;
				NSString*FSStr=  [nowPointInfo.FS isEqualToString:@"0"]?@"--":nowPointInfo.FS;
				NSString*FLStr=  [nowPointInfo.FL isEqualToString:@"0"]?@"--":nowPointInfo.FL;
				NSString*movesdStr=  [nowPointInfo.movesd isEqualToString:@"0"]?@"--":nowPointInfo.movesd;
				NSString*movefxStr=  [nowPointInfo.movefx isEqualToString:@"0"]?@"--":nowPointInfo.movefx;
				NSString*radius7Str=  [nowPointInfo.radius7 isEqualToString:@"0"]?@"--":nowPointInfo.radius7;
				NSString*radius10Str=  [nowPointInfo.radius10 isEqualToString:@"0"]?@"--":nowPointInfo.radius10;
				
				NSString *iTestSmall = [NSString stringWithFormat:@"<font color=\"#FFAAAA\">%@(%@号)</font> 时间:<font color=\"#FFAAAA\">%@</font> 北纬:<font color=\"#FFAAAA\">%@</font> 东经:<font color=\"#FFAAAA\">%@</font> 中心气压:<font color=\"#FFAAAA\">%@百帕</font> 最大风速:<font color=\"#FFAAAA\">%@米/秒</font> 风力:<font color=\"#FFAAAA\">%@级</font> 移动速度:<font color=\"#FFAAAA\">%@公里/时</font> 移动方向:<font color=\"#FFAAAA\">%@</font> 7级风圈半径:<font color=\"#FFAAAA\">%@公里</font> 10级风圈半径:<font color=\"#FFAAAA\">%@公里</font>",nameStr,tfIDStr,RQSJ2Str,WDStr,JDStr,QYStr,FSStr,FLStr,movesdStr,movefxStr,radius7Str,radius10Str];
				if (i<([newTyphoonArray count]-1)) {
					iTest = [iTest stringByAppendingFormat:@"%@,",iTestSmall];
				} else {
					iTest =[iTest stringByAppendingFormat:@"%@。",iTestSmall];
				}
			} else {
				TFList *nowTyphoonList = [self.newTyphoonArray objectAtIndex:i];
				
				if (i<([newTyphoonArray count]-1)) {
					iTest = [iTest stringByAppendingFormat:@" <font color=\"#FFAAAA\">%@(%@号)</font>尚未有路径数据,",nowTyphoonList.cNAME,nowTyphoonList.tfID];
				} else {
					iTest =[iTest stringByAppendingFormat:@" <font color=\"#FFAAAA\">%@(%@号)</font>尚未有路径数据。",nowTyphoonList.cNAME,nowTyphoonList.tfID];
				}
				
			}
		}
		
		//add the scrollView at the bottom of my screen
		//the following line is for the version of 1.2.6 before June 6th
		//web=[[UIWebView alloc] initWithFrame:CGRectMake(42, 5, 388, 26)];
		//the following line is the new version since June 6th
		web=[[UIWebView alloc] initWithFrame:CGRectMake(58, 5, 387, 26)];
		[web setOpaque:NO];
		[web loadHTMLString:[NSString stringWithFormat:@"<html><head><style>body{background-color:transparent;front-size:10px;font-weight:bold}</style></head><body><marquee scrollamount=2.5><font color=\"#FFFFFF\">%@</font></marquee></body></html>", iTest] baseURL:nil];
		[web setUserInteractionEnabled:NO];
		[web setBackgroundColor:[UIColor clearColor]];
		
		[self.typhoonScrl addSubview:web];
		//the following line's frame for the version of 1.2.6
		//[self.typhoonScrl setFrame:CGRectMake(269, 684, 492, 44)];
		//the following line's frame for the new version -- change on June 6th
		[self.typhoonScrl setFrame:CGRectMake(258, 684, 507, 44)];
		if (self.typhoonScrl.superview == nil) {
			[self.view addSubview:self.typhoonScrl];
		}
		
		//if there is new typhoon, the horn will animate to represent that now there is at least one activive typhoon.
		[self ifThereIsActiveTyphoonHorn:YES];

		self.typhoonScrl.hidden = NO;
		[web release];
	} else {
		//the following line is for the version of 1.2.6 before June 6th
		//web=[[UIWebView alloc] initWithFrame:CGRectMake(42, 5, 388, 26)];
		//the following line is the new version since June 6th
		web=[[UIWebView alloc] initWithFrame:CGRectMake(58, 5, 387, 26)];
		[web setOpaque:NO];
		iTest = @"当前西太平洋上无台风";
		[web loadHTMLString:[NSString stringWithFormat:@"<html><head><style>body{background-color:transparent;front-size:10px;font-weight:bold}</style></head><body><marquee scrollamount=4><font color=\"#FFFFFF\">%@</font></marquee></body></html>", iTest] baseURL:nil];
		[web setUserInteractionEnabled:NO];
		[web setBackgroundColor:[UIColor clearColor]];
		[self.typhoonScrl addSubview:web];
		//the following line's frame for the version of 1.2.6
		//[self.typhoonScrl setFrame:CGRectMake(269, 684, 492, 44)];
		//the following line's frame for the new version -- change on June 6th
		[self.typhoonScrl setFrame:CGRectMake(258, 684, 507, 44)];
		if (self.typhoonScrl.superview == nil) {
			[self.view addSubview:self.typhoonScrl];
		}
		
		//now there is no any typhoon on the West Pacific,only add an static horn on the button;
		[self ifThereIsActiveTyphoonHorn:NO];
		
		if (self.yListShowView.superview == nil) {
			self.typhoonScrl.hidden = YES;
		}else {
			self.typhoonScrl.hidden = NO;
		}

		[web release];
	}
}

-(void)ifThereIsActiveTyphoonHorn:(BOOL)signal{
	//here use the tag to identify the UIImageView, and before add the new one ,i should remove the old one;
	UIImageView *myRemoveIV = (UIImageView *)[self.typhoonScrl viewWithTag:5678];
	if (myRemoveIV.superview !=nil) {
		[myRemoveIV removeFromSuperview];
	}
	
	//if signal is YES, scroll the horn in animate
	if (signal) {
		UIImageView *myIMV = [[UIImageView alloc] initWithFrame:CGRectMake(23, 12, 18, 18)];
		myIMV.tag = 5678;
		myIMV.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"horn1.png"],
								 [UIImage imageNamed:@"horn2.png"], [UIImage imageNamed:@"horn3.png"], [UIImage imageNamed:@"horn4.png"],nil];
		myIMV.animationDuration = 3.3f;
		myIMV.animationRepeatCount = 0;
		[myIMV startAnimating];
		[self.typhoonScrl addSubview:myIMV];
		[myIMV release];
	} else {
		UIImageView *myImgV = [[UIImageView alloc] initWithFrame:CGRectMake(24+2, 12, 18, 18)];
		myImgV.tag = 5678;
		myImgV.image = [UIImage imageNamed:@"horn1.png"];
		[self.typhoonScrl addSubview:myImgV];
		[myImgV release];
	}
}

#pragma mark -
#pragma mark Satellite
//cache img
-(IBAction)downLoadSatelliteMapAndShow:(id)sender{
    if ([self checkIsConnect]==NO) {
		UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
		[myAlert show];
        return;
    } 
    
	[self disabledGestureView];
	[self dismissHistoryTyphoon];

    //fix the bug on Aug 24th

    [self addWaitting];
	[self performSelector:@selector(addSatelliteLayer:) withObject:nil afterDelay:0.1];
}

-(IBAction)addSatelliteLayer:(id)sender{
	[self.barCloudBtn setImage:[UIImage imageNamed:@"satellite_select.png"] forState:UIControlStateNormal];
	[self performSelectorOnMainThread:@selector(hideTyphoonListView:) withObject:nil waitUntilDone:YES];
	
	if (self.satelliteOverlay!=nil) {
		[self.mapView removeOverlay:self.satelliteOverlay];
		self.satelliteOverlay = nil;
	}
	
	[self performSelectorOnMainThread:@selector(prepareSatelliteImage) withObject:nil waitUntilDone:YES];
	[self.satelliteTimeView setFrame:CGRectMake(0, 58, 253, 65)];			
	[self.view addSubview:self.satelliteTimeView];

	[self performSelector:@selector(removeWaitting) withObject:nil afterDelay:0.1];
}


-(void)getSatelliteStrByType:(NSString *)temStr{
    self.myTotalCStr = temStr;
}

//fetch imageInfo
-(void)prepareSatelliteImage{
    //get the cloud sting
    FileManager *config = [[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mCloud"]];
    [config release];
    NSURL *contentURL = [WebServices getNRestUrl:baseURL Function:@"Cloud_Transparent" Parameter:@"google"];
    SatelliteTotalStringXMLParser *parser = [[SatelliteTotalStringXMLParser alloc] init];
    [parser parseXMLFileAtURL:contentURL parseError:nil];
    [parser release];
    
	cloudDic = [NSDictionary dictionaryWithJSONString:myTotalCStr];
	NSString *newCloudName = [NSString stringWithFormat:@""];
	NSString *newMinLng = [NSString stringWithFormat:@""];
	NSString *newMinLat = [NSString stringWithFormat:@""];
	NSString *newMaxLng = [NSString stringWithFormat:@""];
	NSString *newMaxLat = [NSString stringWithFormat:@""]; 
    NSString *newCloudUrl = [NSString stringWithFormat:@""]; 
	if (cloudDic!=nil) {
		newCloudName = [cloudDic objectForKey:@"cloudName"];
		newMinLng = [cloudDic objectForKey:@"minLng"];
		newMinLat = [cloudDic objectForKey:@"minLat"];
		newMaxLng = [cloudDic objectForKey:@"maxLng"];
		newMaxLat = [cloudDic objectForKey:@"maxLat"];
        newCloudUrl = [cloudDic objectForKey:@"cloudUrl"];
	}
	
	FileManager *configB = [[FileManager alloc] init];
	NSString *localCloudNm = [NSString stringWithFormat:@"%@",[configB getValue:@"cacheCloudName"]];
	[configB release];
	
	if (newCloudName!=nil&&newMinLng!=nil&&newMinLat!=nil&&newMaxLng!=nil&&newMaxLat!=nil&&newCloudUrl!=nil&&[newCloudName isEqualToString:localCloudNm]==NO) {
		FileManager *config = [[FileManager alloc] init];
		[config writeConfigFile:@"cacheCloudName" ValueForKey:newCloudName];
		[config writeConfigFile:@"cacheMinLng" ValueForKey:newMinLng];
		[config writeConfigFile:@"cacheMinLat" ValueForKey:newMinLat];
		[config writeConfigFile:@"cacheMaxLng" ValueForKey:newMaxLng];
		[config writeConfigFile:@"cacheMaxLat" ValueForKey:newMaxLat];
        [config writeConfigFile:@"cacheNewCloudUrl" ValueForKey:newCloudUrl];
        
		[config release];
	} else if ([localCloudNm length]>6) {
		FileManager *config = [[FileManager alloc] init];
		newCloudName = localCloudNm;
		newMinLng = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMinLng"]];
		newMinLat = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMinLat"]];
		newMaxLng = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMaxLng"]];
		newMaxLat = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMaxLat"]];
		[config release];
	}
	
	NSString *totolStr = [NSString stringWithFormat:@""];
	if ([newCloudName length]>6&&newMinLng!=nil&&newMinLat!=nil&&newMaxLng!=nil&&newMaxLat!=nil) {
		NSArray *array = [NSArray arrayWithObjects:newCloudName,newMinLng,newMinLat,newMaxLng,newMaxLat,nil];

		NSString *year = [newCloudName substringWithRange:NSMakeRange(0,4)];
		NSString *mouth = [newCloudName substringWithRange:NSMakeRange(4,2)];
		NSString *day = [newCloudName substringWithRange:NSMakeRange(6,2)];
		NSString *time = [newCloudName substringWithRange:NSMakeRange(8,2)];
		NSString *minute = [newCloudName substringWithRange:NSMakeRange(10,2)];
		totolStr = [NSString stringWithFormat:@"红外图:%@-%@-%@ %@:%@",year,mouth,day,time,minute];
		[self performSelectorOnMainThread:@selector(cacheImage:) withObject:newCloudName waitUntilDone:YES];
		[self.satelliteNameBtn setText:totolStr];
		[self addSatelliteView:array];
	} else {
		[self.satelliteNameBtn setText:[NSString stringWithFormat:@"获取失败,请点击图标重新获取"]];
	}
}

-(void)warningErrorFetchImage{
    [self.satelliteNameBtn setText:[NSString stringWithFormat:@"获取失败,请点击图标重新获取"]];
}

- (void)cacheImage: (NSString *)cCloudName
{
    FileManager *config = [[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"cacheNewCloudUrl"]];
    [config release];
    
	NSString *ImageURLString = [NSString stringWithFormat:@"%@%@",baseURL,cCloudName];
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    // Generate a unique path to a resource representing the image you want
    NSString *filename = [NSString stringWithFormat:@"%@",cCloudName];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
	
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        // The file doesn't exist, we should get a copy of it
		
        // Fetch image
		NSData *data = [NSData dataWithContentsOfURL:ImageURL];
        UIImage *image = [[[UIImage alloc] initWithData: data] autorelease];
        
        // Do we want to round the corners?
        
        // Is it PNG or JPG/JPEG?
        // Running the image representation function writes the data from the image to a file
        if([ImageURLString rangeOfString: @".png" options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
        }
        else if(
                [ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound || 
                [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
                )
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
        }
    }
}

-(void)addSatelliteView:(NSArray *)cArray{
	if (cArray!=nil) {
//		_saterouteView =[[CSSatlliteRouterLayer alloc] initWithRoute:_mapView satelliteMapName:cArray];
		if (self.satelliteOverlay ==nil) {
			self.satelliteLayer = YES;
			SatelliteOverlay *temOverlay = [[SatelliteOverlay alloc] initWithVirginInfo:cArray];
			self.satelliteOverlay = temOverlay;
			[self.mapView insertOverlay:self.satelliteOverlay atIndex:0];
			[temOverlay release];
		}
		
		//setRegion
		MKCoordinateRegion newRegion;
		newRegion.center.latitude = 28.998531;
		newRegion.center.longitude = 134.736328;
		newRegion.span.latitudeDelta = 52.153725;
		newRegion.span.longitudeDelta = 90.000000;
		[self.mapView setRegion:newRegion animated:YES];
		
	} else {
		[self.satelliteNameBtn setText:[NSString stringWithFormat:@"无法获取云图"]];
	}

}

-(IBAction)hideSatelliteTimeViewView:(id)sender{
	if (nil!=satelliteTimeView.superview) {
		[self.barCloudBtn setImage:[UIImage imageNamed:@"satellite_normal.png"] forState:UIControlStateNormal];
		self.barCloudBtn.enabled = YES;
		CGRect oldFrame = satelliteTimeView.frame;
		oldFrame.origin.x-=oldFrame.size.width;
		[UIView beginAnimations:@"HIDESATELLITE" context:nil];
		[UIView setAnimationDuration:0.8];
		
		//这里写子视图要移动什么地方的代码，只写直接改变到的点就可以例如：
		[satelliteTimeView setFrame:oldFrame];
		[satelliteTimeView removeFromSuperview];
		[UIView commitAnimations];
	}

}

/*
- (UIImage *) getCachedImage: (NSString *) ImageURLString
{
    NSString *filename = [NSString stringWithFormat:@"cache"];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    
    UIImage *image;
    
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
    }
    else
    {
        // get a new one
        [self cacheImage: ImageURLString];
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
	
    return image;
}
 */

#pragma mark -
#pragma mark HISTORY_TYPHOON_ARRAY
//获取历史台风信息和画图方法调用
-(void)dealWithHistoryTyphoonArray:(NSString *)tfid{
	historyTyphArray = [NSMutableArray array];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mTyphoon"]];
	[config release];
	NSString *convertV1 = [NSString stringWithFormat:@"%@",tfid];
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonHistoryTracks" Parameter:convertV1];
	historyTyphoonDogXMLParser *parseHis = [[historyTyphoonDogXMLParser alloc] init];
	[parseHis parseXMLFileAtURL:countURL parseError:nil];
	[parseHis release];
	[pool release];
	if (nil!=_hisrouteView) {
		[_hisrouteView removeFromSuperview];
		_hisrouteView = nil;
		[_hisrouteView release];
	}
	
	_hisrouteView = [[CSHisMapRouteLayerView alloc] initWithRoute:historyTyphArray mapView:_mapView];
}


-(void)getHistoryTyphoonPath:(TFPathInfo *)item{
	[self.historyTyphArray addObject:item];
}

-(void)delayAddHistAnnotionToAnimate{
	[self.mapView addAnnotation:histannotation];
}

#pragma mark -
#pragma mark NOW TYPHOONHISTORYPATH AND FORECASTPATH
-(void)defaultMapRegion{
		//	lati:49.837982
		//	lonti:0.000000
		//	laDelta:139.213562
		//	loDelta:360.000000
		MKCoordinateRegion newRegion;
		newRegion.center.latitude = 49.837982;
		newRegion.center.longitude = 0.000000;
		newRegion.span.latitudeDelta = 139.213562;
		newRegion.span.longitudeDelta = 360.000000;
		[self.mapView setRegion:newRegion animated:NO];
}

-(void)westPacificMapRegion{
//lati:24.046465
//lonti:133.154297
//laDelta:54.132542
//loDelta:90.000000
	
	MKCoordinateRegion wpRegion = {{24.046465,133.154297},{54.132542,90.000000}};
	[self.mapView setRegion:wpRegion animated:YES];
}
-(IBAction)delayTest:(id)sender{	 
	[self addWaitting];
	[self performSelector:@selector(handleGesture:)];
	[self dismissHistoryTyphoon];
	
	//Hide the  list box of search
	[self.sListPopoverController dismissPopoverAnimated:NO];
	
	//Remove the old view
	if (_routeView!= nil) {
		[_routeView removeFromSuperview];
		[_routeView release];
		_routeView = nil;
		
		//tyHisArray = [[NSMutableArray alloc] init];
	}
	
	//Fetch the newTyphoonArr
	[self inspectTyphoonHaveSaveInfo];
	
	//Judge if there is new typhoon info
	if ([newTyphoonArray count]>0) {
        //Prepare for the History route info of the activity typhoon
		[self typhoonHisPath];
		//Prepare for the frecast route info of the activity typhoon
		[self typhoonForePath];
        
		//Draw the activity typhoon route
		_routeView = [[CSMapRouteLayerView alloc] initWithRoute:tyGroupHisArray forNewTyphoonArray:newTyphoonArray foreChina:tyGroupForeChinaArray foreHongKong:tyGroupForeHongKongArray foreTaiWan:tyGroupForeTaiWanArray foreAmerica:tyGroupForeAmericaArray foreJapan:tyGroupForeJapanArray mapView:_mapView withNoNeedMove:NO];
		//Show the typhoon listView
		[self performSelector:@selector(prepareShowTyphoonListView) withObject:nil afterDelay:0.001];
	}else {
		//if the sys check the typhoon for the first time ,in fact,there is nothing,we use the method of defaultmapregion or else we 'll use westpacificregion.
		if (isVirginCheckTy==YES) {
			[self defaultMapRegion];
		} else {
			//refresh the typhoonlistview,while the active typhoon has been removed ,my typhoonlistview will not refresh,that is the bug
			//here is the solution
			[self performSelector:@selector(prepareShowTyphoonListView) withObject:nil afterDelay:0.001];
			[self westPacificMapRegion];
		}
	}
	
	isVirginCheckTy = NO;
	//Show the webSctrollView at bottom of my Sys
	[self addWebScroll];

	[self removeWaitting];
}

-(IBAction)refreshNowTyphoon:(id)sender{
    if ([self checkIsConnect]==NO) {
		UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
		[myAlert show];
        return;
    } 
    
	[self addWaitting];
	[self dismissRealTyphoon];

	[self performSelector:@selector(delayTest:) withObject:nil afterDelay:0.2];
}

//获取多个台风的历史路径和预报路径
-(void)typhoonHisPath{
	if (tyGroupHisArray!=nil) {
		[tyGroupHisArray removeAllObjects];
	}
    
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mTyphoon"]];
	[config release];
	
	for(int i=0;i<[newTyphoonArray count];i++){
		tyHisArray = [[NSMutableArray alloc] init];
		TFList *infoHPath = [newTyphoonArray objectAtIndex:i];
		
        // Get Typhoon History Path List
        NSString *convertV1 = [NSString stringWithFormat:@"%@",infoHPath.tfID];
        NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonHistoryTracks" Parameter:convertV1];
		typhoonDogXMLParser *parseHis = [[typhoonDogXMLParser alloc] init];
		[parseHis parseXMLFileAtURL:countURL parseError:nil];
		[parseHis release];
        
        //write latest typhoon info in plist file
        //201108NAME-苗白
        if ([tyHisArray count]>0) {
            TFPathInfo *info = [tyHisArray lastObject];
            [self writeTyphoonPlistValue:infoHPath.cNAME forKey:[NSString stringWithFormat:@"%@NAME",infoHPath.tfID]]; 
            [self writeTyphoonPlistValue:info.RQSJ2 forKey:[NSString stringWithFormat:@"%@TIME",infoHPath.tfID]]; 
        }
        
		[tyGroupHisArray addObject:tyHisArray];
		[tyHisArray release];
	}
}

-(void)getTyHisPath:(TFPathInfo *)item{
	[self.tyHisArray addObject:item];
}

-(void)typhoonForePath{
	if (tyGroupForeChinaArray!=nil) {
		[tyGroupForeChinaArray removeAllObjects];
	}
	if (tyGroupForeHongKongArray!=nil) {
		[tyGroupForeHongKongArray removeAllObjects];
	}
	if (tyGroupForeTaiWanArray!=nil) {
		[tyGroupForeTaiWanArray removeAllObjects];
	}
	if (tyGroupForeAmericaArray!=nil) {
		[tyGroupForeAmericaArray removeAllObjects];
	}
	if (tyGroupForeJapanArray!=nil) {
		[tyGroupForeJapanArray removeAllObjects];
	}
    
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mTyphoon"]];
	[config release];

    
	//NSArray *foreList = [NSArray arrayWithObjects:@"201014",nil];
	for(int i=0;i<[newTyphoonArray count];i++){
		//NSArray *foreList = [NSArray arrayWithObjects:@"201010",nil];
		TFList *infoFPath= [newTyphoonArray objectAtIndex:i];
        // Get Typhoon yubao Path List
        NSString *convertV2 = [NSString stringWithFormat:@"%@",infoFPath.tfID];
        NSURL *countURL2=[WebServices getNRestUrl:baseURL Function:@"TyphoonForecastTracks" Parameter:convertV2];

		typhoonYBDogXMLParser *parseFore = [[typhoonYBDogXMLParser alloc] init];
		[parseFore parseXMLFileAtURL:countURL2 parseError:nil];
		[parseFore release];
		
        //check 
        [self validateForecastArray:tyForeChinaArray];
        [self validateForecastArray:tyForeHongKongArray];
        [self validateForecastArray:tyForeTaiWanArray];
        [self validateForecastArray:tyForeAmericaArray];
        [self validateForecastArray:tyForeJapanArray];
		// add
		[tyGroupForeChinaArray addObject:tyForeChinaArray];
		[tyGroupForeHongKongArray addObject:tyForeHongKongArray];
		[tyGroupForeTaiWanArray addObject:tyForeTaiWanArray];        
		[tyGroupForeAmericaArray addObject:tyForeAmericaArray];        
		[tyGroupForeJapanArray addObject:tyForeJapanArray];
        // release
		[tyForeChinaArray release];tyForeChinaArray = nil;
		[tyForeHongKongArray release];  tyForeHongKongArray= nil;
		[tyForeTaiWanArray release];tyForeTaiWanArray = nil;
		[tyForeAmericaArray release]; tyForeAmericaArray= nil;
		[tyForeJapanArray release];tyForeJapanArray = nil;
		// init
		tyForeChinaArray = [[NSMutableArray alloc] init];
		tyForeHongKongArray  = [[NSMutableArray alloc] init];
		tyForeTaiWanArray = [[NSMutableArray alloc] init];
		tyForeAmericaArray = [[NSMutableArray alloc] init];
		tyForeJapanArray = [[NSMutableArray alloc] init];		
	}
}
-(void)getTyForePath:(TFYBList *)item{
	if ([item.TM compare:@"中国"]==NSOrderedSame) {
		[self.tyForeChinaArray addObject:item];
	} else if ([item.TM compare:@"香港"]==NSOrderedSame) {
		[self.tyForeHongKongArray addObject:item];
	} else if ([item.TM compare:@"台湾"]==NSOrderedSame) {
		[self.tyForeTaiWanArray addObject:item];
	} else if ([item.TM compare:@"美国"]==NSOrderedSame) {
		[self.tyForeAmericaArray addObject:item];
	} else if ([item.TM compare:@"日本"]==NSOrderedSame) {
		[self.tyForeJapanArray addObject:item];
	}
}

- (void)animateToWorld:(NSArray *)jwArray
{    
    MKCoordinateRegion current = self.mapView.region;
	if (searchLayer) {
		MKCoordinateRegion zoomOutS = { { (current.center.latitude + [[jwArray objectAtIndex:1] floatValue]*(1+0.05))/2.0 , (current.center.longitude + [[jwArray objectAtIndex:0] floatValue])*(1+0.05)/2.0 }, {5,5} };   
		[ self.mapView setRegion:zoomOutS animated:YES];
	}else {
		MKCoordinateRegion zoomOut = { { (current.center.latitude + [[jwArray objectAtIndex:1] floatValue])/2.0+0.045 , (current.center.longitude + [[jwArray objectAtIndex:0] floatValue])/2.0+0.045 }, {6.1794, 10.425} };
		[ self.mapView setRegion:zoomOut animated:YES];
	}
	
	[self performSelector:@selector(animateToPlace:) withObject:jwArray  afterDelay:0.8];        

}

- (void)animateToPlace:(NSArray *)jwArray
{	
    MKCoordinateRegion region;
	if (searchLayer) {
		region.center.longitude =[[jwArray objectAtIndex:0] floatValue]*1.0004;
		region.center.latitude  = [[jwArray objectAtIndex:1] floatValue];
		MKCoordinateSpan span = {0.060024,0.102545};
		region.span = span;
	}else {
		region.center.longitude =[[jwArray objectAtIndex:0] floatValue]*0.9983;
		region.center.latitude  = [[jwArray objectAtIndex:1] floatValue];
		MKCoordinateSpan span = {0.241864,0.403681};
		region.span = span;
	}
	
    [ self.mapView setRegion:region animated:YES];
	

	[self performSelector:@selector(delayAddAnnotionToAnimate) withObject:nil afterDelay:0.3];
}

-(void)delayAddAnnotionToAnimate{
	if (lannotation!=nil) {
		[self.mapView addAnnotation:lannotation];
	}
}


-(void)preparePoverTyphoon:(TFList *)tfIDInfo{
	[self dismissHistoryTyphoon];
	[self dismissRealTyphoon];
	[self.sListPopoverController dismissPopoverAnimated:NO];

	
	if (![self.popoverController.contentViewController isKindOfClass:[TyphoonListPopovers class]]) 
	{	
		self.popoverController = nil;
	}
	TyphoonListPopovers* content = [[TyphoonListPopovers alloc] initWithNibName:@"TyphoonListPopovers" bundle:nil withList:popverTyphArray withTYphoonInfo:tfIDInfo withInfo:nil];
	//TyphoonListPopovers* content = [[TyphoonListPopovers alloc] initWithNibName:@"TyphoonListPopovers" bundle:nil withList:popverTyphArray withTYphoonInfo:tfIDInfo]; 
	UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 
	aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
	aPopover.delegate = self;
	[content release];
	[aPopover setPopoverContentSize:CGSizeMake(266, 347)];
	// Store the popover in a custom property for later use. 
	self.popoverController = aPopover; 
	[aPopover release];
	
	//[self.popoverController presentPopoverFromRect:[(UIButton *)[[self.view viewWithTag:[tfIDInfo.tfID intValue]] bounds] inView:(UIButton *)[self.view viewWithTag:[tfIDInfo.tfID intValue]] permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
	//CGRect oldFrame = [(UIButton *)[self.view viewWithTag:[tfIDInfo.tfID intValue]] bounds];
	CGRect oldFrame = [(UIButton *)[self.view viewWithTag:[tfIDInfo.tfID intValue]] bounds]; 
//	NSLog(@"---%d",[tfIDInfo.tfID intValue]);
	
	//while typhoonCount is 1,2,3, I deal with the listView below this line; 
//	if (minusType==1) {
//		oldFrame.origin.x-=51;
//	} else if(minusType ==4) {
//		oldFrame.origin.x-=78;
//	} else if (minusType==5) {
//		oldFrame.origin.x-=107;
//	} else if (minusType ==6) {
//		oldFrame.origin.x-=107;
//	}
	
	if (minusType==1) {
		oldFrame.origin.x+=0;
	} else if(minusType ==2) {
		oldFrame.origin.x-=25;
	} else if(minusType ==3) {
		oldFrame.origin.x-=52;
	} else if(minusType ==4) {
		oldFrame.origin.x-=78;
	} else if (minusType==5) {
		oldFrame.origin.x-=107;
	} else if (minusType ==6) {
		oldFrame.origin.x-=107;
	}
	
	
	[self.popoverController presentPopoverFromRect:oldFrame inView:(UIButton *)[self.view viewWithTag:[tfIDInfo.tfID intValue]] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(IBAction)preparePoverTyphoonWithNewStyle:(id)sender{
    if ([self checkIsConnect]==NO) {
		UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
		[myAlert show];
        return;
    } 
    
	if (![self.popoverController.contentViewController isKindOfClass:[TyphoonNewRealPopover class]]) 
	{	
		self.popoverController = nil;
	}
	
	//judge there is no activity typhoon, the follow code(if{...}) will jump to the end of this method
	if ([newTyphoonArray count]==0) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"当前西太平洋无活动台风" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
		return;
	}
	UIButton *myButton = (UIButton *)sender;
	TyphoonNewRealPopover *myViewController = [[TyphoonNewRealPopover alloc] initwithTyphoonInfoArray:newTyphoonArray historyArray:tyGroupHisArray];
	UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController:myViewController];
	aPopover.delegate = self;
	[myViewController release];
	[aPopover setPopoverContentSize:CGSizeMake(266, 226)];
	self.popoverController = aPopover;
	[aPopover release];
	CGRect oldFrame = [myButton bounds]; 
	[self.popoverController presentPopoverFromRect:oldFrame inView:myButton permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}


#pragma mark -
#pragma mark Custom Delegate
-(void)dealWithNonActiveTyphoon:(OneTyphoonView *)myView{
    if ([self checkIsConnect]==NO) {
        return;
    } 
	[self addWaitting];
}
-(void)dealWithNonActiveTyphoon:(OneTyphoonView *)myView convertTfID:(NSInteger)myTfid andWithTYName:(NSString *)myTfName{
    NSInteger newTyphoonTag = myTfid;
    NSString *newTyphoonTagStr = [NSString stringWithFormat:@"%d",myTfid];
    if ([self checkIsConnect]==NO) {
		UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
		[myAlert show];
       if (self.oldTyphoonTag>0&&oldTyphoonTag!=newTyphoonTag) {
           OneTyphoonView *myTempView = (OneTyphoonView *)[self.view viewWithTag:oldTyphoonTag];
           if (myTempView.bottomSignal!=YES) {
               [myTempView performSelector:@selector(realJumpButtom:)];
           }
           self.oldTyphoonTag = newTyphoonTag;
       } else if(oldTyphoonTag==newTyphoonTag) {
           self.oldTyphoonTag = 0;
       } else{
           self.oldTyphoonTag = newTyphoonTag;
       }
        return;
    } 
    
	[self dismissRealTyphoon];
	[self dismissHistoryTyphoon];
	
	if (self.oldTyphoonTag>0&&oldTyphoonTag!=newTyphoonTag) {
		OneTyphoonView *myTempView = (OneTyphoonView *)[self.view viewWithTag:oldTyphoonTag];
		if (myTempView.bottomSignal!=YES) {
			[myTempView performSelector:@selector(realJumpButtom:)];
		}
		myTempView = nil;
		[self performSelectorOnMainThread:@selector(dealWithHistoryTyphoonArray:) withObject:newTyphoonTagStr waitUntilDone:YES];
		self.oldTyphoonTag = newTyphoonTag;
		
		NSInteger counta = [historyTyphArray count];
		if (counta > 0) {
			if (histannotation!=nil) {
				[self.mapView removeAnnotation:histannotation];
				[histannotation release];
				histannotation = nil;
			}
			
			TFPathInfo *info = [historyTyphArray objectAtIndex:(counta-1)];
			CLLocationCoordinate2D coordinate;
			coordinate.latitude = [info.WD floatValue];
			coordinate.longitude =[info.JD floatValue];
			
			histannotation = [[HisTypAnnotation alloc] initWithCoordinate:coordinate];
			histannotation.TyphShowInfo = [NSString stringWithFormat:@"%@(%@)",myTfName,newTyphoonTagStr];
			self.hisTyphoonKey=YES;
			
			[self performSelector:@selector(delayAddHistAnnotionToAnimate) withObject:nil afterDelay:0.004];
		}
	} else if(oldTyphoonTag==newTyphoonTag) {
		if (nil!=_hisrouteView) {
			[_hisrouteView removeFromSuperview];
			_hisrouteView = nil;
			[_hisrouteView release];
		}
		
		if (histannotation!=nil) {
			[self.mapView removeAnnotation:histannotation];
			[histannotation release];
			histannotation = nil;
		}
		self.oldTyphoonTag = 0;
		return;
	} else {
		[self performSelectorOnMainThread:@selector(dealWithHistoryTyphoonArray:) withObject:newTyphoonTagStr waitUntilDone:YES];
		self.oldTyphoonTag = newTyphoonTag;
		
		NSInteger count = [historyTyphArray count];
		if (count > 0) {
			if (histannotation!=nil) {
				[self.mapView removeAnnotation:histannotation];
				[histannotation release];
				histannotation = nil;
			}
			TFPathInfo *info = [historyTyphArray objectAtIndex:(count-1)];
			CLLocationCoordinate2D coordinate;
			coordinate.latitude = [info.WD floatValue];
			coordinate.longitude =[info.JD floatValue];
			histannotation = [[HisTypAnnotation alloc] initWithCoordinate:coordinate];
			self.hisTyphoonKey= YES;
			histannotation.TyphShowInfo = [NSString stringWithFormat:@"%@(%@)",myTfName,newTyphoonTagStr];
			[self performSelector:@selector(delayAddHistAnnotionToAnimate) withObject:nil afterDelay:0.004];
		}
	}
	
	[self removeWaitting];
}

-(void)dealWithActiveTyphoon:(OneTyphoonView *)myView convertTfID:(NSInteger)myTfid  andWithTYName:(NSString *)myTfName{
	TFList *myinfo=[TFList tflist];
	myinfo.tfID = [NSString stringWithFormat:@"%d",myTfid];
	myinfo.cNAME = myTfName;
	int j = 0;
	for (int i= 0; i<[newTyphoonArray count]; i++) {
		TFList *tempTFList = [newTyphoonArray objectAtIndex:i];
		if (myTfid ==[tempTFList.tfID intValue]) {
			j= i;
			break;
		}
	}
	
	NSMutableArray *helpArray = [tyGroupHisArray objectAtIndex:j];
	
	if ([helpArray count]>0) {
		self.popverTyphArray = helpArray;
		
		// Add the annotation of the activie typhoon
		//nowShowAnnotation = [self.newTypAnnotationsArr objectAtIndex:j];
		
		MKCoordinateRegion pointRegion;
		pointRegion.center =nowShowAnnotation.coordinate;
		pointRegion.span.latitudeDelta = 30;
		pointRegion.span.longitudeDelta = 50;
		[self.mapView setRegion:pointRegion animated:YES];
		
		// Add the annotation of the activie typhoon
		//self.actTyphoonKey = YES;
		
		[self mapView:self.mapView didAddAnnotationViews:nil];;
		[self performSelector:@selector(preparePoverTyphoon:) withObject:myinfo afterDelay:0.01];//delay 1
		[myinfo release];
	} else {
		UIAlertView	*alertview = [[UIAlertView alloc] initWithTitle:@"当前选中台风尚无路径信息" message:nil delegate:self 
								  
												  cancelButtonTitle:@"确定" otherButtonTitles:nil];
		
		[alertview show];
		[alertview release];
	}
}

#pragma mark -
#pragma mark UITableViewDelegate And UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger backthings = 0;
	if (tableView.tag==111) {
		backthings = [yearListArray count];
	}
	return backthings;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	if (tableView.tag==111) {
		NSString *cellTemyear = [yearListArray objectAtIndex:([yearListArray count]-indexPath.row-1)];
		NSString *selectYear = yearNameButton.titleLabel.text;
		NSString *CellIdentifier;
		if (([cellTemyear intValue]-[selectYear intValue]) ==0 ) {
			CellIdentifier = @"ListCellIdentifierA";
		} else {
			CellIdentifier = @"ListCellIdentifier";
		}
		
		cell = [yearListTable dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.textLabel.text = cellTemyear;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		if (([cellTemyear intValue]-[selectYear intValue]) ==0 ) {
			cell.textLabel.textColor = [UIColor blueColor];
		}
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	return cell;	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 34.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self disabledGestureView];
	if (tableView.tag==111) {
		if (yearListTable.hidden ==NO && yearListTable!=nil) {
			yearListTable.hidden = YES;
			myYLTableBottomVew.hidden = YES;
			[yearListTable release];yearListTable= nil;
		}	
		myYLTableBottomVew.hidden = YES;
		
		
		NSString *cellTemyear = [yearListArray objectAtIndex:([yearListArray count]-indexPath.row-1)];
		[yearNameButton setTitle:cellTemyear forState:UIControlStateNormal] ;
		
		//hide popover
		[self dismissRealTyphoon];

		if ([cellTemyear intValue]<self.calibrateYear&&[cellTemyear intValue]>=1945) {
			//produce one year's tflist
			[self addWaitting];
			[self performSelector:@selector(produceOneYearTyphArray:) withObject:cellTemyear afterDelay:0.000001];
			[self performSelector:@selector(produceOneYearTyphListView) withObject:nil afterDelay:0.000002];
		} else if (([cellTemyear intValue]-self.calibrateYear)==0) {
			//if it's now year, the system should update
			[self addWaitting];
			[self performSelector:@selector(checkIfNewTyphoon) withObject:nil afterDelay:0.000001];
		}
	}	
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	[self dismissRealTyphoon];

	self.myYListLeftSig.hidden = NO;
	self.myYListRightSig.hidden = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	CGSize myScrollSize = myTyphScroll.contentSize;
	if (scrollView.contentOffset.x == 0) {
		self.myYListLeftSig.hidden = YES;
		self.myYListRightSig.hidden = NO;
    }
    else if (scrollView.contentOffset.x == (myScrollSize.width-258)) {
		self.myYListLeftSig.hidden = NO;
		self.myYListRightSig.hidden = YES;
    } else {
		self.myYListLeftSig.hidden = NO;
		self.myYListRightSig.hidden = NO;
	}

}



#pragma mark -
#pragma mark mapView delegate functions
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	// turn off the view of the route as the map is chaning regions. This prevents
	// the line from being displayed at an incorrect positoin on the map during the
	// transition. 
	_routeView.hidden = YES;
	_hisrouteView.hidden = YES;
	_sHisrouteView.hidden = YES;
	_saterouteView.hidden =YES;
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	// re-enable and re-poosition the route display. 
	
	
	_routeView.hidden = NO;
	[_routeView setNeedsDisplay];
	
	_hisrouteView.hidden = NO;
	[_hisrouteView setNeedsDisplay];
	
	_sHisrouteView.hidden = NO;
	[_sHisrouteView setNeedsDisplay];
	
	_saterouteView.hidden = NO;
	[_saterouteView setNeedsDisplay];
}


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
	// try to dequeue an existing pin view first
	if ([annotation isKindOfClass:[LocationAnnotation class]]) {
		static NSString* WaterAndRainAnnotationIdentifier = @"waterandrainAnnotationIdentifier";
		MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[_mapView dequeueReusableAnnotationViewWithIdentifier:WaterAndRainAnnotationIdentifier];
		if (pinView!=nil) {
			pinView=nil;
		}
		if (!pinView)
		{
			// if an existing pin view was not available, create one
			MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:WaterAndRainAnnotationIdentifier] autorelease];
			if ([lannotation.type isEqualToString:@"水情"]&&[lannotation.subtitleData floatValue]>0 ) {
				customPinView.pinColor = MKPinAnnotationColorRed;
			} else {
				customPinView.pinColor = MKPinAnnotationColorPurple;
			}

			customPinView.animatesDrop = YES;
			customPinView.canShowCallout = YES;

			UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			[rightButton addTarget:self
							action:nil
				  forControlEvents:UIControlEventTouchUpInside];
			customPinView.rightCalloutAccessoryView = rightButton;

			return customPinView;
		}
		else
		{
			pinView.annotation = annotation;
		}
		return pinView;
	} else if ([annotation isKindOfClass:[HisTypAnnotation class]]) {
		static NSString* HisTypAnnotationIdentifier = @"HisTypAnnotationIdentifier";
		MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[_mapView dequeueReusableAnnotationViewWithIdentifier:HisTypAnnotationIdentifier];
		if (!pinView)
		{
			// if an existing pin view was not available, create one
			MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:HisTypAnnotationIdentifier] autorelease];
			customPinView.pinColor = MKPinAnnotationColorGreen;
			customPinView.animatesDrop = YES;
			customPinView.canShowCallout = YES;

			UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			[rightButton addTarget:self
							action:nil
				  forControlEvents:UIControlEventTouchUpInside];
			customPinView.rightCalloutAccessoryView = rightButton;
			
			return customPinView;
		}
		else
		{
			pinView.annotation = annotation;
		}
		return pinView;
	}
	else if ([annotation isKindOfClass:[NowTypAnnotation class]]) {
		static NSString* NowTypTypAnnotationIdentifier = @"NowTypAnnotationIdentifier";
		MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[_mapView dequeueReusableAnnotationViewWithIdentifier:NowTypTypAnnotationIdentifier];
		if (!pinView)
		{
			// if an existing pin view was not available, create one
			MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:NowTypTypAnnotationIdentifier] autorelease];
			customPinView.pinColor = MKPinAnnotationColorRed;
			customPinView.animatesDrop = YES;
			customPinView.canShowCallout = YES;
			
			return customPinView;
		}
		else
		{
			pinView.annotation = annotation;
		}
		return pinView;
	}  else if ([annotation isKindOfClass:[SHisTypAnnotation class]]) {
		static NSString* SHisTypAnnotationIdentifier = @"SHisTypAnnotationIdentifier";
		MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[_mapView dequeueReusableAnnotationViewWithIdentifier:SHisTypAnnotationIdentifier];
		if (!pinView)
		{
			// if an existing pin view was not available, create one
			MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:SHisTypAnnotationIdentifier] autorelease];
			customPinView.pinColor = MKPinAnnotationColorGreen;
			customPinView.animatesDrop = YES;
			customPinView.canShowCallout = YES;
			
			UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			[rightButton addTarget:self
							action:nil
				  forControlEvents:UIControlEventTouchUpInside];
			customPinView.rightCalloutAccessoryView = rightButton;
			
			return customPinView;
		}
		else
		{
			pinView.annotation = annotation;
		}
		return pinView;
	}
		
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	if ([view.annotation isKindOfClass:[HisTypAnnotation class]]) 
	{	
		if(self.hisPinPopoverController !=nil){
			self.hisPinPopoverController = nil;
		}
		[self.mapView deselectAnnotation:histannotation animated:YES];
		self.popverTyphArray = historyTyphArray;
		TyphoonListPopovers* content = [[TyphoonListPopovers alloc] initWithNibName:@"TyphoonListPinPopover" bundle:nil withList:self.popverTyphArray withTYphoonInfo:nil withInfo:histannotation.TyphShowInfo];
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 
		aPopover.delegate = self;
		[content release];
		[aPopover setPopoverContentSize:CGSizeMake(266, 332)];
		// Store the popover in a custom property for later use. 
		self.hisPinPopoverController = aPopover; 
		[aPopover release];
		
		CGPoint annotationPoint = [_mapView convertCoordinate:view.annotation.coordinate toPointToView:_mapView];
		float boxDY=annotationPoint.y;
		float boxDX=annotationPoint.x;
		CGRect box = CGRectMake(boxDX-9,boxDY-37,17,17);
		
		[self.hisPinPopoverController presentPopoverFromRect: box inView: _mapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}  else if ([view.annotation isKindOfClass:[SHisTypAnnotation class]]) 
	{	
		if(self.sHisPinPopoverController !=nil){
			self.sHisPinPopoverController = nil;
		}
		[self.mapView deselectAnnotation:sHistannotation animated:YES];
		TyphoonListPopovers* content = [[TyphoonListPopovers alloc] initWithNibName:@"TyphoonListPinPopover" bundle:nil withList:self.popversTyphArray withTYphoonInfo:nil withInfo:sHistannotation.TyphShowInfo];
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 

		aPopover.delegate = self;
		[content release];
		[aPopover setPopoverContentSize:CGSizeMake(266, 332)];
		// Store the popover in a custom property for later use. 
		self.sHisPinPopoverController = aPopover; 
		[aPopover release];
		
		CGPoint annotationPoint = [_mapView convertCoordinate:view.annotation.coordinate toPointToView:_mapView];
		float boxDY=annotationPoint.y;
		float boxDX=annotationPoint.x;
		CGRect box = CGRectMake(boxDX-9,boxDY-37,17,17);
		
		[self.sHisPinPopoverController presentPopoverFromRect: box inView: _mapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views;
{
	[self performSelector:@selector(delayShowCallOutView) withObject:nil afterDelay:0.15];//onece 0.5
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        MKPolygonView* aView = [[[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay] autorelease];
		
		aView.fillColor = [UIColor colorWithRed:84.0/255 green:84.0/255  blue:84.0/255  alpha:0.2];
        aView.strokeColor = [UIColor colorWithRed:84.0/255  green:84.0/255  blue:84.0/255  alpha:0.2];
		aView.lineWidth = 3;
		
        return aView;
    } else if ([overlay isKindOfClass:[SatelliteOverlay class]]) {
		SatelliteOverlayView *view = [[SatelliteOverlayView alloc] initWithOverlay:overlay];
		return [view autorelease];
	}
	
    return nil;
}

-(void)delayShowCallOutView{
	if (lannotation!=nil) {
		[self.mapView selectAnnotation:lannotation animated:YES];
	}
	
	if (histannotation!=nil&&self.hisTyphoonKey==YES) {
		[self.mapView selectAnnotation:histannotation animated:YES];
	}
	
	//The following code is concealed from the project, for the annotation has taken off on june 6th
	/*
	if ([newTypAnnotationsArr count]>0&&self.actTyphoonKey==YES) {
		[self.mapView selectAnnotation:nowShowAnnotation animated:YES];
		//[self.mapView selectAnnotation:[newTypAnnotationsArr objectAtIndex:1] animated:YES];
	}
	 */
	
	if (sHistannotation!=nil&&self.sHisTyphoonKey==YES) {
		[self.mapView selectAnnotation:sHistannotation animated:YES];
	}
	
	[self initAnnotationShowKey];
}

-(void)removeRWPin{
	[self.mapView removeAnnotation:self.lannotation];
	[self.lListPopoverController dismissPopoverAnimated:NO];
	self.lListPopoverController = nil;
}

#pragma mark -
#pragma mark navag delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[SearchDogController class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(320, 412);
	}else if ([viewController isKindOfClass:[TyphoonSListPopovers class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(266, 412);
	}
}

#pragma mark -
#pragma mark Cascade
-(IBAction)showCascade:(id)sender{
	[self performSelector:@selector(handleGesture:)];
	[self disabledGestureView];
	self.cListPopoverController = nil;
	if (nil !=self.hisrouteView.superview||histannotation!=nil) {
		self.typhoonLayer = YES;
	} else {
		self.typhoonLayer = NO;
	}
	if (nil!=self.sHisrouteView.superview||nil!=self.sLannotation||itsSAnno == YES) {
		self.sTyphoonLayer=YES;
	} else {
		self.sTyphoonLayer = NO;
	}

	if (self.satelliteOverlay!=nil) {
		self.satelliteLayer = YES;
	} else {
		self.satelliteLayer = NO;
	}
	
    ControlDogCascade * content = [[ControlDogCascade alloc] initWithNibName:@"ControlDogCascade" bundle:nil typhoonInfo:self.typhoonLayer satelliteInfo:self.satelliteLayer searchInfo:self.sTyphoonLayer mapType:self.mapTypeInt];
	content.delegate = self;
	UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 
	aPopover.delegate = self;
	[content release];
    [aPopover setPopoverContentSize:CGSizeMake(260, 300)];
	
	// Store the popover in a custom property for later use. 
	self.cListPopoverController = aPopover; 
	[aPopover release];
	
	CGRect oldFrame = [(UIButton *)sender frame];;
	
	[self.cListPopoverController presentPopoverFromRect:oldFrame inView: self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}


-(void)dealWithDogCascade:(ControlDogCascade *)myView removeName:(NSString *)cascadeStr{
	if ([cascadeStr isEqualToString:@"台风"]) {
		[self removeTyphoon];
	} else if ([cascadeStr isEqualToString:@"云图"]) {
		[self removeSatellite];
	}else if ([cascadeStr isEqualToString:@"搜索"]) {
		[self removeSearch];
	} else if ([cascadeStr isEqualToString:@"全部"]) {
		[self removeAll];
	} else if ([cascadeStr isEqualToString:@"标准"]) {
		self.mapTypeInt = 0;
//		[popoverController dismissPopoverAnimated:YES];
		self.mapView.mapType = MKMapTypeStandard;
	} else if ([cascadeStr isEqualToString:@"卫星"]) {
		self.mapTypeInt = 1;
//		[popoverController dismissPopoverAnimated:YES];
		self.mapView.mapType = MKMapTypeSatellite;
	} else if ([cascadeStr isEqualToString:@"混合"]) {
		self.mapTypeInt =2;
//		[popoverController dismissPopoverAnimated:YES];
		self.mapView.mapType = MKMapTypeHybrid;
	}
}

-(void)removeTyphoon{
	self.typhoonLayer = NO;
	[self dismissHistoryTyphoon];
	if (nil==self.yListShowView.superview) {
		if (nil!=_hisrouteView.superview) {
			[self.hisPinPopoverController dismissPopoverAnimated:NO];
			[_hisrouteView removeFromSuperview];
			_hisrouteView = nil;
			[_hisrouteView release];
			oldTyphoonTag = 0;
		}
	} else {
		if (self.oldTyphoonTag>0) {
			OneTyphoonView *myTempView = (OneTyphoonView *)[self.view viewWithTag:oldTyphoonTag];
			if (myTempView.bottomSignal!=YES) {
				[myTempView performSelector:@selector(realJumpButtom:)];
			}
			myTempView = nil;

			if (nil!=_hisrouteView) {
				[_hisrouteView removeFromSuperview];
				_hisrouteView = nil;
				[_hisrouteView release];
			}
			self.oldTyphoonTag = 0;
				
		}
	}
	
	if (self.histannotation!=nil) {
		[self.mapView removeAnnotation:histannotation];
		self.histannotation = nil;
	}
}

-(void)removeSatellite{
	self.satelliteLayer = NO;
	if (nil!=self.satelliteOverlay) {
		[self.mapView removeOverlay:self.satelliteOverlay];
		self.satelliteOverlay = nil;
	}
	[self performSelectorOnMainThread:@selector(hideSatelliteTimeViewView:) withObject:nil waitUntilDone:YES];
}

-(void)removeSearch{
	self.sTyphoonLayer = NO;
	if (nil!=_sHisrouteView.superview) {
		[self.sHisPinPopoverController dismissPopoverAnimated:NO];

		[_sHisrouteView removeFromSuperview];
		[_sHisrouteView release];
		_sHisrouteView = nil;
	} 
	
	if (itsSAnno == YES) {
		itsSAnno = NO;
		if (self.lannotation!=nil) {
			[self.mapView removeAnnotation:lannotation];
			self.lannotation = nil;
		}	
	}

	if (self.sHistannotation!=nil) {
		[self.mapView removeAnnotation:sHistannotation];
		self.sHistannotation = nil;
	}	
}

-(void)removeAll{
	[self removeTyphoon];
	[self removeSatellite];
	[self removeSearch];
}

-(void)initAllAnnoKey{
	itsSAnno = NO;
}

#pragma mark WAITTINGVIEW
-(void)addWaitting{
	if (self.wattingView.superview ==nil) {
	[self.view addSubview:self.wattingView];
	}
	[self.view bringSubviewToFront:self.wattingView];
}

-(void)removeWaitting{
	if (self.wattingView.superview !=nil) {
		[self.wattingView removeFromSuperview];
	}
}

#pragma mark -
#pragma mark DealWithSearch
-(IBAction)showSearchPopver:(id)sender{
	[self dismissHistoryTyphoon];
	[self dismissRealTyphoon];
	[self performSelector:@selector(handleGesture:)];
	[self disabledGestureView];
	if (oldSearchSig !=9618) 
	{	
		oldSearchSig = 9618;
		self.sListPopoverController = nil;
		SearchDogController* content = [[SearchDogController alloc] initWithNibName:@"SearchDog" bundle:nil]; 
		CGSize mySize = CGSizeMake(320, 368);
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:content];
		navController.delegate = self;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:navController]; 
		//aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
		[content release];
		[aPopover setPopoverContentSize:mySize];
		// Store the popover in a custom property for later use. 
		self.sListPopoverController = aPopover; 
		[aPopover release];
	}

	[self.sListPopoverController presentPopoverFromRect:[(UIButton *)[self.view viewWithTag:8888] bounds] inView:(UIButton *)[self.view viewWithTag:8888] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)receviceSearchTyphoonArrayAndDrawIt:(NSMutableArray *)myArray WithName:(NSString *)tfnm WithID:(NSString *)tyid{
	[self.sHisPinPopoverController dismissPopoverAnimated:NO];
	if (nil!=_sHisrouteView) {
		[_sHisrouteView removeFromSuperview];
		[_sHisrouteView release];
		_sHisrouteView = nil;
	}
	
	if (sHistannotation!=nil) {
		[self.mapView removeAnnotation:sHistannotation];
		[sHistannotation release];
		sHistannotation = nil;
	}
	
	//define two key 
	BOOL isEqualToActivityOne = NO;
	BOOL isHadDrawedOne = NO;
	//judge if the typhoon which is the activity typhoon
	for (int i = 0; i<[self.newTyphoonArray count]; i++) {
		TFList *temList = [self.newTyphoonArray objectAtIndex:i];
		if([temList.tfID isEqualToString:tyid]){
			isEqualToActivityOne = YES;
			break;
		}
	}
	//judge if the typhoon which will be drawed had been drawed or is the activity typhoon
	if (isEqualToActivityOne==NO&&[tyid isEqualToString:[NSString stringWithFormat:@"%d",oldTyphoonTag]]) {
		isHadDrawedOne = YES;
	}
	if (isEqualToActivityOne == NO&&isHadDrawedOne == NO) {
		if (popversTyphArray!=nil&&popversTyphArray!=myArray) {
			[myArray retain];
			self.popversTyphArray = myArray;
		}
		_sHisrouteView = [[CSHisMapRouteLayerView alloc] initWithRoute:popversTyphArray mapView:_mapView];
		
		NSInteger counta = [myArray count];
		if (counta > 0) {
			TFPathInfo *info = [myArray objectAtIndex:(counta-1)];
			CLLocationCoordinate2D coordinate;
			coordinate.latitude = [info.WD floatValue];
			coordinate.longitude =[info.JD floatValue];
			sHistannotation = [[SHisTypAnnotation alloc] initWithCoordinate:coordinate];
			self.sHisTyphoonKey= YES;
			sHistannotation.TyphShowInfo = [NSString stringWithFormat:@"%@(%@)",tfnm,tyid];
		}
		
		[self.mapView addAnnotation:sHistannotation];
	}else if (isEqualToActivityOne == NO&&isHadDrawedOne == YES) {
		//show alertview that the typhoon has been drawed
//		NSLog(@"show alertview that the typhoon has been drawed");
		[self showAlertViewHasDrawed:tfnm];
	}else if(isEqualToActivityOne == YES&&isHadDrawedOne == NO) {
		//show alertview that the typhoon is the one activity typhoon
//		NSLog(@"show alertview that the typhoon is the one activity typhoon");
		[self showAlertViewIsActivity:tfnm];
	}

}

-(void)showAlertViewIsActivity:(NSString *)temStr{
//	//Set Region
//	MKCoordinateRegion region;
//	region.center.longitude =[[jwArray objectAtIndex:0] floatValue]*1.0004;
//	region.center.latitude  = [[jwArray objectAtIndex:1] floatValue];
//	MKCoordinateSpan span = {0.060024,0.102545};
//	region.span = span;
//    [ self.mapView setRegion:region animated:YES];
	NSString *temAlertTitle = [NSString stringWithFormat:@"\"%@\"为当前活动台风，地图上已存在。请您查看地图。",temStr];
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle:temAlertTitle
						  message:nil 
						  delegate:self 
						  cancelButtonTitle:@"确定" 
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)showAlertViewHasDrawed:(NSString *)temStr{
	NSString *temAlertTitle = [NSString stringWithFormat:@"历史台风\"%@\"，地图上已存在。请您查看地图。",temStr];
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle:temAlertTitle 
						  message:nil 
						  delegate:self 
						  cancelButtonTitle:@"确定" 
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)delaySAddAnnotionToAnimate{
	[self.mapView addAnnotation:sLannotation];
}

-(void)setSLocationLon:(NSString *)lon LocationLat:(NSString *)lat PointName:(NSString*)nm PointData:(NSString *)dt PointType:(NSString*)ty{
	NSString *clon = [NSString stringWithFormat:@"%@",lon];
	NSString *clat = [NSString stringWithFormat:@"%@",lat];
	NSString *cnm = [NSString stringWithFormat:@"%@",nm];
	NSString *cdt = [NSString stringWithFormat:@"%@",dt];
	NSString *cty = [NSString stringWithFormat:@"%@",ty];

	MKCoordinateRegion current =  self.mapView.region;
	NSArray *temArray = [NSArray arrayWithObjects:clon,clat,cnm,cdt,cty,nil];
    if (current.span.latitudeDelta < 9.6)
    {
        [self performSelector:@selector(sAnimateToWorld:) withObject:temArray afterDelay:0.2];
        [self performSelector:@selector(sAnimateToPlace:) withObject:temArray afterDelay:0.3];        
    }
    else
    {
        [self performSelector:@selector(sAnimateToPlace:) withObject:temArray afterDelay:0.2];        
    }
}

-(void)initAnnotationShowKey{
	self.hisTyphoonKey = NO;
	self.actTyphoonKey =NO;
	self.sHisTyphoonKey =NO;
}


-(void)dismissRealTyphoon{
	[self.popoverController dismissPopoverAnimated:NO];
}
-(void)dismissHistoryTyphoon{
	[self.hisPinPopoverController dismissPopoverAnimated:NO];
	[self.sHisPinPopoverController dismissPopoverAnimated:NO];
}
-(void)dismissSearch{
	[self.sListPopoverController dismissPopoverAnimated:NO];
}
//dismiss locationChoosePopover
-(void)dismissLocation{
	[self.lListPopoverController dismissPopoverAnimated:NO];
}
//dismiss water,rain,project,histyphoon Annotation's popover
-(void)dismissRWP6{
	[self.hisPinPopoverController  dismissPopoverAnimated:NO];
}
@end
