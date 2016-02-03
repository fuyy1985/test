//
//  smellycatViewController.h
//  smellycat
//
//  Created by apple on 10-10-30.
//  Copyright zjdayu 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OneTyphoonView.h"
#import "CSMapRouteLayerView.h"
#import "CSHisMapRouteLayerView.h"
#import <QuartzCore/QuartzCore.h>
#import "OneRainView.h"
#import "OneWaterView.h"
#import "OneProjectView.h"
#import "CSRainMapRouteLayerView.h"
#import "CSSatlliteRouterLayer.h"
#import "SatelliteOverlay.h"
#import "CSWaterMapRouteLayerView.h"
#import "CSZJRouterLayer.h"
#import "Rain1Controller.h"
#import "LocationAnnotation.h"
#import "HisTypAnnotation.h"
#import "NowTypAnnotation.h"
#import "SLocationAnnotation.h"
#import "SHisTypAnnotation.h"
#import "NSDictionary+BSJSONAdditions.h"
#import "ControlCascade.h"
#import "LocationController.h"
#import "OneAroundView.h"


#define RADIUS_A @"2000"
#define RADIUS_B @"5000"
#define RADIUS_C @"10000"

@class TFList;
@class TFPathInfo;
@class TFYBList;
@class RainPacHourInfo;
@class WaterPacTypeInfo;
@interface smellycatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate,OneTyphoonViewDelegate,UIPopoverControllerDelegate,OneRainViewDelegate,OneWaterViewDelegate,OneProjectViewDelegate,UINavigationControllerDelegate,ControlCascadeDelegate,LocationControllerDelegate,OneAroundViewDelegate> {
	//IBOutlet
	UIView *loginView;
	UIButton *barTyphoonBtn;
	UIButton *barRainBtn;
	UIButton *barWaterBtn;
	UIButton *barProjectBtn;
	UIButton *barCloudBtn;
    UIButton *barAroundBtn;
	UIButton *barSearchBtn;
	UIButton *barTrashBtn;
	UIButton *yearNameButton;
	UIButton *rainNameButton;
	UIButton *refreshButton;
	UIView *yListShowView;
	UIImageView *myYListLeftSig;
	UIImageView *myYListRightSig;
	UIImageView *hideTImgView;
	UIButton *hideTBtn;
	UIImageView *outTFrameImgView;
	UIScrollView *myTyphScroll;
	UIButton *hornButton;
	MKMapView *_mapView;
	UIView *rainPacHourView;
	UIImageView *outFrameImgView;
	UIImageView *hideImgView;
	UIButton *hideBtn;
	UIView *waterPacTypeView;
	UIButton *waterNameButton;
	UIImageView *outWFrameImgView;
	UIImageView *hideWImgView;
	UIButton *hideWBtn;
	UIView *satelliteTimeView;
	UILabel *satelliteNameBtn;
	UIView *wattingView;
	UIView *typhoonScrl;
	UIView *projectPacTypeView;
	UIButton *projectNameButton;
	UIImageView *outPFrameImgView;
	UIImageView *hidePImgView;
	UIButton *hidePBtn;
    
    UIView *aroundPacTypeView;
	UIButton *aroundNameButton;
	UIImageView *outAFrameImgView;
	UIImageView *hideAImgView;
	UIButton *hideABtn;
	
	//Others
	UIView *gestureView;
	NSMutableArray *oneYearTyphList;
	NSInteger calibrateYear;
	UITableView *yearListTable;
	UIImageView *myYLTableBottomVew;
	NSMutableArray *yearListArray;
	NSInteger minusType;
	UITableView *rainListTable; //rainTable
	UIImageView *myRainTableBottomVew;
    NSString *myTotalRStr;
    NSString *_twentyFourHourRainfallIdentitor;//判断是否有24小时降雨
	NSMutableArray *rainListArray;
	NSMutableArray *rainPointArray;
	NSMutableArray *rainArrBig6;
	NSMutableArray *rainArrBig5;
	NSMutableArray *rainArrBig4;
	NSMutableArray *rainArrBig3;
	NSMutableArray *rainArrBig2;
	NSMutableArray *rainArrBig1;
	UITableView *waterListTable;//waterTable
    NSString *myTotalWStr;
	NSMutableArray *waterPointArray;
	UIImageView *myWaterTableBottomView;
	NSMutableArray *waterListArray;
	NSMutableArray *waterArrRiv;
	NSMutableArray *waterArrRev;
	NSMutableArray *waterArrGat;
	NSMutableArray *waterArrTid;
    NSMutableArray *projectGroupArray;//project
	NSMutableArray *newTyphoonArray;
	NSInteger oldTyphoonTag;
	CSMapRouteLayerView * _routeView;
	CSHisMapRouteLayerView *_hisrouteView;
	CSHisMapRouteLayerView *_sHisrouteView;
	CSRainMapRouteLayerView *_RainrouteView;
	CSSatlliteRouterLayer *_saterouteView;
	CSWaterMapRouteLayerView *_WaterrouteView;
	CSZJRouterLayer *_zjBackgoundView;
	MKPolygon *_zjPoly;
    //2012年7月2日修改
    MKPolygon *_philippinesOceanLayer;
	SatelliteOverlay *satelliteOverlay;
    NSString *myTotalCStr;
	UIWebView *web;
	NSMutableArray *tyGroupHisArray;
	NSMutableArray *tyHisArray;
	NSMutableArray *tyGroupForeChinaArray;
	NSMutableArray *tyForeChinaArray;
	NSMutableArray *tyGroupForeHongKongArray;
	NSMutableArray *tyForeHongKongArray;
	NSMutableArray *tyGroupForeTaiWanArray;
	NSMutableArray *tyForeTaiWanArray;
	NSMutableArray *tyGroupForeAmericaArray;
	NSMutableArray *tyForeAmericaArray;
	NSMutableArray *tyGroupForeJapanArray;
	NSMutableArray *tyForeJapanArray;
	NSMutableArray *historyTyphArray;	
	UIPopoverController *popoverController;
	UIPopoverController *rListPopoverController;
	UIPopoverController *wListPopoverController;
	UIPopoverController *lListPopoverController;
	UIPopoverController *pListPopoverController;
	UIPopoverController *sListPopoverController;
	UIPopoverController *cListPopoverController;
	UIPopoverController *hisPinPopoverController;
	UIPopoverController *sHisPinPopoverController;
	UIPopoverController *rwp6PinPopoverController;
	NSInteger oldrwp6Sig;
	NSInteger oldSearchSig;
	NSMutableArray *popverTyphArray;
	NSMutableArray *popversTyphArray;
	LocationAnnotation *lannotation;
	HisTypAnnotation *histannotation;
	NowTypAnnotation *nowShowAnnotation;
	SLocationAnnotation *sLannotation;
	SHisTypAnnotation *sHistannotation;
	NSDictionary *cloudDic;
	NSMutableArray *newTypAnnotationsArr;
	BOOL multiLayer;// about clear layer
	BOOL typhoonLayer;
	BOOL rainLayer;
	BOOL zjPolyLayer;
	BOOL waterLayer;
	BOOL projectLayer;
    BOOL aroundLayer;
	BOOL satelliteLayer;
	BOOL searchLayer;
	BOOL sTyphoonLayer;
	BOOL itsRAnno;
	BOOL itsWAnno;
	BOOL itsPAnno;
	BOOL itsSAnno;
	BOOL isVirginCheckTy;// first check typhoon;
	NSInteger mapTypeInt;
	BOOL rainAndWaterAnKey; //about show callout
	BOOL hisTyphoonKey;
	BOOL actTyphoonKey;
	BOOL sRainAndWaterAnKey;
	BOOL sHisTyphoonKey;
	BOOL you;
    
    //2013年1月30日修改
    NSMutableArray *aroundSZArray;
    NSMutableArray *aroundDFArray;
    NSMutableArray *aroundBZArray;
    NSMutableArray *aroundHTArray;
    NSMutableArray *aroundDZArray;
    NSMutableArray *aroundSKArray;
    UIPopoverController *aroundListPopoverController;
    UIPopoverController *aroundPinPopoverController;
    CLLocationCoordinate2D _coord;
    CLLocationManager *_locationManager;
    NSString *_selectedRadius;
    NSMutableArray *_sectionObjets;
    NSArray *_typeArray;
    UITableView *radiusListTable;
    NSArray *radiusArray;
    UIImageView *myAroundTableBottomView;
    
    //2013年10月23日修改
    BOOL noNeedMove;
    BOOL isNewVersion;
    UIButton *updateBtn;
    UIView *updateView;
    UIWebView *updateWebView;
}
//IBOutlet
@property (nonatomic,retain) IBOutlet UIView *loginView;
@property (nonatomic,retain) IBOutlet UIButton *barTyphoonBtn;
@property (nonatomic,retain) IBOutlet UIButton *barRainBtn;
@property (nonatomic,retain) IBOutlet UIButton *barWaterBtn;
@property (nonatomic,retain) IBOutlet UIButton *barProjectBtn;
@property (nonatomic,retain) IBOutlet UIButton *barCloudBtn;
@property (nonatomic,retain) IBOutlet UIButton *barAroundBtn;
@property (nonatomic,retain) IBOutlet UIButton *barSearchBtn;
@property (nonatomic,retain) IBOutlet UIButton *barTrashBtn;
@property (nonatomic,retain) IBOutlet UIButton *yearNameButton;
@property (nonatomic,retain) IBOutlet UIButton *rainNameButton;
@property (nonatomic,retain) IBOutlet UIButton *refreshButton;
@property (nonatomic,retain) IBOutlet UIView *yListShowView;
@property (nonatomic,retain) IBOutlet UIImageView *hideTImgView;
@property (nonatomic,retain) IBOutlet UIButton *hideTBtn;
@property (nonatomic,retain) IBOutlet UIImageView *outTFrameImgView;
@property (nonatomic,retain) UIScrollView *myTyphScroll;
@property (nonatomic,retain) IBOutlet UIButton *hornButton;
@property (nonatomic,retain) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) IBOutlet UIImageView *myYListLeftSig;
@property (nonatomic,retain) IBOutlet UIImageView *myYListRightSig;
@property (nonatomic,retain) IBOutlet UIView *rainPacHourView;
@property (nonatomic,retain) IBOutlet UIImageView *outFrameImgView;
@property (nonatomic,retain) IBOutlet UIImageView *hideImgView;
@property (nonatomic,retain) IBOutlet UIButton *hideBtn;
@property (nonatomic,retain) IBOutlet UIView *waterPacTypeView;
@property (nonatomic,retain) IBOutlet UIButton *waterNameButton;
@property (nonatomic,retain) IBOutlet UIImageView *outWFrameImgView;
@property (nonatomic,retain) IBOutlet UIImageView *hideWImgView;
@property (nonatomic,retain) IBOutlet UIButton *hideWBtn;
@property (nonatomic,retain) IBOutlet UIView *satelliteTimeView;
@property (nonatomic,retain) IBOutlet UILabel *satelliteNameBtn;
@property (nonatomic,retain) IBOutlet UIView *wattingView;
@property (nonatomic,retain) IBOutlet UIView *typhoonScrl;
@property (nonatomic,retain) IBOutlet UIView *projectPacTypeView;
@property (nonatomic,retain) IBOutlet UIButton *projectNameButton;
@property (nonatomic,retain) IBOutlet UIImageView *outPFrameImgView;
@property (nonatomic,retain) IBOutlet UIImageView *hidePImgView;
@property (nonatomic,retain) IBOutlet UIButton *hidePBtn;
@property (nonatomic,retain) IBOutlet UIView *aroundPacTypeView;
@property (nonatomic,retain) IBOutlet UIButton *aroundNameButton;
@property (nonatomic,retain) IBOutlet UIImageView *outAFrameImgView;
@property (nonatomic,retain) IBOutlet UIImageView *hideAImgView;
@property (nonatomic,retain) IBOutlet UIButton *hideABtn;

//Others
@property (nonatomic,retain) UIView *gestureView;
@property (nonatomic,retain) NSMutableArray *oneYearTyphList;
@property (nonatomic) NSInteger calibrateYear;
@property (nonatomic,retain) UITableView *yearListTable;
@property (nonatomic,retain) UIImageView *myYLTableBottomVew;
@property (nonatomic,retain) NSMutableArray *yearListArray;
@property (nonatomic) NSInteger minusType;
@property (nonatomic,retain) UITableView *rainListTable; //rainTable 
@property (nonatomic,retain) NSString *myTotalRStr;
@property (nonatomic,retain) NSString *twentyFourHourRainfallIdentitor;
@property (nonatomic,retain) UIImageView *myRainTableBottomVew;
@property (nonatomic,retain) NSMutableArray *rainListArray;
@property (nonatomic,retain) NSMutableArray *newTyphoonArray;
@property (nonatomic,retain) UITableView *waterListTable; //waterTable
@property (nonatomic,retain) NSString *myTotalWStr;
@property (nonatomic,retain) UIImageView *myWaterTableBottomView;
@property (nonatomic,retain) NSMutableArray *waterListArray;
@property (nonatomic,retain) NSMutableArray *waterArrRiv;
@property (nonatomic,retain) NSMutableArray *waterArrRev;
@property (nonatomic,retain) NSMutableArray *waterArrGat;
@property (nonatomic,retain) NSMutableArray *waterArrTid;
@property (nonatomic,retain) NSMutableArray *projectGroupArray;//project
@property (nonatomic) NSInteger oldTyphoonTag;
@property (nonatomic,retain) CSMapRouteLayerView * routeView;
@property (nonatomic,retain) CSHisMapRouteLayerView *hisrouteView;
@property (nonatomic,retain) CSHisMapRouteLayerView *sHisrouteView;
@property (nonatomic,retain) CSRainMapRouteLayerView *RainrouteView;
@property (nonatomic,retain) CSWaterMapRouteLayerView *WaterrouteView;
@property (nonatomic,retain) CSSatlliteRouterLayer *saterouteView;
@property (nonatomic,retain) SatelliteOverlay *satelliteOverlay;
@property (nonatomic,retain) NSString *myTotalCStr;
@property (nonatomic,retain) CSZJRouterLayer *zjBackgoundView;
@property (nonatomic,retain) MKPolygon *zjPoly;
//2012年7月2日修改
@property (nonatomic,retain) MKPolygon *philippinesOceanLayer;
@property (nonatomic,retain) NSMutableArray *rainPointArray;
@property (nonatomic,retain) NSMutableArray *rainArrBig6;
@property (nonatomic,retain) NSMutableArray *rainArrBig5;
@property (nonatomic,retain) NSMutableArray *rainArrBig4;
@property (nonatomic,retain) NSMutableArray *rainArrBig3;
@property (nonatomic,retain) NSMutableArray *rainArrBig2;
@property (nonatomic,retain) NSMutableArray *rainArrBig1;
@property (nonatomic,retain) NSMutableArray *waterPointArray;
@property (nonatomic,retain) UIWebView *web;
@property (nonatomic,retain) NSMutableArray *tyGroupHisArray;
@property (nonatomic,retain) NSMutableArray *tyHisArray;
@property (nonatomic,retain) NSMutableArray *tyGroupForeChinaArray;
@property (nonatomic,retain) NSMutableArray *tyForeChinaArray;
@property (nonatomic,retain) NSMutableArray *tyGroupForeHongKongArray;
@property (nonatomic,retain) NSMutableArray *tyForeHongKongArray;
@property (nonatomic,retain) NSMutableArray *tyGroupForeTaiWanArray;
@property (nonatomic,retain) NSMutableArray *tyForeTaiWanArray;
@property (nonatomic,retain) NSMutableArray *tyGroupForeAmericaArray;
@property (nonatomic,retain) NSMutableArray *tyForeAmericaArray;
@property (nonatomic,retain) NSMutableArray *tyGroupForeJapanArray;
@property (nonatomic,retain) NSMutableArray *tyForeJapanArray;
@property (nonatomic,retain) NSMutableArray *historyTyphArray;	
@property (nonatomic,retain) UIPopoverController *popoverController;
@property (nonatomic,retain) UIPopoverController *rListPopoverController;
@property (nonatomic,retain) UIPopoverController *wListPopoverController;
@property (nonatomic,retain) UIPopoverController *lListPopoverController;
@property (nonatomic,retain) UIPopoverController *pListPopoverController;
@property (nonatomic,retain) UIPopoverController *sListPopoverController;
@property (nonatomic,retain) UIPopoverController *cListPopoverController;
@property (nonatomic,retain) UIPopoverController *hisPinPopoverController;
@property (nonatomic,retain) UIPopoverController *sHisPinPopoverController;
@property (nonatomic,retain) UIPopoverController *rwp6PinPopoverController;
@property (nonatomic) NSInteger oldrwp6Sig;
@property (nonatomic) NSInteger oldSearchSig;
@property (nonatomic,retain) NSMutableArray *popverTyphArray;
@property (nonatomic,retain) NSMutableArray *popversTyphArray;
@property (nonatomic,retain) LocationAnnotation *lannotation;
@property (nonatomic,retain) HisTypAnnotation *histannotation;
@property (nonatomic,retain) SLocationAnnotation *sLannotation;
@property (nonatomic,retain) SHisTypAnnotation *sHistannotation;
@property (nonatomic,retain) NSDictionary *cloudDic;
@property (nonatomic,retain) NowTypAnnotation *nowShowAnnotation;
@property (nonatomic,retain) NSMutableArray *newTypAnnotationsArr;
@property (nonatomic) BOOL multiLayer;
@property (nonatomic) BOOL typhoonLayer;
@property (nonatomic) BOOL sTyphoonLayer;
@property (nonatomic) BOOL rainLayer;
@property (nonatomic) BOOL zjPolyLayer;
@property (nonatomic) BOOL waterLayer;
@property (nonatomic) BOOL projectLayer;
@property (nonatomic) BOOL aroundLayer;
@property (nonatomic) BOOL satelliteLayer;
@property (nonatomic) BOOL searchLayer;
@property (nonatomic) BOOL itsRAnno;
@property (nonatomic) BOOL itsWAnno;
@property (nonatomic) BOOL itsPAnno;
@property (nonatomic) BOOL itsSAnno;
@property (nonatomic) BOOL isVirginCheckTy;
@property (nonatomic) NSInteger mapTypeInt;
@property (nonatomic) BOOL rainAndWaterAnKey;
@property (nonatomic) BOOL hisTyphoonKey;
@property (nonatomic) BOOL actTyphoonKey;
@property (nonatomic) BOOL sRainAndWaterAnKey;
@property (nonatomic) BOOL sHisTyphoonKey;

//2013年1月30日修改
@property (nonatomic,retain) NSMutableArray *aroundSZArray;
@property (nonatomic,retain) NSMutableArray *aroundDFArray;
@property (nonatomic,retain) NSMutableArray *aroundBZArray;
@property (nonatomic,retain) NSMutableArray *aroundHTArray;
@property (nonatomic,retain) NSMutableArray *aroundDZArray;
@property (nonatomic,retain) NSMutableArray *aroundSKArray;
@property (nonatomic,retain) UIPopoverController *aroundListPopoverController;
@property (nonatomic,retain) UIPopoverController *aroundPinPopoverController;
@property (nonatomic,assign) CLLocationCoordinate2D coord;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) NSString *selectedRadius;
@property (nonatomic,retain) NSMutableArray *sectionObjets;
@property (nonatomic,retain) NSArray *typeArray;
@property (nonatomic,retain) UITableView *radiusListTable;
@property (nonatomic,retain) UIImageView *myAroundTableBottomView;
//2013年10月23日修改
@property (nonatomic) BOOL noNeedMove;
@property (nonatomic) BOOL isNewVersion;
@property (nonatomic,retain) IBOutlet UIButton *updateBtn;
@property (nonatomic,retain) IBOutlet UIView *updateView;
@property (nonatomic,retain) IBOutlet UIWebView *updateWebView;

+(id)sharedCat;
-(IBAction)updateViewContrller:(id)sender;
-(IBAction)dismissViewContrller:(id)sender;
-(void)addGestureViewButDisabled;
-(void)enabledGestureView;
-(void)disabledGestureView;
-(void)handleGesture:(id)sender;
-(void)drawZJBackground;
-(void)drawZJPolygon;
-(void)drawPhilippinesOceanLayer;
-(void)initNowYear;

-(NSString *)typhoonDocumentPath;
-(void)initiallizeLatestTyphoonInfo;
-(void)writeTyphoonPlistValue:(NSString *)v forKey:(NSString *)k;
-(NSString *)fetchTyphoonPlistValue:(NSString *)k;
-(BOOL)validateForecastDate:(NSString *)d typhoonID:(NSString *)typhoonId;
-(void)validateForecastArray:(NSMutableArray *)fArray;

- (void)getOneYearTyphList:(TFList *)tf;
-(void)produceOneYearTyphArray:(NSString *)oneYear;
-(void)produceOneYearTyphListView;
-(IBAction)touchNameYearButton:(id)sender;
-(void)inspectTyphoonHaveSaveInfo;
- (void)getNewTF:(TFList *)tf;
-(void)addWebScroll;
-(void)ifThereIsActiveTyphoonHorn:(BOOL)signal;
-(IBAction)refreshNowTyphoon:(id)sender;
-(void)defaultMapRegion;
-(void)westPacificMapRegion;
-(IBAction)delayTest:(id)sender;
-(void)dealWithHistoryTyphoonArray:(NSString *)tfid;
-(void)getHistoryTyphoonPath:(TFPathInfo *)item;
-(void)delayAddHistAnnotionToAnimate;
-(void)typhoonHisPath;
-(void)getTyHisPath:(TFPathInfo *)item;
-(void)typhoonForePath;
-(void)getTyForePath:(TFYBList *)item;
-(void)produceRainPHListView;
-(void)preparePoverTyphoon:(TFList *)tfIDInfo;
-(IBAction)preparePoverTyphoonWithNewStyle:(id)sender;
-(void)preparePoverRain:(NSInteger)distinctType;
-(void)preparePoverWater:(NSInteger)myTypeInt;
-(IBAction)showTyphoonListView:(id)sender;
-(void)checkIfNewTyphoon;
-(void)prepareShowTyphoonListView;
-(IBAction)showSearchPopver:(id)sender;
-(IBAction)hideTyphoonListView:(id)sender;
-(void)removeTyphoonListView;
-(IBAction)showRainListView:(id)sender;
-(void)inspectTwentyFourHourRainFall;
-(void)get24HourRainfallIdentifier:(NSString *)temStr;
-(void)prepareShowRainListView;
-(IBAction)hideRainListView:(id)sender;
-(IBAction)showCascade:(id)sender;
-(void)removeRainListView;
-(void)setRainRegion;
-(void)initPacAndHours;
-(IBAction)touchNameRainButton:(id)sender;
-(void)dealWithRainArray:(NSString *)rainURL;
-(void)dealWithRainMapView:(NSMutableArray *)myArray;
-(void)dealWithRainMap:(NSString *)cellTemyear;
-(void)getRainListByHourString:(NSString *)temStr;
-(void)dealWithWaterArray:(NSString *)mWaterContent;
-(void)dealWithWaterView;
-(void)getWaterListByTypeString:(NSString *)temStr;
-(void)dealWithWaterMap:(NSString *)cellTemyear;
-(NSString *)changeWIntoBetWeen:(NSString *)betInt;
-(void)produceWaterPacTypeView;
-(IBAction)showWaterListView:(id)sender;
-(void)prepareShowWaterListView;
-(IBAction)hideWaterListView:(id)sender;
-(void)removeWaterListView;
-(void)initWaterStaus;
-(IBAction)touchNameWaterButton:(id)sender;
-(IBAction)showProjectListView:(id)sender;
-(void)prepareShowProjectListView;
-(void)getProjectListArray:(WorkInfo *)temInfo;
-(void)prepareProjectListArrayWithPac:(NSString *)nowPac;
-(void)produceProjectListView;
-(void)preparePoverProject:(NSInteger)myTypeInt;
-(NSInteger)convertCountWithArray:(NSMutableArray *)temArray;
-(IBAction)hideProjectListView:(id)sender;
-(void)removeProjectListView;
-(IBAction)showChooseLocation:(id)sender;
-(void)dealLocationwithName:(NSString *)cname withPac:(NSString *)cpac withKey:(BOOL)ckey;
//2013年1月
-(void)addSectionInfos:(NSMutableArray *)sections;
-(void)addSKMapArray:(NSMutableArray *)array;
-(void)addSZMapArray:(NSMutableArray *)array;
-(void)addBZMapArray:(NSMutableArray *)array;
-(void)addHTMapArray:(NSMutableArray *)array;
-(void)addDFMapArray:(NSMutableArray *)array;
-(void)addDZMapArray:(NSMutableArray *)array;
-(void)fetchDataError;
-(IBAction)showAroundListView:(id)sender;
-(void)beginLocation;
-(void)produceAroundListView;
-(IBAction)hideAroundListView:(id)sender;
-(void)removeAroundListView;
-(IBAction)touchNameAroundButton:(id)sender;
-(void)dealWithAroundPacType:(OneAroundView *)myView convertProjectType:(NSInteger)typeInt;
-(void)preparePoverAround:(NSInteger)myTypeInt;
-(void)dismissAround;
-(void)dismissAroundPin;
-(void)responseAroundWithType:(NSString *)type WithIndex:(NSString *)indexString;

- (void)animateToWorld:(NSArray *)jwArray;
- (void)animateToPlace:(NSArray *)jwArray;
-(void)setLocationLon:(NSArray *)infoArr withType:(NSString *)moduleType;
-(IBAction)downLoadSatelliteMapAndShow:(id)sender;
-(IBAction)addSatelliteLayer:(id)sender;
-(void)prepareSatelliteImage;
-(void)getSatelliteStrByType:(NSString *)temStr;
-(void)warningErrorFetchImage;
- (void)cacheImage: (NSString *)cCloudName;
-(void)addSatelliteView:(NSArray *)cArray;
-(IBAction)hideSatelliteTimeViewView:(id)sender;
-(void)removeRWPin;
-(void)removeTyphoon;
-(void)removeSearch;
-(void)removeRain;
-(void)removeWater;
-(void)removeProject;
-(void)removeSatellite;
-(void)removeAround;
-(void)removeAll;
-(void)initAllAnnoKey;
-(void)addWaitting;
-(void)removeWaitting;
-(void)receviceSearchTyphoonArrayAndDrawIt:(NSMutableArray *)myArray WithName:(NSString *)tfnm WithID:(NSString *)tyid;
-(void)showAlertViewIsActivity:(NSString *)temStr;
-(void)showAlertViewHasDrawed:(NSString *)temStr;
- (void)sAnimateToWorld:(NSArray *)jwArray;
- (void)sAnimateToPlace:(NSArray *)jwArray;
-(void)delaySAddAnnotionToAnimate;
-(void)setSLocationLon:(NSString *)lon LocationLat:(NSString *)lat PointName:(NSString*)nm PointData:(NSString *)dt PointType:(NSString*)ty;
-(void)initAnnotationShowKey;
-(NSArray *)checkVisiblePopover;
-(void)dismissRealTyphoon;
-(void)dismissHistoryTyphoon;
-(void)dismissRain;
-(void)dismissWater;
-(void)dismissProject;
-(void)dismissLocation;
-(void)dismissSearch;
-(void)dismissRWP6;
@end

