//
//  smellycatViewController.m
//  smellycat
//
//  Created by apple on 10-10-30.
//  Copyright zjdayu 2010. All rights reserved.
//

#import "smellycatViewController.h"
#import "WebServices.h"
#import "typhoonXMLParser.h"
#import "rainXMLParser.h"
#import "const.h"
#import "OneTyphoonView.h"
#import "CustomHornButton.h"
#import "CSMapRouteLayerView.h"
#import "CSHisMapRouteLayerView.h"
#import "OneRainView.h"
#import "TyphoonListPopovers.h"
#import "Rain1Controller.h"
#import "SpeakSearchViewController.h"
#import "RainSDInfoController.h"
#import "CSSatlliteRouterLayer.h"
#import "SatelliteOverlay.h"
#import "SatelliteOverlayView.h"
#import "SatelliteXMLParser.h"
#import "CSZJRouterLayer.h"
#import "WaterXMLParser.h"
#import "OneWaterView.h"
#import "Water1Controller.h"
#import "LocationAnnotation.h"
#import "HisTypAnnotation.h"
#import "NowTypAnnotation.h"
#import "SHisTypAnnotation.h"
#import "SLocationAnnotation.h"
#import "TyphoonSListPopovers.h"
#import "TyphoonNewRealPopover.h"
#import "Rain2Controller.h"
#import "RainTableController.h"
#import "WaterInfoController.h"
#import "FlowLeftViewController.h"
#import "ControlCascade.h"
#import "LocationController.h"
#import "OneProjectView.h"
#import "FileManager.h"
#import "Work1Controller.h"
#import "Work2Controller.h"
#import "Work3Controller.h"
//2013年1月
#import "AroundResultParser.h"
#import "GPLNAnnotation.h"
#import "Around1Controller.h"


static smellycatViewController *me = nil;
@implementation smellycatViewController
@synthesize loginView,barTyphoonBtn,barRainBtn,barProjectBtn,barWaterBtn,barCloudBtn,barAroundBtn,refreshButton,hornButton,barSearchBtn,barTrashBtn,yearNameButton,rainNameButton,yListShowView,hideTImgView,hideTBtn,outTFrameImgView,myYListLeftSig,myYListRightSig,myTyphScroll,rainPacHourView,outFrameImgView,hideImgView,hideBtn,waterPacTypeView,waterNameButton,outWFrameImgView,hideWImgView,hideWBtn;
@synthesize mapView   = _mapView;
@synthesize routeView = _routeView;
@synthesize hisrouteView = _hisrouteView;
@synthesize sHisrouteView = _sHisrouteView;
@synthesize RainrouteView= _RainrouteView;
@synthesize saterouteView =_saterouteView,satelliteOverlay;
@synthesize WaterrouteView=_WaterrouteView;
@synthesize zjBackgoundView=_zjBackgoundView;
@synthesize philippinesOceanLayer = _philippinesOceanLayer;
@synthesize zjPoly = _zjPoly;
@synthesize zjPolyLayer;
@synthesize web,gestureView;
@synthesize oneYearTyphList,calibrateYear,yearListTable,yearListArray,minusType,rainPointArray,rainArrBig6,rainArrBig5,rainArrBig4,rainArrBig3,rainArrBig2,rainArrBig1,waterPointArray,rainListTable,rainListArray,waterListTable,myYLTableBottomVew,myRainTableBottomVew,myWaterTableBottomView,waterListArray,waterArrRiv,waterArrRev,waterArrGat,waterArrTid,newTyphoonArray,oldTyphoonTag,popoverController,popverTyphArray,popversTyphArray,satelliteTimeView,satelliteNameBtn;
@synthesize cloudDic,historyTyphArray,tyGroupHisArray,tyHisArray,tyGroupForeChinaArray,tyForeChinaArray,tyGroupForeHongKongArray,tyForeHongKongArray,tyGroupForeTaiWanArray,tyForeTaiWanArray,tyGroupForeAmericaArray,tyForeAmericaArray,tyGroupForeJapanArray,tyForeJapanArray,lannotation,histannotation,nowShowAnnotation,newTypAnnotationsArr,sLannotation,sHistannotation;
@synthesize multiLayer,typhoonLayer,sTyphoonLayer,rainLayer,waterLayer,projectLayer,satelliteLayer,aroundLayer,searchLayer,itsRAnno,itsWAnno,itsPAnno,itsSAnno,mapTypeInt;
@synthesize rainAndWaterAnKey,hisTyphoonKey,actTyphoonKey,sRainAndWaterAnKey,sHisTyphoonKey;
@synthesize wattingView,typhoonScrl,projectGroupArray;
@synthesize projectPacTypeView,projectNameButton,outPFrameImgView,hidePImgView,hidePBtn;
@synthesize aroundPacTypeView,aroundNameButton,outAFrameImgView,hideAImgView,hideABtn;
@synthesize rListPopoverController,wListPopoverController,lListPopoverController,pListPopoverController,sListPopoverController,cListPopoverController,hisPinPopoverController,sHisPinPopoverController,rwp6PinPopoverController,oldrwp6Sig,oldSearchSig;
@synthesize isVirginCheckTy;
@synthesize myTotalRStr,myTotalWStr,myTotalCStr;
@synthesize twentyFourHourRainfallIdentitor = _twentyFourHourRainfallIdentitor;
//2013年1月30日修改
@synthesize aroundSZArray, aroundDFArray, aroundBZArray, aroundHTArray, aroundDZArray, aroundSKArray, aroundListPopoverController, aroundPinPopoverController;
@synthesize coord = _coord;
@synthesize locationManager = _locationManager;
@synthesize selectedRadius = _selectedRadius;
@synthesize sectionObjets = _sectionObjets;
@synthesize typeArray = _typeArray;
@synthesize radiusListTable;
@synthesize myAroundTableBottomView;
@synthesize noNeedMove,isNewVersion,updateBtn,updateView,updateWebView;
#pragma mark -
#pragma mark SYSTEM_METHO
- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.oneYearTyphList = [[NSMutableArray alloc] init];
	self.yearListArray = [[NSMutableArray alloc] init];
	//self.rainListArray = [[NSMutableArray alloc] init];
	self.rainPointArray =[[NSMutableArray alloc] init];
	self.rainArrBig6 =[[NSMutableArray alloc] init];
	self.rainArrBig5 =[[NSMutableArray alloc] init];
	self.rainArrBig4 =[[NSMutableArray alloc] init];
	self.rainArrBig3 =[[NSMutableArray alloc] init];
	self.rainArrBig2 =[[NSMutableArray alloc] init];
	self.rainArrBig1 =[[NSMutableArray alloc] init];
	//self.waterListArray = [[NSMutableArray alloc] init];
	self.waterArrRiv =[[NSMutableArray alloc] init];
	self.waterArrRev =[[NSMutableArray alloc] init];
	self.waterArrGat =[[NSMutableArray alloc] init];
	self.waterArrTid =[[NSMutableArray alloc] init];
	self.waterPointArray = [[NSMutableArray alloc] init];
	self.newTyphoonArray = [[NSMutableArray alloc] init];
	tyGroupHisArray=[[NSMutableArray alloc] init];
	//tyHisArray=[[NSMutableArray alloc] init];
    projectGroupArray = [[NSMutableArray alloc] init];
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
    //2013年1月30日修改
    self.aroundSZArray =[[NSMutableArray alloc] init];
    self.aroundDFArray =[[NSMutableArray alloc] init];
    self.aroundBZArray =[[NSMutableArray alloc] init];
    self.aroundHTArray =[[NSMutableArray alloc] init];
    self.aroundDZArray =[[NSMutableArray alloc] init];
    self.aroundSKArray =[[NSMutableArray alloc] init];
    self.sectionObjets =[[NSMutableArray alloc] init];
    _typeArray = [[NSArray alloc] initWithObjects:@"全部$K,J,T,E,D,B",@"水库$B",@"水闸$K",@"泵站$J",@"海塘$E",@"堤防$D",@"电站$T", nil];
    //查找周边，初始加载默认5公里
    _selectedRadius = [[NSMutableString alloc] initWithString:RADIUS_B];
    radiusArray = [[NSArray alloc] initWithObjects:RADIUS_C,RADIUS_B,RADIUS_A, nil];
	
	//cloudDic =[[NSDictionary alloc] init];
	newTypAnnotationsArr=[[NSMutableArray alloc] init];
    //2012年7月修改
    _zjPoly = [[MKPolygon alloc] init];
    _philippinesOceanLayer = [[MKPolygon alloc] init];
    //2013年10月修改
    noNeedMove = NO;
	
	//init multiEnable control
	multiLayer = YES;
	typhoonLayer = NO;
	sTyphoonLayer = NO;
	rainLayer = NO;
	zjPolyLayer = NO;
	waterLayer = NO;
	projectLayer = NO;
	satelliteLayer = NO;
    aroundLayer = NO;
	mapTypeInt = 0;
    
    //更新检测
    if ([self checkIsNewVersion] == YES) {
        updateBtn.hidden = NO;
    } else {
        updateBtn.hidden = YES;
    }

	_zjBackgoundView.hidden = YES;
	[self initAnnotationShowKey];
	[self initAllAnnoKey];
	
	me = self;
	isVirginCheckTy = YES;
	oldTyphoonTag = 0;
	oldrwp6Sig = 0;
    
    [self initiallizeLatestTyphoonInfo];
    
	[self defaultMapRegion];
	[self addWaitting];
	[self initNowYear];
	[self initPacAndHours];
	[self initWaterStaus];
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
	barRainBtn = nil;
	barWaterBtn = nil;
	barProjectBtn = nil;
	barCloudBtn = nil;
    barAroundBtn = nil;
	barSearchBtn = nil;
	barTrashBtn = nil;
	yearNameButton = nil;
	rainNameButton = nil;
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
	self.rainPacHourView = nil;
	self.outFrameImgView = nil;
	self.hideImgView = nil;
	self.hideBtn = nil;
	self.waterPacTypeView = nil;
	self.waterNameButton = nil;
	self.outWFrameImgView = nil;
	self.hideWImgView = nil;
	self.hideWBtn = nil;
	self.satelliteTimeView = nil;
	self.satelliteNameBtn = nil;
	self.wattingView = nil;
	self.typhoonScrl = nil;
	self.projectPacTypeView = nil;
	self.projectNameButton = nil;
	self.outPFrameImgView = nil;
	self.hidePImgView = nil;
	self.hidePBtn = nil;
    
    self.aroundPacTypeView = nil;
	self.aroundNameButton = nil;
	self.outAFrameImgView = nil;
	self.hideAImgView = nil;
	self.hideABtn = nil;
    self.radiusListTable = nil;
}

- (void)dealloc {
	//IBOutlet
	[typhoonScrl release];
	[loginView release];
	[barTyphoonBtn release];
	[barRainBtn release];
	[barWaterBtn release];
	[barProjectBtn release];
	[barCloudBtn release];
    [barAroundBtn release];
	[barSearchBtn release];
	[barTrashBtn release];
	[yearNameButton release];
	[rainNameButton release];
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
	[rainPacHourView release];
	[outFrameImgView  release];
	[hideImgView  release];
	[hideBtn  release];
	[waterPacTypeView release];
	[waterNameButton release];
	[outWFrameImgView release];
	[hideWImgView release];
	[hideWBtn release];
	[satelliteTimeView release];
	[satelliteNameBtn release];
	[wattingView release];
	[projectPacTypeView release];
	[projectNameButton release];
	[outPFrameImgView release];
	[hidePImgView release];
	[hidePBtn release];
    
    [aroundPacTypeView release];
	[aroundNameButton release];
	[outAFrameImgView release];
	[hideAImgView release];
	[hideABtn release];

	
	//Others
	[gestureView release];
	[oneYearTyphList release];
    [myTotalRStr release];
    [_twentyFourHourRainfallIdentitor release];
    [myTotalWStr release];
    [myTotalCStr release];
	[yearListTable release];
	[myYLTableBottomVew release];
	[yearListArray release];
	[rainListTable release];
	[myRainTableBottomVew release];
	[rainListArray release];
	[rainPointArray release];
	[rainArrBig6 release];
	[rainArrBig5 release];
	[rainArrBig4 release];
	[rainArrBig3 release];
	[rainArrBig2 release];
	[rainArrBig1 release];
	[waterListTable release];
	[waterArrRiv release];
	[waterArrRev release];
	[waterArrGat release];
	[waterArrTid release];
	[waterPointArray release];
	[myWaterTableBottomView release];
	[waterListArray release];
	[newTyphoonArray release];
	[_RainrouteView release];
	[_hisrouteView release];
	[_sHisrouteView release];
	[_routeView release];
	[_saterouteView release];
	[satelliteOverlay release];
	[_WaterrouteView release];
	[_zjBackgoundView release];
	[_zjPoly release];
    [_philippinesOceanLayer release];
	[web release];
    [projectGroupArray release];
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
	[rListPopoverController release];
	[wListPopoverController  release];
	[lListPopoverController release];
	[pListPopoverController release]; 
	[sListPopoverController release]; 
	[cListPopoverController release];
	[hisPinPopoverController release];
	[sHisPinPopoverController release];
	[rwp6PinPopoverController release];
	[popverTyphArray release];
	[popversTyphArray release];
	[lannotation release];
	[histannotation release];
	[nowShowAnnotation release];
	[sLannotation release];
	[sHistannotation release];
	[cloudDic release];
    
    //2013年1月30日修改
	[aroundSZArray release];
	[aroundDFArray release];
	[aroundBZArray release];
	[aroundHTArray release];
	[aroundDZArray release];
	[aroundSKArray release];
	[aroundListPopoverController release];
	[aroundPinPopoverController release];
    [_locationManager release];
    [_selectedRadius release];
    [_sectionObjets release];
    [_typeArray release];
    [radiusListTable release];
    [radiusArray release];
    [updateBtn release];
    [updateView release];
    [updateWebView release];
    [super dealloc];
}

+(id)sharedCat{
	return me;
}

-(IBAction)updateViewContrller:(id)sender;
{
    [self dismissRealTyphoon];
    [self dismissHistoryTyphoon];
    [self dismissRain];
    [self dismissWater];
    [self dismissProject];
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
	if (rainListTable.hidden ==NO && rainListTable!=nil) {
		rainListTable.hidden = YES;
		[rainListTable release];rainListTable= nil;
		myRainTableBottomVew.hidden = YES;
		[myRainTableBottomVew release];myRainTableBottomVew=nil;
	}
	if (waterListTable.hidden ==NO && waterListTable!=nil) {
		waterListTable.hidden = YES;
		[waterListTable release];waterListTable= nil;
		myWaterTableBottomView.hidden = YES;
		[myWaterTableBottomView release];myWaterTableBottomView=nil;
	}
    if (radiusListTable.hidden ==NO && radiusListTable!=nil) {
		radiusListTable.hidden = YES;
		[radiusListTable release];radiusListTable= nil;
		myAroundTableBottomView.hidden = YES;
		[myRainTableBottomVew release];myRainTableBottomVew=nil;
	}
	[self disabledGestureView];
}

#pragma mark -
#pragma mark ZJLAYER
-(void)drawZJBackground{
	if (nil==_zjBackgoundView.superview) {
		_zjBackgoundView =[[CSZJRouterLayer alloc] initWithZJRoute:_mapView];
	}
}

-(void)drawZJPolygon{
	if (self.zjPolyLayer==NO) {
		NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"ZJ" ofType:@"txt"];
		NSString *edgeInfo = [NSString stringWithContentsOfFile:pathStr encoding:kCFStringEncodingUTF8 error:nil];
		NSArray *tudeArray = [edgeInfo componentsSeparatedByString:@"|"];
		
		NSInteger edgeGroupNUM = [tudeArray count]/2;
		CLLocationCoordinate2D  points[edgeGroupNUM];
		
		for (int i= 0; i<edgeGroupNUM; i++) {
			float lon = [[tudeArray objectAtIndex:2*i] floatValue];
			float lat = [[tudeArray objectAtIndex:2*i+1] floatValue];
			points[i] = CLLocationCoordinate2DMake(lat, lon);
		}
		
        //why need _ property
		MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:edgeGroupNUM];
        poly.title = @"浙江";
		self.zjPoly = poly;
		
		if (self.satelliteOverlay == nil) {
			[self.mapView addOverlay:self.zjPoly];
		} else {
			[self.mapView insertOverlay:self.zjPoly belowOverlay:self.satelliteOverlay];
		}
		self.zjPolyLayer =YES;
	}
}

-(void)drawPhilippinesOceanLayer;
{
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"PHILIP" ofType:@"txt"];
    NSString *edgeInfo = [NSString stringWithContentsOfFile:pathStr encoding:kCFStringEncodingUTF8 error:nil];
    NSArray *tudeArray = [edgeInfo componentsSeparatedByString:@"|"];
    
    NSInteger edgeGroupNUM = [tudeArray count]/2;
    CLLocationCoordinate2D  points[edgeGroupNUM];
    
    for (int i= 0; i<edgeGroupNUM; i++) {
        float lon = [[tudeArray objectAtIndex:2*i] floatValue];
        float lat = [[tudeArray objectAtIndex:2*i+1] floatValue];
        points[i] = CLLocationCoordinate2DMake(lat, lon);
    }
    
    MKPolygon* poly =[MKPolygon polygonWithCoordinates:points count:edgeGroupNUM];
    poly.title = @"菲律宾";
    self.philippinesOceanLayer = poly;
    //2012年7月2日
    [self.mapView insertOverlay:self.philippinesOceanLayer atIndex:0];
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
        return nil;// can not find the "latestTyphoon.plist"
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
        return YES;//forecast data is 6 hours earlier than history data,return YES;
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
	//parse XML
	typhoonListXMLParser *paser=[[typhoonListXMLParser alloc] init];
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
    noNeedMove = NO;
	[self disabledGestureView];
	[self dismissRWP6];
	[self dismissHistoryTyphoon];
    [self dismissAroundPin];
	
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
		//获取当前台风的历史路径和当前台风的预测路径
        [self typhoonHisPath];
		[self typhoonForePath];

		_routeView = [[CSMapRouteLayerView alloc] initWithRoute:tyGroupHisArray forNewTyphoonArray:newTyphoonArray foreChina:tyGroupForeChinaArray foreHongKong:tyGroupForeHongKongArray foreTaiWan:tyGroupForeTaiWanArray foreAmerica:tyGroupForeAmericaArray foreJapan:tyGroupForeJapanArray mapView:_mapView withNoNeedMove:noNeedMove];
		
	}else {
		[self westPacificMapRegion];
	}
	
	//Even if the yListShowView has existed , we'll also refresh the yListShowview
	[self addWaitting];
	[self performSelector:@selector(prepareShowTyphoonListView) withObject:nil afterDelay:0.001];
	
	[self addWebScroll];
	
	// Add the annotation of the activie typhoon
	//[self.mapView addAnnotations:self.newTypAnnotationsArr];
	[self removeWaitting];
}

-(void)prepareShowTyphoonListView{
	[self.barTyphoonBtn setImage:[UIImage imageNamed:@"typhoon_select.png"] forState:UIControlStateNormal];
	[self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideSatelliteTimeViewView:) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];
	if (yListShowView.superview!=nil) {
		[self removeTyphoonListView];
	}
	
	//new create or update yListShowView
	self.yListShowView.backgroundColor = [UIColor clearColor];
	[self.yListShowView setFrame:CGRectMake(0, 58, 388, 65)];
	[self.view addSubview:self.yListShowView];
    //2013年11月18日修改 无台风，滚动条隐藏
    if ([newTyphoonArray count]>0) {
        self.typhoonScrl.hidden = NO;
    } else {
        self.typhoonScrl.hidden = YES;
    }
			
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
	[self dismissRealTyphoon];
	[self dismissRWP6];
    [self dismissAroundPin];
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
	typhoonNewXMLParser *paser=[[typhoonNewXMLParser alloc] init];
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
    TFList *list0 = [[TFList alloc] init];
	list0.tfID = @"201111";
	list0.cNAME = @"南玛都";
	list0.NAME = @"MeiHua";
	[newTyphoonArray addObject:list0];
	[list0 release];
    
	TFList *list1 = [[TFList alloc] init];
	list1.tfID = @"200908";
	list1.cNAME = @"苗柏";
	list1.NAME = @"ManBai";
	[newTyphoonArray addObject:list1];
	[list1 release];
	
    TFList *list2 = [[TFList alloc] init];
	list2.tfID = @"200414";
	list2.cNAME = @"梅花";
	list2.NAME = @"AREA";
	[newTyphoonArray addObject:list2];
	[list2 release];
	
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
                				
                //component the scroll string
				NSString *iTestSmall = [NSString stringWithFormat:@"<font color=\"#FFFFFF\">%@(%@号)</font> 时间:<font color=\"#FFFFFF\">%@</font> 北纬:<font color=\"#FFFFFF\">%@</font> 东经:<font color=\"#FFFFFF\">%@</font> 中心气压:<font color=\"#FFFFFF\">%@百帕</font> 最大风速:<font color=\"#FFFFFF\">%@米/秒</font> 风力:<font color=\"#FFFFFF\">%@级</font> 移动速度:<font color=\"#FFFFFF\">%@公里/时</font> 移动方向:<font color=\"#FFFFFF\">%@</font> 7级风圈半径:<font color=\"#FFFFFF\">%@公里</font> 10级风圈半径:<font color=\"#FFFFFF\">%@公里</font>",nameStr,tfIDStr,RQSJ2Str,WDStr,JDStr,QYStr,FSStr,FLStr,movesdStr,movefxStr,radius7Str,radius10Str];
				if (i<([newTyphoonArray count]-1)) {
					iTest = [iTest stringByAppendingFormat:@"%@,",iTestSmall];
				} else {
					iTest =[iTest stringByAppendingFormat:@"%@。",iTestSmall];
				}
			} else {
				TFList *nowTyphoonList = [self.newTyphoonArray objectAtIndex:i];
				if (i<([newTyphoonArray count]-1)) {
					iTest = [iTest stringByAppendingFormat:@" <font color=\"#FFFFFF\">%@(%@号)</font>尚未有路径数据,",nowTyphoonList.cNAME,nowTyphoonList.tfID];
				} else {
					iTest =[iTest stringByAppendingFormat:@" <font color=\"#FFFFFF\">%@(%@号)</font>尚未有路径数据。",nowTyphoonList.cNAME,nowTyphoonList.tfID];
				}
			}
		}
		
		//add the scrollView at the bottom of my screen
		web=[[UIWebView alloc] initWithFrame:CGRectMake(58, 5, 387, 26)];
		[web setOpaque:NO];
		[web loadHTMLString:[NSString stringWithFormat:@"<html><head><style>body{background-color:transparent;front-size:10px;font-weight:bold}</style></head><body><marquee scrollamount=2.5><font color=\"#FFFFFF\">%@</font></marquee></body></html>", iTest] baseURL:nil];
		[web setUserInteractionEnabled:NO];
		[web setBackgroundColor:[UIColor clearColor]];
		
		[self.typhoonScrl addSubview:web];
		[self.typhoonScrl setFrame:CGRectMake(258, 684, 507, 44)];
		if (self.typhoonScrl.superview == nil) {
			[self.view addSubview:self.typhoonScrl];
		}
		
		//if there is new typhoon, the horn will animate to represent that now there is at least one activive typhoon.
		[self ifThereIsActiveTyphoonHorn:YES];

		self.typhoonScrl.hidden = NO;
		[web release];
	} else {
        //the following line is for the version of 1.7.01 after Nov 18th,2013
		//the following line is for the version of 1.2.6 before June 6th
        /*
		web=[[UIWebView alloc] initWithFrame:CGRectMake(58, 5, 387, 26)];
		[web setOpaque:NO];
		iTest = @"当前西太平洋上无台风";
		[web loadHTMLString:[NSString stringWithFormat:@"<html><head><style>body{background-color:transparent;front-size:10px;font-weight:bold}</style></head><body><marquee scrollamount=4><font color=\"#FFFFFF\">%@</font></marquee></body></html>", iTest] baseURL:nil];
		[web setUserInteractionEnabled:NO];
		[web setBackgroundColor:[UIColor clearColor]];
		[self.typhoonScrl addSubview:web];
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
         */
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
		UIImageView *myImgV = [[UIImageView alloc] initWithFrame:CGRectMake(23, 12, 18, 18)];
		myImgV.tag = 5678;
		myImgV.image = [UIImage imageNamed:@"horn1.png"];
		[self.typhoonScrl addSubview:myImgV];
		[myImgV release];
	}
}



#pragma mark -
#pragma mark rainPacHourInfo
//inspect if there is rainfall during the past 24 hours,or not;
-(void)inspectTwentyFourHourRainFall{
	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mRain"]];
	[config release];
    
    NSURL *contentURL = [WebServices getNRestUrl:baseURL Function:@"RainfallChecked" Parameter:[NSString stringWithString:@""]];
    RainTwentyFourHourXMLParser *parser = [[RainTwentyFourHourXMLParser alloc] init];
    [parser parseXMLFileAtURL:contentURL parseError:nil];
    [parser release];
}

-(void)get24HourRainfallIdentifier:(NSString *)temStr{
    self.twentyFourHourRainfallIdentitor = temStr;
}

-(IBAction)showRainListView:(id)sender{
    noNeedMove = NO;
	[self disabledGestureView];
	[self.sListPopoverController dismissPopoverAnimated:NO];
	[self dismissRWP6];
    [self dismissAroundPin];
	[self dismissHistoryTyphoon];
	if (self.rainPacHourView.superview==nil) {
		[self addWaitting];
	}
	[self performSelector:@selector(prepareShowRainListView) withObject:nil afterDelay:0.001];
}

-(void)prepareShowRainListView{
	[self.barRainBtn setImage:[UIImage imageNamed:@"rain_select.png"] forState:UIControlStateNormal];
	[self performSelectorOnMainThread:@selector(hideTyphoonListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideSatelliteTimeViewView:) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];
	if (rainPacHourView.superview==nil) {
		[self.rainPacHourView setFrame:CGRectMake(0, 58, 473, 65)];
		[self.view addSubview:self.rainPacHourView];
		[self.rainNameButton setTitle: @"24小时"forState:UIControlStateNormal];
		NSString *temTime = self.rainNameButton.titleLabel.text;
		[self dealWithRainMap:temTime];
		[self produceRainPHListView];
	}
}

-(void)produceRainPHListView{
	[[self.view viewWithTag:118] removeFromSuperview];
	[[self.view viewWithTag:117] removeFromSuperview];
	[[self.view viewWithTag:116] removeFromSuperview];
	[[self.view viewWithTag:115] removeFromSuperview];
	[[self.view viewWithTag:114] removeFromSuperview];
	[[self.view viewWithTag:113] removeFromSuperview];
	rainPacHourView.frame = CGRectMake(0, 58, 473, 65);
	outFrameImgView.frame = CGRectMake(0, 0, 444, 65);
	hideImgView.frame = CGRectMake(443, 0, 30, 65);
	hideBtn.frame = CGRectMake(443, -0.5, 30, 65);

	//从特大暴雨到最小的雨
	int count0 = 0;
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	int count5 = 0;
	UIImage *img6 = [UIImage imageNamed:@"rain6.png"];
	CGSize  oldFrame6 = img6.size;
	NSString *temStr6 = [NSString stringWithFormat:@"%d",self.rainArrBig6.count];
	count5 = [temStr6 length];
	OneRainView *myView6 = [[OneRainView alloc] initWithFrame:CGRectMake(101, 11, oldFrame6.width, oldFrame6.height) WithImage:img6 convertData:temStr6];
	myView6.tag = 118;
	myView6.delegate = self;
	[self.rainPacHourView addSubview:myView6];
	[myView6 release];
	
	UIImage *img5 = [UIImage imageNamed:@"rain5.png"];
	CGSize  oldFrame5 = img5.size;
	NSString *temStr5 = [NSString stringWithFormat:@"%d",self.rainArrBig5.count];
	count4 = [temStr5 length];
	OneRainView *myView5 = [[OneRainView alloc] initWithFrame:CGRectMake(155+count5*3, 11, oldFrame5.width, oldFrame5.height) WithImage:img5 convertData:temStr5];
	myView5.tag = 117;
	myView5.delegate = self;
	[self.rainPacHourView addSubview:myView5];
	[myView5 release];
	
	UIImage *img4 = [UIImage imageNamed:@"rain4.png"];
	CGSize  oldFrame4 = img4.size;
	NSString *temStr4 = [NSString stringWithFormat:@"%d",self.rainArrBig4.count];
	count3 = [temStr4 length];
	OneRainView *myView4 = [[OneRainView alloc] initWithFrame:CGRectMake(220+count4*3+count5*3, 11, oldFrame4.width, oldFrame4.height) WithImage:img4 convertData:temStr4];
	myView4.tag = 116;
	myView4.delegate = self;
	[self.rainPacHourView addSubview:myView4];
	[myView4 release];
	
	UIImage *img3 = [UIImage imageNamed:@"rain3.png"];
	CGSize  oldFrame3 = img3.size;
	NSString *temStr3 = [NSString stringWithFormat:@"%d",self.rainArrBig3.count];
	count2 = [temStr3 length];
	OneRainView *myView3 = [[OneRainView alloc] initWithFrame:CGRectMake(279+count3*3+count4*3+count5*3, 11, oldFrame3.width, oldFrame3.height) WithImage:img3 convertData:temStr3];
	myView3.tag = 115;
	myView3.delegate = self;
	[self.rainPacHourView addSubview:myView3];
	[myView3 release];
	
	UIImage *img2 = [UIImage imageNamed:@"rain2.png"];
	CGSize  oldFrame2 = img2.size;
	NSString *temStr2 = [NSString stringWithFormat:@"%d",self.rainArrBig2.count];
	count1 = [temStr2 length];
	OneRainView *myView2 = [[OneRainView alloc] initWithFrame:CGRectMake(333+count2*3+count3*3+count4*3+count5*3, 11, oldFrame2.width, oldFrame2.height) WithImage:img2 convertData:temStr2];
	myView2.tag = 114;
	myView2.delegate = self;
	[self.rainPacHourView addSubview:myView2];
	[myView2 release];
	
	UIImage *img1 = [UIImage imageNamed:@"rain1.png"];
	CGSize  oldFrame1 = img1.size;
	NSString *temStr1 = [NSString stringWithFormat:@"%d",self.rainArrBig1.count];
	count0 =[temStr1 length];
	OneRainView *myView1 = [[OneRainView alloc] initWithFrame:CGRectMake(387+count1*3+count2*3+count3*3+count4*3+count5*3, 11, oldFrame1.width, oldFrame1.height) WithImage:img1 convertData:temStr1];
	myView1.tag = 113;
	myView1.delegate = self;
	[self.rainPacHourView addSubview:myView1];
	[myView1 release];
	
	CGRect rainPHFrame = rainPacHourView.frame;
	CGRect outFrame = outFrameImgView.frame;
	CGRect hideFrame = hideImgView.frame;
	CGRect hideBtnFrame = hideBtn.frame;
	int total = (count0+count1+count2+count3+count4+count5)*3;
	rainPHFrame.size.width+=total;
	outFrame.size.width+=total;
	hideFrame.origin.x+=total;
	hideBtnFrame.origin.x+=total;
	[rainPacHourView setFrame:rainPHFrame];
	[outFrameImgView setFrame:outFrame];
	[hideImgView setFrame:hideFrame];
	[hideBtn setFrame:hideBtnFrame];
}

-(void)dealWithRainPacHour:(OneRainView *)myView convertRainType:(NSInteger)typeInt{
	NSInteger temInt= (typeInt-112);
	[self preparePoverRain:temInt];
}

-(void)dealWithRainMap:(NSString *)cellTemyear{
	[self setRainRegion];

	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mRain"]];
	[config release];
    
	NSString *myTime= [cellTemyear stringByReplacingOccurrencesOfString:@"小时" withString:@""];
	NSString *contentStr1 = [NSString stringWithFormat:@"%@h",myTime];
    NSURL *contentURL = [WebServices getNRestUrl:baseURL Function:@"RainListByHour" Parameter:contentStr1];
    RainTotalStringXMLParser *parser = [[RainTotalStringXMLParser alloc] init];
    [parser parseXMLFileAtURL:contentURL parseError:nil];
    [parser release];
    
    [self dealWithRainArray:myTotalRStr];
}

-(void)getRainListByHourString:(NSString *)temStr{
    myTotalRStr = temStr;
}

-(void)dealWithRainArray:(NSString *)rainURL{	
    //雨情与浙江蒙版相连 －－－NEW
	if (self.zjPolyLayer==NO) {
		[self drawZJPolygon];
	}	
    
    NSArray *singlton = [rainURL componentsSeparatedByString:@";"];
	if (self.rainPointArray !=nil) {
		[self.rainPointArray removeAllObjects];
	}
	//from big to small
	if (self.rainArrBig6 !=nil) {
		[self.rainArrBig6 removeAllObjects];
	}
	if (self.rainArrBig5 !=nil) {
		[self.rainArrBig5 removeAllObjects];
	}
	if (self.rainArrBig4 !=nil) {
		[self.rainArrBig4 removeAllObjects];
	}
	if (self.rainArrBig3 !=nil) {
		[self.rainArrBig3 removeAllObjects];
	}
	if (self.rainArrBig2 !=nil) {
		[self.rainArrBig2 removeAllObjects];
	}
	if (self.rainArrBig1 !=nil) {
		[self.rainArrBig1 removeAllObjects];
	}
    
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	for (int i =0; i<[singlton count]-1; i++) {
		NSString *temStr = [singlton objectAtIndex:i];
		NSArray *temArray = [temStr componentsSeparatedByString:@","];
		[self.rainPointArray addObject:temArray];
	}
	
	//deal with every rainArray's Value
	for(int idx = 0; idx < rainPointArray.count; idx++)
	{
		NSArray *tf = [self.rainPointArray objectAtIndex:idx];
        //defend the Error 
        if ([tf count]<9)
            continue;
		NSString *type =  [tf objectAtIndex:4];
		NSInteger myInt = [type intValue];
		switch (myInt) {
			case 1:
				[self.rainArrBig1 addObject:tf];
				break;
			case 2:
				[self.rainArrBig2 addObject:tf];
				break;
			case 3:
				[self.rainArrBig3 addObject:tf];
				break;
			case 4:
				[self.rainArrBig4 addObject:tf];
				break;
			case 5:
				[self.rainArrBig5 addObject:tf];
				break;
			case 6:
				[self.rainArrBig6 addObject:tf];
				break;
		}
	}
	[pool release];
	
	[self dealWithRainMapView:self.rainPointArray];
}

-(void)dealWithRainMapView:(NSMutableArray *)myArray{
	if (nil!=_RainrouteView) {
		[_RainrouteView removeFromSuperview];
		[_RainrouteView release];_RainrouteView = nil;
	}
	
	//while the custom disabled the multiLayer
	if (self.multiLayer==NO) {
		[self removeAll];
	}

	_RainrouteView = [[CSRainMapRouteLayerView alloc] initWithRoute:myArray mapView:_mapView mapType:0];
	[self removeWaitting];
}

-(void)preparePoverRain:(NSInteger)distinctType{
	[self.sListPopoverController dismissPopoverAnimated:NO];

	if (distinctType != oldrwp6Sig) 
	{	
		[self.rListPopoverController dismissPopoverAnimated:NO];
		self.rListPopoverController = nil;
		oldrwp6Sig = distinctType;

		NSMutableArray *myarray;
		switch (distinctType) {
			case 6:
				myarray = self.rainArrBig6;
				break;
			case 5:
				myarray = self.rainArrBig5;
				break;
			case 4:
				myarray = self.rainArrBig4;
				break;
			case 3:
				myarray = self.rainArrBig3;
				break;
			case 2:
				myarray = self.rainArrBig2;
				break;
			case 1:
				myarray = self.rainArrBig1;
				break;
		}
		Rain1Controller* content = [[Rain1Controller alloc] initWithNibName:@"Rain1" bundle:nil withArray:myarray];
		content.orderBy = @"desc";

		CGSize mySize = CGSizeMake(285, 408);
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:content];
		navController.delegate = self;
		//navController.modalInPopover = YES;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:navController]; 
		aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
		[content release];
		[navController release];
		[aPopover setPopoverContentSize:mySize];
		// Store the popover in a custom property for later use. 
		self.rListPopoverController = aPopover; 
		[aPopover release];
	}

	CGRect oldFrame = [(UIButton *)[self.view viewWithTag:(distinctType+112)] bounds];
	//oldFrame.origin.x-=95;
	[self.rListPopoverController presentPopoverFromRect:oldFrame inView:(UIButton *)[self.view viewWithTag:(distinctType+112)] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(IBAction)hideRainListView:(id)sender{
	oldrwp6Sig=0;
	[self.rListPopoverController dismissPopoverAnimated:NO];
	[self disabledGestureView];
	[self.barRainBtn setImage:[UIImage imageNamed:@"rain_normal.png"] forState:UIControlStateNormal];
	if (rainListTable.hidden ==NO && rainListTable!=nil) {
		rainListTable.hidden = YES;
		[rainListTable release];rainListTable= nil;
		myRainTableBottomVew.hidden = YES;
		[myRainTableBottomVew release];myRainTableBottomVew=nil;
	}
	
	CGRect oldFrame = rainPacHourView.frame;
	oldFrame.origin.x-=oldFrame.size.width;
	[UIView beginAnimations:@"HIDERAIN" context:nil];
	[UIView setAnimationDuration:0.8];
	//这里写子视图要移动什么地方的代码，只写直接改变到的点就可以例如：
	[rainPacHourView setFrame:oldFrame];
	[UIView commitAnimations];
	[self performSelector:@selector(removeRainListView) withObject:nil afterDelay:0.5];
}


-(void)removeRainListView{
	[self.rainPacHourView removeFromSuperview];
}

-(void)setRainRegion{
	// start off by default in San Francisco
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = 29.080555;
	newRegion.center.longitude = 119.122078;
	newRegion.span.latitudeDelta = 5.564740;
	newRegion.span.longitudeDelta = 9.370728;
    if (noNeedMove == NO) {
        [self.mapView setRegion:newRegion animated:YES];
    }
}

-(void)initPacAndHours{
	self.rainListArray = [[NSMutableArray alloc] initWithObjects:@"24",@"12",@"6",@"3",@"1",nil];
}

-(IBAction)touchNameRainButton:(id)sender{
	[self dismissRain];
	[self dismissRWP6];
    [self dismissAroundPin];
	CGRect fellowFrame = rainPacHourView.frame;
	if (rainListTable.hidden ==NO && rainListTable!=nil) {
		rainListTable.hidden = YES;
		[rainListTable release];rainListTable= nil;
		myRainTableBottomVew.hidden = YES;
		[myRainTableBottomVew release];myRainTableBottomVew=nil;
		[self disabledGestureView];
		return;
	}
	rainListTable = [[UITableView alloc] initWithFrame:CGRectMake(2,2, 83, 34*5) style:UITableViewStylePlain];
	rainListTable.tag = 112;
	rainListTable.userInteractionEnabled = YES;
	rainListTable.backgroundColor = [UIColor clearColor];
	rainListTable.dataSource = self;
	rainListTable.delegate = self;
	myRainTableBottomVew = [[UIImageView alloc] initWithFrame:CGRectMake(fellowFrame.origin.x+8, fellowFrame.origin.y+fellowFrame.size.height-15,85, 34*5+6)];
	myRainTableBottomVew.image = [UIImage imageNamed:@"typhoon_background.png"];
	myRainTableBottomVew.contentMode = UIViewContentModeScaleToFill;
	myRainTableBottomVew.userInteractionEnabled = YES;
	[myRainTableBottomVew addSubview:rainListTable];
	[self.view addSubview:myRainTableBottomVew];
	[self enabledGestureView];
}

#pragma mark -
#pragma mark waterPacTypeView
-(void)produceWaterPacTypeView{
	[[self.view viewWithTag:121] removeFromSuperview];
	[[self.view viewWithTag:122] removeFromSuperview];
	[[self.view viewWithTag:123] removeFromSuperview];
	[[self.view viewWithTag:124] removeFromSuperview];
	waterPacTypeView.frame = CGRectMake(0, 58, 364, 65);
	outWFrameImgView.frame = CGRectMake(0, 0, 334, 65);
	hideWImgView.frame = CGRectMake(334, 0, 30, 65);
	hideWBtn.frame = CGRectMake(334, 0, 30, 65);
	
	//河道、水库、闸坝、潮位
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	UIImage *img1 = [UIImage imageNamed:@"river.png"];
	CGSize  oldFrame1 = img1.size;
	NSString *temSt1 = [NSString stringWithFormat:@"%d",self.waterArrRiv.count];
	count1 = [temSt1 length];
	OneWaterView *myView1 =[[OneWaterView alloc] initWithFrame:CGRectMake(100, 12, oldFrame1.width, oldFrame1.height) WithImage:img1 convertWData:temSt1];
	myView1.tag = 122;
	myView1.delegate = self;
	[self.waterPacTypeView addSubview:myView1];
	[myView1 release];
	
	UIImage *img2 = [UIImage imageNamed:@"reservoir.png"];
	CGSize  oldFrame2 = img2.size;
	NSString *temSt2 = [NSString stringWithFormat:@"%d",self.waterArrRev.count];
	count2 = [temSt2 length];
	OneWaterView *myView2 = [[OneWaterView alloc] initWithFrame:CGRectMake(159+count1*3, 12, oldFrame2.width, oldFrame2.height) WithImage:img2 convertWData:temSt2];
	myView2.tag = 121;
	myView2.delegate = self;
	[self.waterPacTypeView addSubview:myView2];
	[myView2 release];
	
	UIImage *img3 = [UIImage imageNamed:@"gate.png"];
	CGSize  oldFrame3 = img3.size;
	NSString *temSt3 = [NSString stringWithFormat:@"%d",self.waterArrGat.count];
	count3 = [temSt3 length];
	OneWaterView *myView3 = [[OneWaterView alloc] initWithFrame:CGRectMake(218+count1*3+count2*3, 12, oldFrame3.width, oldFrame3.height) WithImage:img3 convertWData:temSt3];
	myView3.tag = 123;
	myView3.delegate = self;
	[self.waterPacTypeView addSubview:myView3];
	[myView3 release];
	
	UIImage *img4 = [UIImage imageNamed:@"tide.png"];
	CGSize  oldFrame4 = img4.size;
	NSString *temSt4 = [NSString stringWithFormat:@"%d",self.waterArrTid.count];
	count4 = [temSt4 length];
	OneWaterView *myView4 = [[OneWaterView alloc] initWithFrame:CGRectMake(275+count1*3+count2*3+count3*3, 12, oldFrame4.width, oldFrame4.height) WithImage:img4 convertWData:temSt4];
	myView4.tag = 124;
	myView4.delegate = self;
	[self.waterPacTypeView addSubview:myView4];
	[myView4 release];
	
	
	CGRect waterPHFrame = waterPacTypeView.frame;
	CGRect outWFrame = outWFrameImgView.frame;
	CGRect hideWFrame = hideWImgView.frame;
	CGRect hideWBtnFrame = hideWBtn.frame;
	int total = (count1+count2+count3+count4)*3;
	waterPHFrame.size.width+=total;
	outWFrame.size.width+=total;
	hideWFrame.origin.x+=total;
	hideWBtnFrame.origin.x+=total;
	[waterPacTypeView setFrame:waterPHFrame];
	[outWFrameImgView setFrame:outWFrame];
	[hideWImgView setFrame:hideWFrame];
	[hideWBtn setFrame:hideWBtnFrame];
}

-(IBAction)showWaterListView:(id)sender{
    noNeedMove = NO;
    
	[self disabledGestureView];
	[self.sListPopoverController dismissPopoverAnimated:NO];
	[self dismissRWP6];
    [self dismissAroundPin];
	[self dismissHistoryTyphoon];

	if (self.waterPacTypeView.superview==nil) {
		[self addWaitting];
	}
	[self performSelector:@selector(prepareShowWaterListView) withObject:nil afterDelay:0.001];
}

-(void)prepareShowWaterListView{
	[self.barWaterBtn setImage:[UIImage imageNamed:@"gq_select.png"] forState:UIControlStateNormal];
	[self performSelectorOnMainThread:@selector(hideTyphoonListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideSatelliteTimeViewView:) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];

	if (waterPacTypeView.superview==nil) {
		[self.waterPacTypeView setFrame:CGRectMake(0, 58, 364, 65)];			
		[self.view addSubview:self.waterPacTypeView];
		
		[self addWaitting];
		
		[self.waterNameButton setTitle:@"超警(限)" forState:UIControlStateNormal] ;
		NSString *temStr = self.waterNameButton.titleLabel.text;
		[self dealWithWaterMap:temStr];
		[self produceWaterPacTypeView];
	}
	[self removeWaitting];
}


-(void)dealWithWaterMap:(NSString *)cellTemyear{
	[self setRainRegion];
    
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWater"]];
	[config release];
    
	NSString *type;
	if ([cellTemyear isEqualToString:@"超警(限)"]) {
		type = [NSString stringWithString:@"waterover"];
	} else if ([cellTemyear isEqualToString:@"所有站点"]) {
		type = [NSString stringWithString:@"water"];
	} else {
		type = [NSString stringWithString:@"water"];
	}
    
    NSURL *contentURL = [WebServices getNRestUrl:baseURL Function:@"WaterListByType" Parameter:type];
    WaterTotalStringXMLParser *parser = [[WaterTotalStringXMLParser alloc] init];
    [parser parseXMLFileAtURL:contentURL parseError:nil];
    [parser release];
    
    [self dealWithWaterArray:myTotalWStr];
}



-(void)getWaterListByTypeString:(NSString *)temStr{ 
    self.myTotalWStr = temStr;
}


-(void)dealWithWaterArray:(NSString *)mWaterContent{
	if ([mWaterContent length]>0||[mWaterContent length]==0) {
		if (self.waterPointArray !=nil) {
			[self.waterPointArray release];
			self.waterPointArray = nil;
			self.waterPointArray = [[NSMutableArray alloc]init];
		}
		if (self.waterArrRiv !=nil) {
			[self.waterArrRiv release];
			self.waterArrRiv = nil;
			self.waterArrRiv = [[NSMutableArray alloc]init];		
        }
		if (self.waterArrRev !=nil) {
			[self.waterArrRev release];
			self.waterArrRev = nil;
			self.waterArrRev = [[NSMutableArray alloc]init];		
        }
		if (self.waterArrGat !=nil) {
			[self.waterArrGat release];
			self.waterArrGat = nil;
			self.waterArrGat = [[NSMutableArray alloc]init];		
        }
		if (self.waterArrTid !=nil) {
			[self.waterArrTid release];
			self.waterArrTid = nil;
			self.waterArrTid = [[NSMutableArray alloc]init];		
        }
        
		NSArray *singlton = [mWaterContent componentsSeparatedByString:@";"];        
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];            
		for (int i =0; i<[singlton count]-1; i++) {
			NSString *temStr = [singlton objectAtIndex:i];
			NSArray *temArray = [temStr componentsSeparatedByString:@","];
			[self.waterPointArray addObject:temArray];
		}
		//deal with every rainArray's Value
		for(int idx = 0; idx < waterPointArray.count; idx++)
		{
			NSArray *tf = [self.waterPointArray objectAtIndex:idx];
            if([tf count]<12)
                continue;
			NSString *type =  [tf objectAtIndex:2];
			if ([type isEqualToString:@"ZZ"]) {
				[self.waterArrRiv addObject:tf];
			} else if ([type isEqualToString:@"RR"]) {
				[self.waterArrRev addObject:tf];
			} else if ([type isEqualToString:@"DD"]) {
				[self.waterArrGat addObject:tf];
			} else if ([type isEqualToString:@"TT"]) {
				[self.waterArrTid addObject:tf];
			}
		}
		[pool release];
	}
	[self dealWithWaterView];
}

-(void)dealWithWaterView{
	if (nil!=_WaterrouteView) {
		[_WaterrouteView removeFromSuperview];
		[_WaterrouteView release];
		_WaterrouteView = nil;
	}
	
	//while the custom diabled the multiLayer
	if (self.multiLayer==NO) {
		[self removeAll];
	}
	
	_WaterrouteView = [[CSWaterMapRouteLayerView alloc] initWithRoute:waterPointArray mapView:_mapView mapType:0];
	[self removeWaitting];
}


-(void)dealWithWaterPacType:(OneWaterView *)myView convertWaterType:(NSInteger)typeInt{
	NSInteger temInt= (typeInt-120);
	[self preparePoverWater:temInt];
}

-(NSString *)changeWIntoBetWeen:(NSString *)betInt{
	NSString *returnStr = @"0";
	if ([betInt isEqualToString:@"122"]) {
		returnStr = @"2";//ZZ-河道
	} else if ([betInt isEqualToString:@"121"]) {
		returnStr = @"1";//RR-水库
	} else if ([betInt isEqualToString:@"123"]) {
		returnStr = @"3";//DD－闸
	} else if ([betInt isEqualToString:@"124"]) {
		returnStr = @"4";//TT－潮
	}
	return returnStr;
}

-(void)preparePoverWater:(NSInteger)myTypeInt{
	[self.sListPopoverController dismissPopoverAnimated:NO];
	if (myTypeInt!=oldrwp6Sig) 
	{
		[self.wListPopoverController dismissPopoverAnimated:NO];
		self.wListPopoverController = nil;
		oldrwp6Sig = myTypeInt;
		NSMutableArray *myarray;
		switch (myTypeInt) {
			case 2:
				myarray = self.waterArrRiv;
				break;
			case 1:
				myarray = self.waterArrRev;
				break;
			case 3:
				myarray = self.waterArrGat;
				break;
			case 4:
				myarray = self.waterArrTid;
				break;
		}
		
		Water1Controller* content = [[Water1Controller alloc] initWithNibName:@"Water1" bundle:nil withArray:myarray];
        content.waterType = [NSString stringWithFormat:@"%d",myTypeInt];
		content.orderby = @"desc";
		CGSize mySize = CGSizeMake(320, 412);
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:content];
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:navController]; 
		aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
		[content release];
		[navController release];
		[aPopover setPopoverContentSize:mySize];
		// Store the popover in a custom property for later use. 
		self.wListPopoverController = aPopover; 
		[aPopover release];
	}

	CGRect oldFrame = [(UIButton *)[self.view viewWithTag:(myTypeInt+120)] bounds];
	[self.wListPopoverController presentPopoverFromRect:oldFrame inView:(UIButton *)[self.view viewWithTag:(myTypeInt+120)] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(IBAction)hideWaterListView:(id)sender{
	[self disabledGestureView];
	oldrwp6Sig=0;
	[self.wListPopoverController dismissPopoverAnimated:NO];
	[self.barWaterBtn setImage:[UIImage imageNamed:@"gq_normal.png"] forState:UIControlStateNormal];
	if (waterListTable.hidden ==NO && waterListTable!=nil) {
		waterListTable.hidden = YES;
		[waterListTable release];waterListTable= nil;
		myWaterTableBottomView.hidden = YES;
		[myWaterTableBottomView release];myWaterTableBottomView=nil;
	}
	
	CGRect oldFrame = waterPacTypeView.frame;
	oldFrame.origin.x-=oldFrame.size.width;
	[UIView beginAnimations:@"HIDEWATER" context:nil];
	[UIView setAnimationDuration:0.8];
	//这里写子视图要移动什么地方的代码，只写直接改变到的点就可以例如：
	[waterPacTypeView setFrame:oldFrame];
	[UIView commitAnimations];
	[self performSelector:@selector(removeWaterListView) withObject:nil afterDelay:0.5];
}

-(void)removeWaterListView{
	[self.waterPacTypeView removeFromSuperview];
}

-(void)initWaterStaus{
	waterListArray = [[NSMutableArray alloc] initWithObjects: @"超警(限)",@"所有站点",nil];
}

-(IBAction)touchNameWaterButton:(id)sender{
	[self dismissWater];
	[self dismissRWP6];
    [self dismissAroundPin];
	
	CGRect fellowFrame = waterPacTypeView.frame;
	if (waterListTable.hidden ==NO && waterListTable!=nil) {
		waterListTable.hidden = YES;
		[waterListTable release];waterListTable= nil;
		myWaterTableBottomView.hidden = YES;
		[myWaterTableBottomView release];myWaterTableBottomView=nil;
		[self disabledGestureView];
		return;
	}
	waterListTable = [[UITableView alloc] initWithFrame:CGRectMake(1,2, 84, 34*2) style:UITableViewStylePlain];
	waterListTable.tag = 120;
	waterListTable.userInteractionEnabled = YES;
	waterListTable.backgroundColor = [UIColor clearColor];
	waterListTable.dataSource = self;
	waterListTable.delegate = self;
	myWaterTableBottomView = [[UIImageView alloc] initWithFrame:CGRectMake(fellowFrame.origin.x+8, fellowFrame.origin.y+fellowFrame.size.height-15,84, 34*2+8)];
	myWaterTableBottomView.image = [UIImage imageNamed:@"typhoon_background.png"];
	myWaterTableBottomView.contentMode = UIViewContentModeScaleToFill;
	myWaterTableBottomView.userInteractionEnabled = YES;
	[myWaterTableBottomView addSubview:waterListTable];
	[self.view addSubview:myWaterTableBottomView];
	[self enabledGestureView];
}

#pragma mark -
#pragma mark Project 
-(IBAction)showProjectListView:(id)sender{
    noNeedMove = NO;
	[self disabledGestureView];
	[self.sListPopoverController dismissPopoverAnimated:NO];
	[self dismissRWP6];
    [self dismissAroundPin];
	[self dismissHistoryTyphoon];

	if (self.projectPacTypeView.superview==nil) {
		[self addWaitting];
	}
	[self performSelector:@selector(prepareShowProjectListView) withObject:nil afterDelay:0.001];
}

-(void)prepareShowProjectListView{
	[self.barProjectBtn setImage:[UIImage imageNamed:@"project_select.png"] forState:UIControlStateNormal];
	[self performSelectorOnMainThread:@selector(hideTyphoonListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideSatelliteTimeViewView:) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];
	if (projectPacTypeView.superview==nil) {
		//show the region of ZJ
		[self setRainRegion];
		
		[self.projectPacTypeView setFrame:CGRectMake(0, 58, 482, 65)];
		[self.view addSubview:self.projectPacTypeView];
		
		//[self addWaitting];
		FileManager *config=[[FileManager alloc] init];
		NSArray *locationArray=[config getLocation];
		[config release];
		[self.projectNameButton setTitle:[locationArray objectAtIndex:1] forState:UIControlStateNormal];
		[self prepareProjectListArrayWithPac:[locationArray objectAtIndex:0]];
	}
}

-(void)prepareProjectListArrayWithPac:(NSString *)nowPac{
	[self.projectGroupArray removeAllObjects];
	
	NSString *cdPAC = [NSString stringWithFormat:@"%@",nowPac];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    FileManager *config = [[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWork"]];
    [config release];
    
    NSURL *ylfbURLA=[WebServices getNRestUrl:baseURL Function:@"ProjectStat_Filter" Parameter:cdPAC];
    ProjectNameAndNumberXMLParser *pasera=[[ProjectNameAndNumberXMLParser alloc] init];
	[pasera parseXMLFileAtURL:ylfbURLA parseError:nil]; 
	[pasera release];
	[pool release];
	[self produceProjectListView];
	[self removeWaitting];
}

-(void)getProjectListArray:(WorkInfo *)temInfo{
    [self.projectGroupArray addObject:temInfo];
}

-(void)produceProjectListView{
	[[self.view viewWithTag:131] removeFromSuperview];
	[[self.view viewWithTag:132] removeFromSuperview];
	[[self.view viewWithTag:133] removeFromSuperview];
    [[self.view viewWithTag:134] removeFromSuperview];
	[[self.view viewWithTag:135] removeFromSuperview];
	[[self.view viewWithTag:136] removeFromSuperview];
	projectPacTypeView.frame = CGRectMake(0, 58, 421+53+8, 65);
	outPFrameImgView.frame = CGRectMake(0, 0, 391+53+8, 65);
	hidePImgView.frame = CGRectMake(391+53+8, 0, 30, 65);
	hidePBtn.frame = CGRectMake(391+53+8, 0, 30, 65);
	
    NSInteger temCount1= 0;
    NSInteger temCount2= 0;
    NSInteger temCount3= 0;
    NSInteger temCount4= 0;
    NSInteger temCount5= 0;
    NSInteger temCount6= 0;
    for (int j=0; j<[self.projectGroupArray count];j++) {
        WorkInfo *temI = [self.projectGroupArray objectAtIndex:j];
        if ([temI.ennm isEqualToString:@"水库"]) {
            temCount1=[temI.dsnm intValue];
        } else if([temI.ennm isEqualToString:@"水闸"]){
            temCount2=[temI.dsnm intValue];
        } else if([temI.ennm isEqualToString:@"水电站"]){
            temCount3=[temI.dsnm intValue];
        } else if([temI.ennm isEqualToString:@"海塘"]){
            temCount4=[temI.dsnm intValue];
        } else if([temI.ennm isEqualToString:@"堤防"]){
            temCount5=[temI.dsnm intValue];
        } else if([temI.ennm isEqualToString:@"泵站"]){
            temCount6=[temI.dsnm intValue];
        }
    }
    //水库131 堤防132 海塘133 泵站134 水闸135 水电站136 － 2012
    
	//水库－131、河道132、海堤（塘）－133、水闸－134、电站－135
	//水库、水闸、电站
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	int count5 = 0;
    int count6 = 0;
	UIImage *img1 = [UIImage imageNamed:@"sk.png"];
	CGSize  oldFrame1 = img1.size;
	NSString *temSt1 = [NSString stringWithFormat:@"%d",temCount1];
	count1 = [temSt1 length];
	OneProjectView *myView1 =[[OneProjectView alloc] initWithFrame:CGRectMake(86, 12, oldFrame1.width, oldFrame1.height) WithImage:img1 convertWData:temSt1];
	myView1.tag = 131;
	myView1.delegate = self;
	[self.projectPacTypeView addSubview:myView1];
	[myView1 release];
	
	UIImage *img2 = [UIImage imageNamed:@"sz.png"];
	CGSize  oldFrame2 = img2.size;
	NSString *temSt2 = [NSString stringWithFormat:@"%d",temCount2];
	count2 = [temSt2 length];
	OneProjectView *myView2 = [[OneProjectView alloc] initWithFrame:CGRectMake(147+count1*3, 12, oldFrame2.width, oldFrame2.height) WithImage:img2 convertWData:temSt2];
	myView2.tag = 132;
	myView2.delegate = self;
	[self.projectPacTypeView addSubview:myView2];
	[myView2 release];
	
	UIImage *img3 = [UIImage imageNamed:@"dz.png"];
	CGSize  oldFrame3 = img3.size;
	NSString *temSt3 = [NSString stringWithFormat:@"%d",temCount3];
	count3 = [temSt3 length];
	OneProjectView *myView3 = [[OneProjectView alloc] initWithFrame:CGRectMake(208+count1*3+count2*3, 12, oldFrame3.width, oldFrame3.height) WithImage:img3 convertWData:temSt3];
	myView3.tag = 133;
	myView3.delegate = self;
	[self.projectPacTypeView addSubview:myView3];
	[myView3 release];
    
    //new
    UIImage *img4 = [UIImage imageNamed:@"ht.png"];
	CGSize  oldFrame4 = img4.size;
	NSString *temSt4 = [NSString stringWithFormat:@"%d",temCount4];
	count4 = [temSt4 length];
	OneProjectView *myView4 = [[OneProjectView alloc] initWithFrame:CGRectMake(269+count1*3+count2*3+count3*3, 12, oldFrame4.width, oldFrame4.height) WithImage:img4 convertWData:temSt4];
	myView4.tag = 134;
	myView4.delegate = self;
	[self.projectPacTypeView addSubview:myView4];
	[myView4 release];
    
    UIImage *img5 = [UIImage imageNamed:@"df.png"];
	CGSize  oldFrame5 = img5.size;
	NSString *temSt5 = [NSString stringWithFormat:@"%d",temCount5];
	count5 = [temSt5 length];
	OneProjectView *myView5 = [[OneProjectView alloc] initWithFrame:CGRectMake(330+count1*3+count2*3+count3*3+count4*3, 12, oldFrame5.width, oldFrame5.height) WithImage:img5 convertWData:temSt5];
	myView5.tag = 135;
	myView5.delegate = self;
	[self.projectPacTypeView addSubview:myView5];
	[myView5 release];
    
    UIImage *img6 = [UIImage imageNamed:@"bz.png"];
	CGSize  oldFrame6 = img6.size;
	NSString *temSt6 = [NSString stringWithFormat:@"%d",temCount6];
	count6 = [temSt6 length];
	OneProjectView *myView6 = [[OneProjectView alloc] initWithFrame:CGRectMake(391+count1*3+count2*3+count3*3+count4*3+count5*3, 12, oldFrame6.width, oldFrame6.height) WithImage:img6 convertWData:temSt6];
	myView6.tag = 136;
	myView6.delegate = self;
	[self.projectPacTypeView addSubview:myView6];
	[myView6 release];
	
	CGRect projectPHFrame = projectPacTypeView.frame;
	CGRect outPFrame = outPFrameImgView.frame;
	CGRect hidePFrame = hidePImgView.frame;
	CGRect hidePBtnFrame = hidePBtn.frame;
	int total = (count1+count2+count3+count4+count5+count6)*3;
	projectPHFrame.size.width+=total;
	outPFrame.size.width+=total;
	hidePFrame.origin.x+=total;
	hidePBtnFrame.origin.x+=total;
	[projectPacTypeView setFrame:projectPHFrame];
	[outPFrameImgView setFrame:outPFrame];
	[hidePImgView setFrame:hidePFrame];
	[hidePBtn setFrame:hidePBtnFrame];
}

-(NSInteger)convertCountWithArray:(NSMutableArray *)temArray{
	NSMutableArray *temcArray = temArray;
	NSInteger retInt = 0;
	for (int idx= 0; idx<temcArray.count; idx++) {
		NSString *myStr = [temcArray objectAtIndex:idx];
		retInt +=[myStr intValue];
	}
	return retInt;
}

-(IBAction)hideProjectListView:(id)sender{
	[self.barProjectBtn setImage:[UIImage imageNamed:@"project_normal.png"] forState:UIControlStateNormal];
	//添加隐藏地区选择POPVER
	oldrwp6Sig=0;
	[self.pListPopoverController dismissPopoverAnimated:NO];
	
	CGRect oldFrame = projectPacTypeView.frame;
	oldFrame.origin.x-=oldFrame.size.width;
	[UIView beginAnimations:@"HIDEPROJECT" context:nil];
	[UIView setAnimationDuration:0.8];
	//这里写子视图要移动什么地方的代码，只写直接改变到的点就可以例如：
	[projectPacTypeView setFrame:oldFrame];
	[UIView commitAnimations];
	[self performSelector:@selector(removeProjectListView) withObject:nil afterDelay:0.5];
}

-(void)removeProjectListView{
	[self.projectPacTypeView removeFromSuperview];
}

-(IBAction)showChooseLocation:(id)sender{
	[self dismissProject];
	[self dismissRWP6];
    [self dismissAroundPin];
	
	if (![self.lListPopoverController.contentViewController isKindOfClass:[LocationController class]]) 
	{	
		self.lListPopoverController = nil;
	}
	LocationController* content = [[LocationController alloc] initWithNibName:@"Location" bundle:nil]; 
	content.delegate = self;
	content.isOnlyChoose = YES;
	UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 
	aPopover.delegate = self;
	[content release];
	[aPopover setPopoverContentSize:CGSizeMake(320, 337)];
	// Store the popover in a custom property for later use. 
	self.lListPopoverController = aPopover; 
	[aPopover release];
	
	[self.lListPopoverController presentPopoverFromRect:[(UIButton *)[self.view viewWithTag:9999] bounds] inView:(UIButton *)[self.view viewWithTag:9999] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)dealWithProjectPacType:(OneProjectView *)myView convertProjectType:(NSInteger)typeInt{
	NSInteger temInt= (typeInt-130);
	[self preparePoverProject:temInt];
}

-(void)preparePoverProject:(NSInteger)myTypeInt{
	[self.sListPopoverController dismissPopoverAnimated:NO];

	if (myTypeInt!=oldrwp6Sig) 
	{
		[self.pListPopoverController dismissPopoverAnimated:NO];
		self.pListPopoverController = nil;
		oldrwp6Sig = myTypeInt;
		Work1Controller* content = [[Work1Controller alloc] initWithNibName:@"Work1" bundle:nil];
		switch (myTypeInt) {
			case 1:    
				[content initWater] ;
				break;
			case 2:
                [content initSluice] ;
				break;
			case 3:
                [content initPowerStation] ;
				break;
			case 4:
                [content initFormation];
				break;
			case 5:
                [content initDike];
				break;
            case 6:
				[content initRankIrrigation];
				break;
		}
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:content];
		navController.delegate = self;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:navController]; 
		aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
		[content release];
		[navController release];
		// Store the popover in a custom property for later use. 
		self.pListPopoverController = aPopover; 
		[aPopover release];
	}
	
    CGSize mySize = CGSizeMake(320-30, 287);
    [self.pListPopoverController setPopoverContentSize:mySize];
	CGRect oldFrame = [(UIButton *)[self.view viewWithTag:(myTypeInt+130)] bounds];
	//oldFrame.origin.x-=95;
	[self.pListPopoverController presentPopoverFromRect:oldFrame inView:(UIButton *)[self.view viewWithTag:(myTypeInt+130)] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


#pragma mark - CoreLocation
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.coord = newLocation.coordinate;
    //如果定位成功，就显示当前点
    _mapView.showsUserLocation = YES;
    
    //开始获取数据，加入提示
    /** 将得到的经纬度作为参数，开始获取数据 **/
    [self performSelectorOnMainThread:@selector(fetchAroundData) withObject:nil waitUntilDone:YES];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    /** 定位失败报错 **/
    [self removeWaitting];
    //如果定位失败，就关闭当前点
    _mapView.showsUserLocation = NO;
    //提示定位服务未开启
    UIAlertView *view = [[[UIAlertView alloc] initWithTitle:@"获取定位信息失败" message:@"请您确定开启了“定位服务”。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
    [view show];}


#pragma mark -
#pragma mark -Around
-(IBAction)showAroundListView:(id)sender{
    noNeedMove = NO;
    //dismiss gesture
	[self disabledGestureView];
    //dismiss searchPopover
	[self.sListPopoverController dismissPopoverAnimated:NO];
    //dismiss RWP6Popover
	[self dismissRWP6];
    //dismiss HistoryTyphoon
	[self dismissHistoryTyphoon];
    //dismiss AroundPin
    [self dismissAroundPin];
    [self dismissAround];
    //set default value
    self.selectedRadius = RADIUS_B;
    [aroundNameButton setTitle:@"5公里" forState:UIControlStateNormal];

	//移去另外的listView
	[self performSelectorOnMainThread:@selector(hideTyphoonListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideSatelliteTimeViewView:) withObject:nil waitUntilDone:YES];
	//开始定位
    [self performSelector:@selector(beginLocation) withObject:nil afterDelay:0.001];
}

-(void)beginLocation {
    //add wattingView
    [self addWaitting];
    //开始定位而已,并在定位后获取数据
    if ([CLLocationManager locationServicesEnabled] == YES) {
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
        }
        //开始定位
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
        [CLLocationManager authorizationStatus];
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
        NSLog(@"LocationServicesEnabled");
    } else {
        NSLog(@"LocationServicesDisabled");
        //移出定位提示
        [self removeWaitting];
        //提示定位服务未开启
        UIAlertView *view = [[[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请您前往手机“设置”中开启“定位服务”。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
        [view show];
    }
}


//定位成功后获取数据
-(void)fetchAroundData
{
    //地图定位
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_coord, [_selectedRadius doubleValue]*696.0/1024*2.5, [_selectedRadius doubleValue]*2.5);
    [_mapView setRegion:region animated:NO];
    MKCoordinateSpan span = region.span;
    CLLocationDegrees moveRight = span.longitudeDelta * 1.2/5;
    CLLocationCoordinate2D finaCoord = CLLocationCoordinate2DMake(_coord.latitude, _coord.longitude - moveRight);
    [_mapView setCenterCoordinate:finaCoord];
    
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    //先确保清空数据
    [_sectionObjets removeAllObjects];
    [_mapView removeAnnotations:aroundSZArray];
    [aroundSZArray removeAllObjects];
    [_mapView removeAnnotations:aroundDFArray];
    [aroundDFArray removeAllObjects];
    [_mapView removeAnnotations:aroundBZArray];
    [aroundBZArray removeAllObjects];
    [_mapView removeAnnotations:aroundHTArray];
    [aroundHTArray removeAllObjects];
    [_mapView removeAnnotations:aroundDZArray];
    [aroundDZArray removeAllObjects];
    [_mapView removeAnnotations:aroundSKArray];
    [aroundSKArray removeAllObjects];
    //sucess to fetch location data , begin to fetch data
    FileManager *config=[[[FileManager alloc] init] autorelease];
    NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWork"]];
    //NSString *baseURL = @"http://42.120.40.150/gq/DataService.asmx/";
    NSString *methodNm = @"ProjectInArea";
    //纬度|经度|半径|工程类别(水闸k 泵站J,水电站T,海塘E,堤防D,水库B)
    //在ipad系统中默认是搜索全部周边6类工程的
    NSString *typeStr = [_typeArray objectAtIndex:0];
    NSArray *typeArr = [typeStr componentsSeparatedByString:@"$"];
    NSString *param = [NSString stringWithFormat:@"%lf|%lf|%@|%@",_coord.latitude,_coord.longitude,_selectedRadius,[typeArr objectAtIndex:1]];
    NSURL *url = [WebServices getNRestUrl:baseURL Function:methodNm Parameter:param];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    AroundResultParser *parser = [[AroundResultParser alloc] initWithData:data];
	[data release];
    //默认都不打开
    parser.coordinate = _coord;
    [parser startParser];
    [parser release];
    
	//while the custom disabled the multiLayer
	if (self.multiLayer==NO) {
		[self removeAll];
	}
    
    //周边没有东西处理处理
    if ([aroundSZArray count]>0||[aroundSKArray count]>0||[aroundDFArray count]>0||[aroundHTArray count]>0||[aroundDZArray count]>0||[aroundBZArray count]>0) {
        //没有东西，则加入提示
        self.aroundLayer = YES;
    }
    
    //列表数据准备完毕，准备地图数据
    
    //加入地图
    [_mapView addAnnotations:aroundSZArray];
    [_mapView addAnnotations:aroundSKArray];
    [_mapView addAnnotations:aroundDFArray];
    [_mapView addAnnotations:aroundHTArray];
    [_mapView addAnnotations:aroundDZArray];
    [_mapView addAnnotations:aroundBZArray];
    
	//展现listView
	[self prepareShowAroundListView];
    //显示列表
    [self produceAroundListView];
    
    //无论成功与否，都要移出提示
    [self performSelector:@selector(removeWaitting) withObject:nil afterDelay:0.3];
}

-(void)prepareShowAroundListView{
	[self.barAroundBtn setImage:[UIImage imageNamed:@"tool_select.png"] forState:UIControlStateNormal];
	if (aroundPacTypeView.superview==nil) {
        CGRect frame = self.aroundPacTypeView.frame;
        frame.origin = CGPointMake(0, 58);
		[self.aroundPacTypeView setFrame:frame];
		[self.view addSubview:self.aroundPacTypeView];
	}
}


-(void)addSectionInfos:(NSMutableArray *)sections;
{
    self.sectionObjets = sections;
}

-(void)addSKMapArray:(NSMutableArray *)array;
{
    self.aroundSKArray = array;
}

-(void)addSZMapArray:(NSMutableArray *)array;
{
    self.aroundSZArray = array;
}

-(void)addBZMapArray:(NSMutableArray *)array;
{
    self.aroundBZArray = array;
}

-(void)addHTMapArray:(NSMutableArray *)array;
{
    self.aroundHTArray = array;
}

-(void)addDFMapArray:(NSMutableArray *)array;
{
    self.aroundDFArray = array;
}

-(void)addDZMapArray:(NSMutableArray *)array;
{
    self.aroundDZArray = array;
}

-(void)fetchDataError
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"通讯异常" message:@"网络原因或其他原因" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试",nil] autorelease];
    [alertView show];
}

-(void)produceAroundListView{
	[[self.view viewWithTag:141] removeFromSuperview];
	[[self.view viewWithTag:142] removeFromSuperview];
	[[self.view viewWithTag:143] removeFromSuperview];
    [[self.view viewWithTag:144] removeFromSuperview];
	[[self.view viewWithTag:145] removeFromSuperview];
	[[self.view viewWithTag:146] removeFromSuperview];
	aroundPacTypeView.frame = CGRectMake(0, 58, 421+53+8+13, 65);
	outAFrameImgView.frame = CGRectMake(0, 0, 391+53+8+13, 65);
	hideAImgView.frame = CGRectMake(391+53+8+13, 0, 30, 65);
	hideABtn.frame = CGRectMake(391+53+8+13, 0, 30, 65);
	
    NSInteger temCount1= [aroundSKArray count];
    NSInteger temCount2= [aroundSZArray count];
    NSInteger temCount3= [aroundDZArray count];
    NSInteger temCount4= [aroundHTArray count];
    NSInteger temCount5= [aroundDFArray count];
    NSInteger temCount6= [aroundBZArray count];
    
	//水库－141 水闸－142 电站－143 海塘－144 堤防－145 泵站－146
	//水库、水闸、电站
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	int count4 = 0;
	int count5 = 0;
    int count6 = 0;
	UIImage *img1 = [UIImage imageNamed:@"sk.png"];
	CGSize  oldFrame1 = img1.size;
	NSString *temSt1 = [NSString stringWithFormat:@"%d",temCount1];
	count1 = [temSt1 length];
	OneAroundView *myView1 =[[OneAroundView alloc] initWithFrame:CGRectMake(86+13, 12, oldFrame1.width, oldFrame1.height) WithImage:img1 convertWData:temSt1];
	myView1.tag = 141;
	myView1.delegate = self;
	[self.aroundPacTypeView addSubview:myView1];
	[myView1 release];
	
	UIImage *img2 = [UIImage imageNamed:@"sz.png"];
	CGSize  oldFrame2 = img2.size;
	NSString *temSt2 = [NSString stringWithFormat:@"%d",temCount2];
	count2 = [temSt2 length];
	OneAroundView *myView2 = [[OneAroundView alloc] initWithFrame:CGRectMake(147+13+count1*3, 12, oldFrame2.width, oldFrame2.height) WithImage:img2 convertWData:temSt2];
	myView2.tag = 142;
	myView2.delegate = self;
	[self.aroundPacTypeView addSubview:myView2];
	[myView2 release];
	
	UIImage *img3 = [UIImage imageNamed:@"dz.png"];
	CGSize  oldFrame3 = img3.size;
	NSString *temSt3 = [NSString stringWithFormat:@"%d",temCount3];
	count3 = [temSt3 length];
	OneAroundView *myView3 = [[OneAroundView alloc] initWithFrame:CGRectMake(208+13+count1*3+count2*3, 12, oldFrame3.width, oldFrame3.height) WithImage:img3 convertWData:temSt3];
	myView3.tag = 143;
	myView3.delegate = self;
	[self.aroundPacTypeView addSubview:myView3];
	[myView3 release];
    
    //new
    UIImage *img4 = [UIImage imageNamed:@"ht.png"];
	CGSize  oldFrame4 = img4.size;
	NSString *temSt4 = [NSString stringWithFormat:@"%d",temCount4];
	count4 = [temSt4 length];
	OneAroundView *myView4 = [[OneAroundView alloc] initWithFrame:CGRectMake(269+13+count1*3+count2*3+count3*3, 12, oldFrame4.width, oldFrame4.height) WithImage:img4 convertWData:temSt4];
	myView4.tag = 144;
	myView4.delegate = self;
	[self.aroundPacTypeView addSubview:myView4];
	[myView4 release];
    
    UIImage *img5 = [UIImage imageNamed:@"df.png"];
	CGSize  oldFrame5 = img5.size;
	NSString *temSt5 = [NSString stringWithFormat:@"%d",temCount5];
	count5 = [temSt5 length];
	OneAroundView *myView5 = [[OneAroundView alloc] initWithFrame:CGRectMake(330+13+count1*3+count2*3+count3*3+count4*3, 12, oldFrame5.width, oldFrame5.height) WithImage:img5 convertWData:temSt5];
	myView5.tag = 145;
	myView5.delegate = self;
	[self.aroundPacTypeView addSubview:myView5];
	[myView5 release];
    
    UIImage *img6 = [UIImage imageNamed:@"bz.png"];
	CGSize  oldFrame6 = img6.size;
	NSString *temSt6 = [NSString stringWithFormat:@"%d",temCount6];
	count6 = [temSt6 length];
	OneAroundView *myView6 = [[OneAroundView alloc] initWithFrame:CGRectMake(391+13+count1*3+count2*3+count3*3+count4*3+count5*3, 12, oldFrame6.width, oldFrame6.height) WithImage:img6 convertWData:temSt6];
	myView6.tag = 146;
	myView6.delegate = self;
	[self.aroundPacTypeView addSubview:myView6];
	[myView6 release];
	
	CGRect projectPHFrame = aroundPacTypeView.frame;
	CGRect outPFrame = outAFrameImgView.frame;
	CGRect hidePFrame = hideAImgView.frame;
	CGRect hidePBtnFrame = hideABtn.frame;
	int total = (count1+count2+count3+count4+count5+count6)*3;
	projectPHFrame.size.width+=total;
	outPFrame.size.width+=total;
	hidePFrame.origin.x+=total;
	hidePBtnFrame.origin.x+=total;
	[aroundPacTypeView setFrame:projectPHFrame];
	[outAFrameImgView setFrame:outPFrame];
	[hideAImgView setFrame:hidePFrame];
	[hideABtn setFrame:hidePBtnFrame];
}

-(IBAction)hideAroundListView:(id)sender{
    [self disabledGestureView];
	//添加隐藏地区选择POPVER
	oldrwp6Sig=0;
	[self.aroundListPopoverController dismissPopoverAnimated:NO];
    [self.barAroundBtn setImage:[UIImage imageNamed:@"tool_normal.png"] forState:UIControlStateNormal];
    if (radiusListTable.hidden ==NO && radiusListTable!=nil) {
		radiusListTable.hidden = YES;
		[radiusListTable release];radiusListTable= nil;
		myAroundTableBottomView.hidden = YES;
		[myRainTableBottomVew release];myRainTableBottomVew=nil;
	}
	CGRect oldFrame = aroundPacTypeView.frame;
	oldFrame.origin.x-=oldFrame.size.width;
	[UIView beginAnimations:@"HIDEAROUND" context:nil];
	[UIView setAnimationDuration:0.8];
	//这里写子视图要移动什么地方的代码，只写直接改变到的点就可以例如：
	[aroundPacTypeView setFrame:oldFrame];
	[UIView commitAnimations];
	[self performSelector:@selector(removeAroundListView) withObject:nil afterDelay:0.5];
}

-(void)removeAroundListView{
	[self.aroundPacTypeView removeFromSuperview];
}

-(IBAction)touchNameAroundButton:(id)sender{
    //隐藏模态框
    [self dismissAround];
    [self dismissAroundPin];
    [self dismissRWP6];
	CGRect fellowFrame = aroundPacTypeView.frame;
	if (radiusListTable.hidden ==NO && radiusListTable!=nil) {
		radiusListTable.hidden = YES;
		[radiusListTable release];radiusListTable= nil;
		myAroundTableBottomView.hidden = YES;
		[myAroundTableBottomView release];myAroundTableBottomView=nil;
		[self disabledGestureView];
		return;
	}
	radiusListTable = [[UITableView alloc] initWithFrame:CGRectMake(2,2, 83, 34*3) style:UITableViewStylePlain];
	radiusListTable.tag = 110;
	radiusListTable.userInteractionEnabled = YES;
	radiusListTable.backgroundColor = [UIColor clearColor];
	radiusListTable.dataSource = self;
	radiusListTable.delegate = self;
	myAroundTableBottomView = [[UIImageView alloc] initWithFrame:CGRectMake(fellowFrame.origin.x+8, fellowFrame.origin.y+fellowFrame.size.height-15,85, 34*3+6)];
	myAroundTableBottomView.image = [UIImage imageNamed:@"typhoon_background.png"];
	myAroundTableBottomView.contentMode = UIViewContentModeScaleToFill;
	myAroundTableBottomView.userInteractionEnabled = YES;
	[myAroundTableBottomView addSubview:radiusListTable];
	[self.view addSubview:myAroundTableBottomView];
	[self enabledGestureView];
}

-(void)responseAroundWithType:(NSString *)type WithIndex:(NSString *)indexString;
{
    NSInteger myTypeInt = [type intValue];
    NSMutableArray *array = nil;
    switch (myTypeInt) {
        case 1:
            array = [aroundSKArray retain];
            break;
        case 2:
            array = [aroundSZArray retain];
            break;
        case 3:
            array = [aroundDZArray retain];
            break;
        case 4:
            array = [aroundHTArray retain];
            break;
        case 5:
            array = [aroundDFArray retain];
            break;
        case 6:
            array = [aroundBZArray retain];
            break;
    }
    
    //获取对象
    GPLNAnnotation *annotation = [array objectAtIndex:[indexString intValue]];
    //当前点位置
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([annotation.latitude doubleValue], [annotation.longtitude doubleValue]);
    //地图定位
    //扩大倍率
    float scaleRate = 0.5;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, [_selectedRadius doubleValue]*696.0/1024*2.5*scaleRate, [_selectedRadius doubleValue]*2.5*scaleRate);
    [_mapView setRegion:region animated:NO];
    MKCoordinateSpan span = region.span;
    //移动距离
    CLLocationDegrees moveRight = span.longitudeDelta * 1.2/3;
    CLLocationCoordinate2D finaCoord = CLLocationCoordinate2DMake(coord.latitude, coord.longitude - moveRight);
    [_mapView setCenterCoordinate:finaCoord];
    [_mapView selectAnnotation:annotation animated:YES];
    
    //保留后释放掉 
    [array autorelease];
    
}

-(void)dealWithAroundPacType:(OneAroundView *)myView convertProjectType:(NSInteger)typeInt;
{
	NSInteger temInt= (typeInt-140);
	[self preparePoverAround:temInt];
}

-(void)preparePoverAround:(NSInteger)myTypeInt{
	[self.sListPopoverController dismissPopoverAnimated:NO];
    
	if (myTypeInt!=oldrwp6Sig)
	{
		[self.aroundListPopoverController dismissPopoverAnimated:NO];
		self.aroundListPopoverController = nil;
		oldrwp6Sig = myTypeInt;
        //初始化
        NSMutableArray *array = nil;
		switch (myTypeInt) {
			case 1:
				array = aroundSKArray;
				break;
			case 2:
				array = aroundSZArray;
				break;
			case 3:
				array = aroundDZArray;
				break;
			case 4:
				array = aroundHTArray;
				break;
			case 5:
				array = aroundDFArray;
				break;
            case 6:
				array = aroundBZArray;
				break;
		}
        
        Around1Controller *aroundV = [[Around1Controller alloc] initWithNibName:@"Around1Controller" bundle:nil withArray:array];
        aroundV.typeNm = myTypeInt;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:aroundV];
        navController.delegate = self;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
		aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
		[aroundV release];
        [navController release];
		// Store the popover in a custom property for later use.
		self.aroundListPopoverController = aPopover;
		[aPopover release];
	}
    CGSize mySize = CGSizeMake(320-35, 350);
    [self.aroundListPopoverController setPopoverContentSize:mySize];
	
	CGRect oldFrame = [(UIButton *)[self.view viewWithTag:(myTypeInt+140)] bounds];
	//oldFrame.origin.x-=95;
	[self.aroundListPopoverController presentPopoverFromRect:oldFrame inView:(UIButton *)[self.view viewWithTag:(myTypeInt+140)] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


#pragma mark -
#pragma mark Satellite
//cache img
-(IBAction)downLoadSatelliteMapAndShow:(id)sender{
    noNeedMove = NO;
	[self disabledGestureView];
	[self dismissRWP6];
    [self dismissAroundPin];
	[self dismissHistoryTyphoon];

    [self addWaitting];
	[self performSelector:@selector(addSatelliteLayer:) withObject:nil afterDelay:0.1];
}

-(IBAction)addSatelliteLayer:(id)sender{
	[self.barCloudBtn setImage:[UIImage imageNamed:@"satellite_select.png"] forState:UIControlStateNormal];
	[self performSelectorOnMainThread:@selector(hideTyphoonListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];
	if (self.satelliteOverlay!=nil) {
		[self.mapView removeOverlay:self.satelliteOverlay];
		self.satelliteOverlay = nil;
	}
	
	//while the custom diabled the multiLayer
	if (self.multiLayer==NO) {
		[self removeAll];
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
    
    /*
     [{"cloudName":"201107080732.png","cloudUrl":"http://typhoon.zjwater.gov.cn/cloud","cloundTime":"2011-07-08 07:32","minLng":"90","maxLng":"178","minLat":"0","maxLat":"50"}]
    */
	/*
	 [ { "cloudName":"201012161030.png","minLng":"90","maxLng":"140","minLat":"0","maxLat":"35"} ]
	 */
	cloudDic = [NSDictionary dictionaryWithJSONString:myTotalCStr];
	NSString *newCloudName = [NSString stringWithFormat:@""];
	NSString *newMinLng = [NSString stringWithFormat:@""];
	NSString *newMinLat = [NSString stringWithFormat:@""];
	NSString *newMaxLng = [NSString stringWithFormat:@""];
	NSString *newMaxLat = [NSString stringWithFormat:@""];
    NSString *newcloudUrl = [NSString stringWithFormat:@""];
	if (cloudDic!=nil) {
		newCloudName = [cloudDic objectForKey:@"cloudName"];
		newMinLng = [cloudDic objectForKey:@"minLng"];
		newMinLat = [cloudDic objectForKey:@"minLat"];
		newMaxLng = [cloudDic objectForKey:@"maxLng"];
		newMaxLat = [cloudDic objectForKey:@"maxLat"];
        newcloudUrl = [cloudDic objectForKey:@"cloudUrl"];
	}
	
	FileManager *configB = [[FileManager alloc] init];
	NSString *localCloudNm = [NSString stringWithFormat:@"%@",[configB getValue:@"cacheCloudName"]];
	[configB release];
	
	if (newCloudName!=nil&&newMinLng!=nil&&newMinLat!=nil&&newMaxLng!=nil&&newMaxLat!=nil&&newcloudUrl!=nil&&[newCloudName isEqualToString:localCloudNm]==NO) {
		FileManager *config = [[FileManager alloc] init];
		[config writeConfigFile:@"cacheCloudName" ValueForKey:newCloudName];
		[config writeConfigFile:@"cacheMinLng" ValueForKey:newMinLng];
		[config writeConfigFile:@"cacheMinLat" ValueForKey:newMinLat];
		[config writeConfigFile:@"cacheMaxLng" ValueForKey:newMaxLng];
		[config writeConfigFile:@"cacheMaxLat" ValueForKey:newMaxLat];
        [config writeConfigFile:@"cacheCloundUrl" ValueForKey:newcloudUrl];
		[config release];
	} else if ([localCloudNm length]>6) {
		FileManager *config = [[FileManager alloc] init];
		newCloudName = localCloudNm;
		newMinLng = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMinLng"]];
		newMinLat = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMinLat"]];
		newMaxLng = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMaxLng"]];
		newMaxLat = [NSString stringWithFormat:@"%@",[config getValue:@"cacheMaxLat"]];
        newcloudUrl = [NSString stringWithFormat:@"%@",[config getValue:@"cacheCloundUrl"]];
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
        [self performSelectorOnMainThread:@selector(cacheImage:) withObject:(newCloudName) waitUntilDone:YES];
		[self.satelliteNameBtn setText:totolStr];
		[self addSatelliteView:array];
	} else {
		[self.satelliteNameBtn setText:[NSString stringWithFormat:@"无法获取,请点击图标重新检测"]];
	}
}

-(void)warningErrorFetchImage{
    [self.satelliteNameBtn setText:[NSString stringWithFormat:@"获取失败,请点击图标重新获取"]];
}


- (void)cacheImage: (NSString *)cCloudName
{
    FileManager *config = [[FileManager alloc] init];
    NSString *newcloudUrl = [NSString stringWithFormat:@"%@",[config getValue:@"cacheCloundUrl"]];
    [config release];
    
	NSString *ImageURLString = [NSString stringWithFormat:@"%@/%@",newcloudUrl,cCloudName];
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    // Generate a unique path to a resource representing the image you want
    NSString *filename = [NSString stringWithFormat:@"%@",cCloudName];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
	
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {		
        // The file doesn't exist, we should get a copy of it,Fetch image
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

#pragma mark -
#pragma mark HISTORY_TYPHOON_ARRAY
//获取历史台风信息和画图方法调用
-(void)dealWithHistoryTyphoonArray:(NSString *)tfid{
	historyTyphArray = [NSMutableArray array];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mTyphoon"]];
	[config release];
	NSString *convertV3 = [NSString stringWithFormat:@"%@",tfid];
	NSURL *strHisURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonHistoryTracks" Parameter:convertV3];
    
	historyTyphoonXMLParser *parseHis = [[historyTyphoonXMLParser alloc] init];
	[parseHis parseXMLFileAtURL:strHisURL parseError:nil];
	[parseHis release];
	[pool release];
	if (nil!=_hisrouteView) {
		[_hisrouteView removeFromSuperview];
		_hisrouteView = nil;
		[_hisrouteView release];
	}
	
	//while the custom diabled the multiLayer
	if (self.multiLayer==NO) {
		[self removeRain];
		[self removeWater];
		[self removeSatellite];
		[self removeProject];
		[self removeSearch];
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
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 49.837982;
    newRegion.center.longitude = 0.000000;
    newRegion.span.latitudeDelta = 139.213562;
    newRegion.span.longitudeDelta = 360.000000;
    [self.mapView setRegion:newRegion animated:NO];
}

-(void)westPacificMapRegion{	
	MKCoordinateRegion wpRegion = {{24.046465,133.154297},{54.132542,90.000000}};
	[self.mapView setRegion:wpRegion animated:YES];
}
-(IBAction)delayTest:(id)sender{	 
	[self addWaitting];
	[self performSelector:@selector(handleGesture:)];
	[self dismissRWP6];
    [self dismissAroundPin];
	[self dismissHistoryTyphoon];
	
	//Hide the  list box of search
	[self.sListPopoverController dismissPopoverAnimated:NO];
	//Remove the old view
	if (_routeView!= nil) {
		[_routeView removeFromSuperview];
		[_routeView release];
		_routeView = nil;
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
		_routeView = [[CSMapRouteLayerView alloc] initWithRoute:tyGroupHisArray forNewTyphoonArray:newTyphoonArray foreChina:tyGroupForeChinaArray foreHongKong:tyGroupForeHongKongArray foreTaiWan:tyGroupForeTaiWanArray foreAmerica:tyGroupForeAmericaArray foreJapan:tyGroupForeJapanArray mapView:_mapView withNoNeedMove:noNeedMove];
		//Show the typhoon listView
		[self performSelector:@selector(prepareShowTyphoonListView) withObject:nil afterDelay:0.001];
	}else {
		//if the sys check the typhoon for the first time ,in fact,there is nothing,we use the method of defaultmapregion or else we 'll use westpacificregion.
		if (isVirginCheckTy==YES) {
            //2012年07月03日修改————如果第一次加载没有台风，那就引入24小时降雨咯
            //先检测下有没有降雨
            [self inspectTwentyFourHourRainFall];
            if ([[self.twentyFourHourRainfallIdentitor lowercaseString] isEqualToString:@"true"]) {
                //有降雨那就是显示降雨
                [self performSelector:@selector(showRainListView:) withObject:nil];
            } else {
                //没有降雨还是同原来一样
                [self defaultMapRegion];
            }
			
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
    noNeedMove = YES;
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
        NSString *convertV3 = [NSString stringWithFormat:@"%@",infoHPath.tfID];
        NSURL *strHisURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonHistoryTracks" Parameter:convertV3];
		typhoonXMLParser *parseHis = [[typhoonXMLParser alloc] init];
		[parseHis parseXMLFileAtURL:strHisURL parseError:nil];
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
    
	for(int i=0;i<[newTyphoonArray count];i++){
        // Get Typhoon yubao Path List
        TFList *infoFPath= [newTyphoonArray objectAtIndex:i];
        NSString *convertV2 = [NSString stringWithFormat:@"%@",infoFPath.tfID];
        NSURL *strForeURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonForecastTracks" Parameter:convertV2];
		typhoonYBXMLParser *parseFore = [[typhoonYBXMLParser alloc] init];
		[parseFore parseXMLFileAtURL:strForeURL parseError:nil];
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

-(void)setLocationLon:(NSArray *)infoArr withType:(NSString *)moduleType{    
	//地图类型可以在这里手脚
	NSArray *myarray; 
//	if (myarray!=infoArr) {
//		myarray = [infoArr retain];
//	}
    
    myarray = [infoArr retain];
	
    //just compare no need to retain it
	NSString *mType = moduleType;
	NSString *clon;
	NSString *clat;
	NSString *cnm;
	NSString *cemmcd;
	NSString *titleData;
	NSString *subTitleData;
    
    NSString *subType; //RR
	searchLayer = NO;

	if ([mType isEqualToString:@"雨情"]) {
		[self initAllAnnoKey];
		self.rainAndWaterAnKey= YES;
		itsRAnno = YES;
		searchLayer = NO;
        
        clon = [myarray objectAtIndex:7];
		clat = [myarray objectAtIndex:8];
		cnm = [myarray objectAtIndex:1];
		cemmcd = [myarray objectAtIndex:0];
		titleData =[myarray objectAtIndex:3];
        
		subTitleData =  [NSString stringWithFormat:@"无"];
	} else if ([mType isEqualToString:@"水情"]) {
		[self initAllAnnoKey];
		self.rainAndWaterAnKey= YES;
		itsWAnno = YES;
		searchLayer = NO;
        subType = [[myarray objectAtIndex:2] isEqualToString:@"RR"]?@"水库站":@"另外";
		clon = [myarray objectAtIndex:10];
		clat = [myarray objectAtIndex:11];
		cnm = [myarray objectAtIndex:1];
		cemmcd = [myarray objectAtIndex:0];
		titleData = [myarray objectAtIndex:5];
		subTitleData = [myarray objectAtIndex:6];
	} else if ([mType isEqualToString:@"工情"]) {
		[self initAllAnnoKey];
		self.rainAndWaterAnKey= YES;
		itsPAnno = YES;
		searchLayer = NO;
		clon = [myarray objectAtIndex:0];
		clat = [myarray objectAtIndex:1];
		cnm = [NSString stringWithFormat:@"无"];
		cemmcd = [myarray objectAtIndex:5];//emmcd
		titleData = [myarray objectAtIndex:4];//name
		subTitleData = [myarray objectAtIndex:6];//engr
	} else if ([mType isEqualToString:@"搜雨情"]) {
		[self initAllAnnoKey];
		self.rainAndWaterAnKey= YES;
		itsSAnno = YES;
		searchLayer = YES;
		clon = [myarray objectAtIndex:0];
		clat = [myarray objectAtIndex:1];
		cnm = [myarray objectAtIndex:4];
		cemmcd =[ myarray objectAtIndex:5];//emmcd
		titleData = [myarray objectAtIndex:4];//name
		subTitleData = [NSString stringWithFormat:@"无"];
	} else if ([mType isEqualToString:@"搜水情"]) {
		[self initAllAnnoKey];
		self.rainAndWaterAnKey= YES;
		itsSAnno = YES;
		searchLayer = YES;
        subType = [[myarray objectAtIndex:6] isEqualToString:@"水库站"]?@"水库站":@"另外";
		clon = [myarray objectAtIndex:0];
		clat = [myarray objectAtIndex:1];
		cnm = [myarray objectAtIndex:4];
		cemmcd = [myarray objectAtIndex:5];//emmcd
		titleData = [myarray objectAtIndex:4];//name
		subTitleData = [NSString stringWithFormat:@"无"];
	} else if ([mType isEqualToString:@"搜工情"]) {
		[self initAllAnnoKey];
		self.rainAndWaterAnKey= YES;
		itsSAnno = YES;
		searchLayer = YES;
		clon = [myarray objectAtIndex:0];
		clat = [myarray objectAtIndex:1];
		cnm = [myarray objectAtIndex:4];
		cemmcd = [myarray objectAtIndex:5];//emmcd
		titleData = [myarray objectAtIndex:4];//name
		subTitleData = [myarray objectAtIndex:6];//engr
	}
    
	//dismiss popover
	[self.hisPinPopoverController dismissPopoverAnimated:NO];
	if (lannotation!=nil) {
		[self dismissRWP6]; ;
		[self.mapView removeAnnotation:lannotation];
	}
    
	MKCoordinateRegion current =  self.mapView.region;
    //这里只有水情用到subType
	NSArray *temArray;
    if ([mType isEqualToString:@"水情"] || [mType isEqualToString:@"搜水情"]) {
        temArray = [NSArray arrayWithObjects:clon,clat,cnm,cemmcd,mType,titleData,subTitleData,subType,nil];
    } else {
         temArray = [NSArray arrayWithObjects:clon,clat,cnm,cemmcd,mType,titleData,subTitleData,nil];
    }
	//alloc lannotation
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = [[temArray objectAtIndex:1] floatValue];
	coordinate.longitude =[[temArray objectAtIndex:0] floatValue];
	if (lannotation!=nil) {
		[lannotation release]; 
		lannotation = nil;
	}
    
	lannotation = [[LocationAnnotation alloc] initWithCoordinate:coordinate];
	lannotation.customPointName = [temArray objectAtIndex:2];
	lannotation.customPointData = [temArray objectAtIndex:3];
	lannotation.type = [temArray objectAtIndex:4];
	lannotation.titleData = [temArray objectAtIndex:5];
	lannotation.subtitleData = [temArray objectAtIndex:6];
    if (([mType isEqualToString:@"搜水情"]||[mType isEqualToString:@"水情"])&&[subType isEqualToString:@"水库站"]) {
        lannotation.subType = [temArray objectAtIndex:7];
    }
    
    if (current.span.latitudeDelta <8)// always here is 10
    {
        [self performSelector:@selector(animateToWorld:) withObject:temArray  afterDelay:0.3];
    }
    else
    {
        [self performSelector:@selector(animateToPlace:) withObject:temArray afterDelay:0.2];        
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
	UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 
	aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
	aPopover.delegate = self;
	[content release];
	[aPopover setPopoverContentSize:CGSizeMake(266, 347)];
	// Store the popover in a custom property for later use. 
	self.popoverController = aPopover; 
	[aPopover release];
	
	CGRect oldFrame = [(UIButton *)[self.view viewWithTag:[tfIDInfo.tfID intValue]] bounds]; 
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
	if (![self.popoverController.contentViewController isKindOfClass:[TyphoonNewRealPopover class]]) 
	{	
		self.popoverController = nil;
	}
	
	//judge there is no activity typhoon, the follow code(if{...}) will jump to the end of this method
	if ([newTyphoonArray count]==0) {
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
	[self addWaitting];
}
-(void)dealWithNonActiveTyphoon:(OneTyphoonView *)myView convertTfID:(NSInteger)myTfid andWithTYName:(NSString *)myTfName{
	[self dismissRealTyphoon];
	[self dismissHistoryTyphoon];
	
	NSInteger newTyphoonTag = myTfid;
	NSString *newTyphoonTagStr = [NSString stringWithFormat:@"%d",myTfid];
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
		MKCoordinateRegion pointRegion;
		pointRegion.center =nowShowAnnotation.coordinate;
		pointRegion.span.latitudeDelta = 30;
		pointRegion.span.longitudeDelta = 50;
		[self.mapView setRegion:pointRegion animated:YES];
		
		// Add the annotation of the activie typhoon		
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

-(void)dealLocationController:(LocationController *)myController withName:(NSString *)cname withPac:(NSString *)cpac{
	NSString *newName = [NSString stringWithFormat:@"%@",cname];
	NSString *newPac = [NSString stringWithFormat:@"%@",cpac];
	[self addWaitting];
	[self prepareProjectListArrayWithPac:newPac];
	[self.projectNameButton setTitle:newName forState:UIControlStateNormal] ;
}

-(void)dealLocationwithName:(NSString *)cname withPac:(NSString *)cpac withKey:(BOOL)ckey{
	oldrwp6Sig=0;
	NSString *newName = [NSString stringWithFormat:@"%@",cname];
	NSString *newPac = [NSString stringWithFormat:@"%@",cpac];
	[self addWaitting];
	[self performSelector:@selector(prepareProjectListArrayWithPac:) withObject:newPac afterDelay:0.00001];
	[self.projectNameButton setTitle:newName forState:UIControlStateNormal] ;
	if (ckey) {
		[lListPopoverController dismissPopoverAnimated:YES];
	}
}

#pragma mark -
#pragma mark UITableViewDelegate And UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger backthings = 0;
	if (tableView.tag==111) {
		backthings = [yearListArray count];
	} else if (tableView.tag==112) {
		backthings = [rainListArray count];
	} else if (tableView.tag==120) {
		backthings = [waterListArray count];
	} else if (tableView.tag==110) {
        backthings = [radiusArray count];
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
	} else if (tableView.tag==112) {
		NSString *cellTemyear = [rainListArray objectAtIndex:indexPath.row];
		NSString *cellTemyeara = [NSString stringWithFormat:@"%@小时",cellTemyear];
		NSString *CellIdentifier;
		if ([cellTemyeara isEqualToString:rainNameButton.titleLabel.text ]) {
			CellIdentifier = @"RainListCellIdentifierA";
		} else {
			CellIdentifier = @"RainListCellIdentifier";
		}
		cell = [rainListTable dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.textLabel.text = cellTemyeara;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		if ([cellTemyeara isEqualToString:rainNameButton.titleLabel.text]) {
			cell.textLabel.textColor = [UIColor blueColor];
		}
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	} else if (tableView.tag==120) {
		NSString *cellTemyear = [waterListArray objectAtIndex:indexPath.row];
		NSString *CellIdentifier;
		if ([cellTemyear isEqualToString:waterNameButton.titleLabel.text]) {
			CellIdentifier = @"WaterListCellIdentifierA";
		} else {
			CellIdentifier = @"WaterListCellIdentifier";
		}
		cell = [waterListTable dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.textLabel.text = cellTemyear;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:25.0f];
		if ([cellTemyear isEqualToString:waterNameButton.titleLabel.text]) {
			cell.textLabel.textColor = [UIColor blueColor];
		}
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}  else if (tableView.tag==110) {
		NSString *cellTemyear = [radiusArray objectAtIndex:indexPath.row];
		NSString *CellIdentifier;
		if ([cellTemyear isEqualToString:aroundNameButton.titleLabel.text]) {
			CellIdentifier = @"AroundListCellIdentifierA";
		} else {
			CellIdentifier = @"AroundListCellIdentifier";
		}
		cell = [radiusListTable dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
        NSString *aroundStr = [NSString stringWithFormat:@"%d公里",[cellTemyear intValue]/1000];
		cell.textLabel.text = aroundStr;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		if ([aroundStr isEqualToString:aroundNameButton.titleLabel.text]) {
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
	oldrwp6Sig=0;
	if (tableView.tag==111) {
        noNeedMove = YES;
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
	} else if (tableView.tag==112) {
        noNeedMove = YES;
		[self performSelectorOnMainThread:@selector(addWaitting) withObject:nil waitUntilDone:YES];
		if (rainListTable.hidden ==NO && rainListTable!=nil) {
			rainListTable.hidden = YES;
			myRainTableBottomVew.hidden = YES;
			[rainListTable release];rainListTable= nil;
		}	
		myRainTableBottomVew.hidden = YES;
		
		NSString *cellTemyear = [NSString stringWithFormat:@"%@小时",[rainListArray objectAtIndex:indexPath.row]];
		[rainNameButton setTitle:cellTemyear forState:UIControlStateNormal] ;
		
		//hide popover
		[self.rListPopoverController dismissPopoverAnimated:NO];

		//produce one year's tflist
		[self addWaitting];
		[self performSelector:@selector(dealWithRainMap:) withObject:cellTemyear afterDelay:0.000001];
		[self performSelector:@selector(produceRainPHListView) withObject:nil afterDelay:0.000002];
	} else if (tableView.tag==120) {
        noNeedMove = YES;
		if (waterListTable.hidden ==NO && waterListTable!=nil) {
			waterListTable.hidden = YES;
			myWaterTableBottomView.hidden = YES;
			[waterListTable release];waterListTable= nil;
		}	
		myWaterTableBottomView.hidden = YES;
		
		NSString *cellTemyear = [waterListArray objectAtIndex:indexPath.row];
		int waterSignal = 0;
		[waterNameButton setTitle:cellTemyear forState:UIControlStateNormal] ;
		if ([cellTemyear isEqualToString:@"超警(限)"]) {
			waterSignal = 1;
		} else {
			waterSignal = 0;
		}
		//hide popover
		[self.wListPopoverController dismissPopoverAnimated:NO];

		//produce one Status of Water
		[self addWaitting];
		[self performSelector:@selector(dealWithWaterMap:) withObject:cellTemyear afterDelay:0.000001];
		[self performSelector:@selector(produceWaterPacTypeView) withObject:nil afterDelay:0.000002];
	} else if (tableView.tag==110) {
		if (radiusListTable.hidden ==NO && radiusListTable!=nil) {
			radiusListTable.hidden = YES;
			myAroundTableBottomView.hidden = YES;
			[radiusListTable release];radiusListTable= nil;
		}
		myAroundTableBottomView.hidden = YES;
		
		NSString *cellTemyear = [radiusArray objectAtIndex:indexPath.row];
        NSString *aroundStr = [NSString stringWithFormat:@"%d公里",[cellTemyear intValue]/1000];
        self.selectedRadius = cellTemyear;
		[aroundNameButton setTitle:aroundStr forState:UIControlStateNormal];
		//hide popover
		[self.aroundListPopoverController dismissPopoverAnimated:NO];
        
		//produce one Status of Water
//		[self addWaitting];
//		[self performSelector:@selector(dealWithWaterMap:) withObject:cellTemyear afterDelay:0.000001];
//		[self performSelector:@selector(produceWaterPacTypeView) withObject:nil afterDelay:0.000002];
        //定位获取数据
        [self beginLocation];
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
	_RainrouteView.hidden = YES;
	_saterouteView.hidden =YES;
	_WaterrouteView.hidden = YES;
	if (self.RainrouteView.superview !=nil) {
		_zjBackgoundView.hidden = YES;
	}
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	// re-enable and re-poosition the route display. 
	if (self.RainrouteView.superview !=nil) {
		_zjBackgoundView.hidden = NO;
		[_zjBackgoundView setNeedsDisplay];
	}
	
	_routeView.hidden = NO;
	[_routeView setNeedsDisplay];
    
	_hisrouteView.hidden = NO;
	[_hisrouteView setNeedsDisplay];
	
	_sHisrouteView.hidden = NO;
	[_sHisrouteView setNeedsDisplay];
	
	_RainrouteView.hidden = NO;
	[_RainrouteView setNeedsDisplay];
	
	_saterouteView.hidden = NO;
	[_saterouteView setNeedsDisplay];
	
	_WaterrouteView.hidden = NO;
	[_WaterrouteView setNeedsDisplay];
}


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
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
	}  else if ([annotation isKindOfClass:[GPLNAnnotation class]]) {
        NSString *type = ((GPLNAnnotation *)annotation).entpnm;
        
        NSString *GPLAnnocationIdentifier = type;
        MKAnnotationView *pinView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:GPLAnnocationIdentifier];
        if (!pinView) {
            pinView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GPLAnnocationIdentifier] autorelease];
            
            pinView.opaque = NO;
            pinView.canShowCallout = YES;
			UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			[rightButton addTarget:self
							action:nil
				  forControlEvents:UIControlEventTouchUpInside];
			pinView.rightCalloutAccessoryView = rightButton;
            //choose image
            UIImage *showImage;
            if ([type isEqualToString:@"水库"]) {
                showImage = [UIImage imageNamed:@"SK1.png"];
            } else if ([type isEqualToString:@"水闸"]){
                showImage = [UIImage imageNamed:@"SZ2.png"];
            } else if ([type isEqualToString:@"水电站"]){
                showImage = [UIImage imageNamed:@"DZ6.png"];
            } else if ([type isEqualToString:@"海塘"]){
                showImage = [UIImage imageNamed:@"HT4.png"];
            } else if ([type isEqualToString:@"堤防"]){
                showImage = [UIImage imageNamed:@"DF5.png"];
            } else if ([type isEqualToString:@"泵站"]){
                showImage = [UIImage imageNamed:@"BZ3.png"];
            } else {
                showImage = [UIImage imageNamed:@"others.png"];
            }
            CGRect rect = CGRectMake(0, 0, 35, 35);
            UIGraphicsBeginImageContext(rect.size);
            [showImage drawInRect:rect];
            UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            pinView.image = resizedImage;
        } else {
            //choose image
            UIImage *showImage;
            if ([type isEqualToString:@"水库"]) {
                showImage = [UIImage imageNamed:@"SK1.png"];
            } else if ([type isEqualToString:@"水闸"]){
                showImage = [UIImage imageNamed:@"SZ2.png"];
            } else if ([type isEqualToString:@"水电站"]){
                showImage = [UIImage imageNamed:@"DZ6.png"];
            } else if ([type isEqualToString:@"海塘"]){
                showImage = [UIImage imageNamed:@"HT4.png"];
            } else if ([type isEqualToString:@"堤防"]){
                showImage = [UIImage imageNamed:@"DF5.png"];
            } else if ([type isEqualToString:@"泵站"]){
                showImage = [UIImage imageNamed:@"BZ3.png"];
            } else {
                showImage = [UIImage imageNamed:@"OTS.png"];
            }
            CGRect rect = CGRectMake(0, 0, 35, 35);
            UIGraphicsBeginImageContext(rect.size);
            [showImage drawInRect:rect];
            UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            pinView.image = resizedImage;
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
		aPopover.passthroughViews = [NSArray arrayWithObjects:self.yListShowView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barAroundBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,nil];

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
		aPopover.passthroughViews = [NSArray arrayWithObjects:self.sListPopoverController.contentViewController.view,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.barAroundBtn,self.refreshButton,nil];
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
	else if ([view.annotation isKindOfClass:[LocationAnnotation class]]&&([lannotation.type isEqualToString:@"雨情"]||[lannotation.type isEqualToString:@"搜雨情"])) 
	{	
		if(self.rwp6PinPopoverController !=nil){
//			[self.rwp6PinPopoverController release];
			self.rwp6PinPopoverController = nil;
		}
		[self.mapView deselectAnnotation:lannotation animated:YES];
		Rain2Controller* content = [[Rain2Controller alloc] initWithNibName:@"Rain2" bundle:nil withTitle:lannotation.customPointName withEmmcd:lannotation.customPointData withDist:lannotation.type];
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 
		
		if ([[self checkVisiblePopover] count]>0) {
			aPopover.passthroughViews = [self checkVisiblePopover];
		}
		
		aPopover.delegate = self;
		[content release];
		[aPopover setPopoverContentSize:CGSizeMake(320, 322)];
		// Store the popover in a custom property for later use. 
		self.rwp6PinPopoverController = aPopover;
        [aPopover release];
		CGPoint annotationPoint = [_mapView convertCoordinate:view.annotation.coordinate toPointToView:_mapView];
		float boxDY=annotationPoint.y;
		float boxDX=annotationPoint.x;
		CGRect box = CGRectMake(boxDX-9,boxDY-37,17,17);
    
		[self.rwp6PinPopoverController presentPopoverFromRect: box inView: _mapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	} else if ([view.annotation isKindOfClass:[LocationAnnotation class]]&&([lannotation.type isEqualToString:@"水情"]||[lannotation.type isEqualToString:@"搜水情"])) 
	{
        
		if(self.rwp6PinPopoverController !=nil){
//			[self.rwp6PinPopoverController release];
			self.rwp6PinPopoverController = nil;
		}
		[self.mapView deselectAnnotation:lannotation animated:YES];
        FlowLeftViewController* content = [[FlowLeftViewController alloc] initWithNibName:@"FlowLeftViewController" bundle:nil withPointC:lannotation.customPointData];
        content.pointType = lannotation.subType;
        if ([lannotation.type isEqualToString:@"水情"]) {
            NSArray *temArr = [lannotation.title componentsSeparatedByString:@":"];
            if ([temArr count]==2) {
                content.pointNM = [temArr objectAtIndex:0];
            } else {
                content.pointNM = @"获取站名出错";
            }
        } else {
            content.pointNM = lannotation.title;
        }
        
        UINavigationController *waterNav = [[UINavigationController alloc] initWithRootViewController:content];
        waterNav.navigationBar.hidden = YES;
        waterNav.delegate = self;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:waterNav];
		if ([[self checkVisiblePopover] count]>0) {
			aPopover.passthroughViews = [self checkVisiblePopover];
		}
		
		aPopover.delegate = self;
		[content release];
        [waterNav release];
		[aPopover setPopoverContentSize:CGSizeMake(480, 290)];
		// Store the popover in a custom property for later use. 
		self.rwp6PinPopoverController = aPopover;
        [aPopover release];
		CGPoint annotationPoint = [_mapView convertCoordinate:view.annotation.coordinate toPointToView:_mapView];
		float boxDY=annotationPoint.y;
		float boxDX=annotationPoint.x;
		CGRect box = CGRectMake(boxDX-9,boxDY-37,17,17);
		[self.rwp6PinPopoverController presentPopoverFromRect: box inView: _mapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
	}  else if ([view.annotation isKindOfClass:[LocationAnnotation class]]&&([lannotation.type isEqualToString:@"工情"]||[lannotation.type isEqualToString:@"搜工情"])) 
	{	
		if(self.rwp6PinPopoverController !=nil){
//			[self.rwp6PinPopoverController release];
			self.rwp6PinPopoverController = nil;
		}
		[self.mapView deselectAnnotation:lannotation animated:YES];
		Work3Controller* content = [[Work3Controller alloc] initWithNibName:@"Work3" bundle:nil];
		content.myEnnmcd = lannotation.customPointData;
		content.myEnnm = lannotation.titleData;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content];
		if ([[self checkVisiblePopover] count]>0) {
			aPopover.passthroughViews = [self checkVisiblePopover];
		}
		
		aPopover.delegate = self;
		[content release];
		[aPopover setPopoverContentSize:CGSizeMake(320-44, 347)];
		// Store the popover in a custom property for later use. 
		self.rwp6PinPopoverController = aPopover;
        [aPopover release];
		CGPoint annotationPoint = [_mapView convertCoordinate:view.annotation.coordinate toPointToView:_mapView];
		float boxDY=annotationPoint.y;
		float boxDX=annotationPoint.x;
		CGRect box = CGRectMake(boxDX-9,boxDY-37,17,17);
		[self.rwp6PinPopoverController presentPopoverFromRect: box inView: _mapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}   else if ([view.annotation isKindOfClass:[GPLNAnnotation class]])
	{
		if(self.aroundPinPopoverController !=nil){
//			[self.aroundPinPopoverController release];
			self.aroundPinPopoverController = nil;
		}
        GPLNAnnotation *temAnnotation = (GPLNAnnotation *)view.annotation;
		[self.mapView deselectAnnotation:temAnnotation animated:YES];
		Work3Controller* content = [[Work3Controller alloc] initWithNibName:@"Work3" bundle:nil];
		content.myEnnmcd = temAnnotation.ennmcd;
		content.myEnnm = temAnnotation.ennm;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content];
		if ([[self checkVisiblePopover] count]>0) {
			aPopover.passthroughViews = [self checkVisiblePopover];
		}
		
		aPopover.delegate = self;
		[content release];
		[aPopover setPopoverContentSize:CGSizeMake(320-44, 347)];
		// Store the popover in a custom property for later use.
		self.aroundPinPopoverController = aPopover;
        [aPopover release];
		CGPoint annotationPoint = [_mapView convertCoordinate:view.annotation.coordinate toPointToView:_mapView];
		float boxDY=annotationPoint.y;
		float boxDX=annotationPoint.x;
		CGRect box = CGRectMake(boxDX-17,boxDY-17,35,35);
		[self.aroundPinPopoverController presentPopoverFromRect: box inView: _mapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
		if ([overlay.title isEqualToString:@"浙江"] ) 
        {
            aView.fillColor = [UIColor colorWithRed:84.0/255 green:84.0/255  blue:84.0/255  alpha:0.2];
            aView.strokeColor = [UIColor colorWithRed:84.0/255  green:84.0/255  blue:84.0/255  alpha:0.2];
            aView.lineWidth = 3;
        } else if ([overlay.title isEqualToString:@"菲律宾"] ){
            aView.fillColor = [UIColor colorWithRed:165.0/255 green:191.0/255  blue:221.0/255  alpha:1.0];
            aView.strokeColor = [UIColor clearColor];
        }
        return aView;
    } else if ([overlay isKindOfClass:[SatelliteOverlay class]]) {
		SatelliteOverlayView *view = [[SatelliteOverlayView alloc] initWithOverlay:overlay];
		return [view autorelease];
	}
	
    return nil;
}

-(void)delayShowCallOutView{
	if (lannotation!=nil&&self.rainAndWaterAnKey==YES) {
		[self.mapView selectAnnotation:lannotation animated:YES];
	}
	
	if (histannotation!=nil&&self.hisTyphoonKey==YES) {
		[self.mapView selectAnnotation:histannotation animated:YES];
	}
		
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
	if ([viewController isKindOfClass:[Rain1Controller class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(285, 412);
	}else if ([viewController isKindOfClass:[Rain2Controller class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(320, 454);
	}else if ([viewController isKindOfClass:[Water1Controller class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(320, 412);
	}else if ([viewController isKindOfClass:[WaterInfoController class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(320, 412);
    }else if ([viewController isKindOfClass:[FlowLeftViewController class]]) {
		self.rwp6PinPopoverController.popoverContentSize =CGSizeMake(480, 290);
	}else if ([viewController isKindOfClass:[SpeakSearchViewController class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(320, 368);
	}else if ([viewController isKindOfClass:[RainSDInfoController class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(320, 412);
	}else if ([viewController isKindOfClass:[TyphoonSListPopovers class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(266, 412);
	}else if ([viewController isKindOfClass:[Work1Controller class]]) {
		self.pListPopoverController.popoverContentSize =CGSizeMake(320-35,330-44);
	}else if ([viewController isKindOfClass:[Work2Controller class]]) {
		self.pListPopoverController.popoverContentSize =CGSizeMake(320-35,412);
	}else if ([viewController isKindOfClass:[Work3Controller class]]) {
		self.rwp6PinPopoverController.popoverContentSize =CGSizeMake(320-44,347);
	}else if ([viewController isKindOfClass:[LocationController class]]) {
		self.popoverController.popoverContentSize =CGSizeMake(320,337+40);
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

	if (nil !=self.RainrouteView.superview||itsRAnno == YES) {
		self.rainLayer = YES;
	} else {
		self.rainLayer = NO;
	}
	if (nil !=self.WaterrouteView.superview||itsWAnno == YES) {
		self.waterLayer = YES;
	} else {
		self.waterLayer = NO;
	}
	if (itsPAnno == YES) {
		self.projectLayer = YES;
	} else {
		self.projectLayer = NO;
	}
    //aroundLayer 就无需判断
	if (self.satelliteOverlay!=nil) {
		self.satelliteLayer = YES;
	} else {
		self.satelliteLayer = NO;
	}
	
	ControlCascade * content = [[ControlCascade alloc] initWithNibName:@"ControlCascade" bundle:nil multiInfo:self.multiLayer typhoonInfo:self.typhoonLayer rainInfo:self.rainLayer waterInfo:self.waterLayer projectInfo:self.projectLayer satelliteInfo:self.satelliteLayer aroundInfo:self.aroundLayer searchInfo: self.sTyphoonLayer mapType:self.mapTypeInt];
	content.delegate = self;
	UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:content]; 
	aPopover.delegate = self;
	[content release];
	if (self.multiLayer) {
		[aPopover setPopoverContentSize:CGSizeMake(260, 550+70)];
	} else {
		[aPopover setPopoverContentSize:CGSizeMake(260, 300+20)];
	}
	
	// Store the popover in a custom property for later use. 
	self.cListPopoverController = aPopover; 
	[aPopover release];
	
	CGRect oldFrame = [(UIButton *)sender frame];;
	
	[self.cListPopoverController presentPopoverFromRect:oldFrame inView: self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}

-(void)dealWithCascade:(ControlCascade *)myView removeName:(NSString *)cascadeStr{
	if ([cascadeStr isEqualToString:@"台风"]) {
		[self removeTyphoon];
	} else if ([cascadeStr isEqualToString:@"雨情"]) {
		[self removeRain];
        //2012年7月2日修改
        [self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
	} else if ([cascadeStr isEqualToString:@"水情"]) {
		[self removeWater];
        //2012年7月2日修改
        [self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
	} else if ([cascadeStr isEqualToString:@"云图"]) {
		[self removeSatellite];
        return;
	} else if ([cascadeStr isEqualToString:@"周边"]) {
		[self removeAround];
        //2013年3月14日修改
        [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];
	}else if ([cascadeStr isEqualToString:@"搜索"]) {
		[self removeSearch];
	} else if ([cascadeStr isEqualToString:@"工情"]) {
		[self removeProject];
        //2012年7月2日修改
        [self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
	} else if ([cascadeStr isEqualToString:@"全部"]) {
		[self removeAll];
        //2012年7月2日修改
        [self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];
	} else if ([cascadeStr isEqualToString:@"标准"]) {
		self.mapTypeInt = 0;
		self.mapView.mapType = MKMapTypeStandard;
        return;
	} else if ([cascadeStr isEqualToString:@"卫星"]) {
		self.mapTypeInt = 1;
		self.mapView.mapType = MKMapTypeSatellite;
        return;
	} else if ([cascadeStr isEqualToString:@"混合"]) {
		self.mapTypeInt =2;
		self.mapView.mapType = MKMapTypeHybrid;
        return;
	} else if ([cascadeStr isEqualToString:@"多层叠加"]) {
		self.multiLayer = YES;
	} else if ([cascadeStr isEqualToString:@"关闭"]) {
		self.multiLayer = NO;
		[self removeAll];
        //2012年7月2日修改
        [self performSelectorOnMainThread:@selector(hideRainListView:) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(hideWaterListView:) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(hideProjectListView:) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(hideAroundListView:) withObject:nil waitUntilDone:YES];

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

-(void)removeRain{
	self.rainLayer = NO;
	[self dismissRWP6];
	if (nil!=_RainrouteView.superview) {
		[_RainrouteView removeFromSuperview];
		_RainrouteView = nil;
		[_RainrouteView release];
		
		if (self.zjPolyLayer==YES) {
			[self.mapView removeOverlay:_zjPoly];
            _zjPoly = nil;
			self.zjPolyLayer =NO;
		}
	}
	if (itsRAnno == YES) {
		self.itsRAnno =NO;
		if (self.lannotation!=nil) {
			[self.mapView removeAnnotation:lannotation];
			self.lannotation = nil;
		}
	}
}

-(void)removeWater{
	[self dismissRWP6];
	self.waterLayer = NO;
	if (nil!=_WaterrouteView.superview) {
		[_WaterrouteView removeFromSuperview];
		[_WaterrouteView release];
		_WaterrouteView = nil;
	}
	if (itsWAnno == YES) {
		self.itsWAnno = NO;
		if (self.lannotation!=nil) {
			[self.mapView removeAnnotation:lannotation];
			self.lannotation = nil;
		}
	}
}

-(void)removeProject{
	[self dismissRWP6];
	self.projectLayer = NO;
	if (itsPAnno == YES) {
		self.itsPAnno = NO;
		if (self.lannotation!=nil) {
			[self.mapView removeAnnotation:lannotation];
			self.lannotation = nil;
		}
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

-(void)removeAround {
    //如果清除地图头针，关闭
    _mapView.showsUserLocation = NO;
    [self dismissAroundPin];
    //标识置为NO
	self.aroundLayer = NO;
    //从地图上清除所有周边大头针
    [_mapView removeAnnotations:aroundSZArray];
    [_mapView removeAnnotations:aroundDFArray];
    [_mapView removeAnnotations:aroundBZArray];
    [_mapView removeAnnotations:aroundHTArray];
    [_mapView removeAnnotations:aroundDZArray];
    [_mapView removeAnnotations:aroundSKArray];
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
	[self removeRain];
	[self removeWater];
	[self removeProject];
	[self removeSatellite];
    [self removeAround];
	[self removeSearch];
}

-(void)initAllAnnoKey{
	itsRAnno = NO;
	itsWAnno = NO;
	itsPAnno = NO;
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
	[self.rListPopoverController dismissPopoverAnimated:NO];
	[self.wListPopoverController dismissPopoverAnimated:NO];
	[self.pListPopoverController dismissPopoverAnimated:NO];
	[self dismissRWP6];
    [self dismissAroundPin];
    [self dismissAround];
	[self dismissHistoryTyphoon];
	[self dismissRealTyphoon];
	[self performSelector:@selector(handleGesture:)];
	[self disabledGestureView];
	if (oldSearchSig !=9618) 
	{	
		oldSearchSig = 9618;
		self.sListPopoverController = nil;
		SpeakSearchViewController* content = [[SpeakSearchViewController alloc] initWithNibName:@"Search" bundle:nil];
		CGSize mySize = CGSizeMake(320, 368);
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:content];
		navController.delegate = self;
		UIPopoverController* aPopover = [[UIPopoverController alloc] initWithContentViewController:navController]; 
		aPopover.passthroughViews = [NSArray arrayWithObjects:self.view,nil];
		[content release];
		[aPopover setPopoverContentSize:mySize];
		// Store the popover in a custom property for later use. 
		self.sListPopoverController = aPopover; 
		[aPopover release];
	}

	[self.sListPopoverController presentPopoverFromRect:[(UIButton *)[self.view viewWithTag:8888] bounds] inView:(UIButton *)[self.view viewWithTag:8888] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)receviceSearchTyphoonArrayAndDrawIt:(NSMutableArray *)myArray WithName:(NSString *)tfnm WithID:(NSString *)tyid{
	[self dismissRWP6];
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
		[self showAlertViewHasDrawed:tfnm];
	}else if(isEqualToActivityOne == YES&&isHadDrawedOne == NO) {
		//show alertview that the typhoon is the one activity typhoon
		[self showAlertViewIsActivity:tfnm];
	}

}

-(void)showAlertViewIsActivity:(NSString *)temStr{
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

- (void)sAnimateToWorld:(NSArray *)jwArray
{    
    MKCoordinateRegion current = self.mapView.region;
    MKCoordinateRegion zoomOut = { { (current.center.latitude + [[jwArray objectAtIndex:1] floatValue]*(1+0.05))/2.0 , (current.center.longitude + [[jwArray objectAtIndex:0] floatValue])*(1+0.05)/2.0 }, {5.,5} };   
	[ self.mapView setRegion:zoomOut animated:YES];
}

- (void)sAnimateToPlace:(NSArray *)jwArray
{
    MKCoordinateRegion region;
    region.center.longitude =[[jwArray objectAtIndex:0] floatValue]*1.0004;
	region.center.latitude  = [[jwArray objectAtIndex:1] floatValue];
    MKCoordinateSpan span = {0.060024,0.102545};
    region.span = span;
    [ self.mapView setRegion:region animated:YES];
	
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = [[jwArray objectAtIndex:1] floatValue];
	coordinate.longitude =[[jwArray objectAtIndex:0] floatValue];
	if (sLannotation!=nil) {
		[self.mapView removeAnnotation:sLannotation];
		[sLannotation release]; sLannotation = nil;
	}
	
	sLannotation = [[SLocationAnnotation alloc] initWithCoordinate:coordinate];
	self.sRainAndWaterAnKey= YES;
	sLannotation.customPointName = [jwArray objectAtIndex:2];
	sLannotation.customPointData = [jwArray objectAtIndex:3];
	sLannotation.type = [jwArray objectAtIndex:4];
	[self performSelector:@selector(delaySAddAnnotionToAnimate) withObject:nil afterDelay:0.1];
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
	self.rainAndWaterAnKey = NO;
	self.hisTyphoonKey = NO;
	self.actTyphoonKey =NO;
	self.sRainAndWaterAnKey =NO;
	self.sHisTyphoonKey =NO;
}

#pragma mark Check if UIPopoverController is visible ||  DisissPopover
-(NSArray *)checkVisiblePopover{
	NSArray *temArray;
	if (self.yListShowView.superview!=nil&&self.sListPopoverController.popoverVisible==NO) {
		temArray = [NSArray arrayWithObjects:self.yListShowView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,nil];
	} else if (self.yListShowView.superview!=nil&&self.sListPopoverController.popoverVisible==YES) {
		temArray = [NSArray arrayWithObjects:self.yListShowView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.sListPopoverController.contentViewController.view,nil];
	} else if (self.rainPacHourView.superview!=nil&&self.sListPopoverController.popoverVisible==NO) {
		temArray = [NSArray arrayWithObjects:self.rainPacHourView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.rListPopoverController.contentViewController.view,nil];
	} else if (self.rainPacHourView!=nil&&self.sListPopoverController.popoverVisible==YES) {
		temArray = [NSArray arrayWithObjects:self.rainPacHourView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.sListPopoverController.contentViewController.view,nil];
	} else if (self.waterPacTypeView.superview!=nil&&self.sListPopoverController.popoverVisible==NO) {
		temArray = [NSArray arrayWithObjects:self.waterPacTypeView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.wListPopoverController.contentViewController.view,nil];
	} else if (self.waterPacTypeView!=nil&&self.sListPopoverController.popoverVisible==YES) {
		temArray = [NSArray arrayWithObjects:self.waterPacTypeView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.sListPopoverController.contentViewController.view,nil];
	} else if (self.projectPacTypeView!=nil&&self.sListPopoverController.popoverVisible==NO) {
		temArray = [NSArray arrayWithObjects:self.projectPacTypeView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.pListPopoverController.contentViewController.view,nil];
	} else if (self.projectPacTypeView!=nil&&self.sListPopoverController.popoverVisible==YES) {
		temArray = [NSArray arrayWithObjects:self.projectPacTypeView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.sListPopoverController.contentViewController.view,nil];
	} else if (self.aroundPacTypeView!=nil&&self.sListPopoverController.popoverVisible==NO) {
		temArray = [NSArray arrayWithObjects:self.aroundPacTypeView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.aroundListPopoverController.contentViewController.view,nil];
	} else if (self.aroundPacTypeView!=nil&&self.sListPopoverController.popoverVisible==YES) {
		temArray = [NSArray arrayWithObjects:self.aroundPacTypeView,self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.sListPopoverController.contentViewController.view,nil];
	} else if (self.sListPopoverController.popoverVisible==YES) {
		temArray = [NSArray arrayWithObjects:self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.refreshButton,self.barAroundBtn,self.sListPopoverController.contentViewController.view,nil];
	} else {
		temArray = [NSArray arrayWithObjects:self.barCloudBtn,self.barProjectBtn,self.barRainBtn,self.barSearchBtn,self.barTrashBtn,self.barTyphoonBtn,self.barWaterBtn,self.barAroundBtn,self.refreshButton,self.barAroundBtn,nil];
	}
	return temArray;
}

-(void)dismissRealTyphoon{
	[self.popoverController dismissPopoverAnimated:NO];
}

-(void)dismissHistoryTyphoon{
	[self.hisPinPopoverController dismissPopoverAnimated:NO];
	[self.sHisPinPopoverController dismissPopoverAnimated:NO];
}
-(void)dismissRain{
	[self.rListPopoverController dismissPopoverAnimated:NO];
}
-(void)dismissWater{
	[self.wListPopoverController dismissPopoverAnimated:NO];
}
-(void)dismissProject{
	[self.pListPopoverController dismissPopoverAnimated:NO];
}
-(void)dismissAround{
	[self.aroundListPopoverController dismissPopoverAnimated:NO];
}
-(void)dismissAroundPin{
    [self.aroundPinPopoverController dismissPopoverAnimated:NO];
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
	[self.rwp6PinPopoverController dismissPopoverAnimated:NO];
	[self.hisPinPopoverController  dismissPopoverAnimated:NO];
}
@end
