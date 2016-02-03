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
#import "CSSatlliteRouterLayer.h"
#import "SatelliteOverlay.h"
#import "LocationAnnotation.h"
#import "HisTypAnnotation.h"
#import "NowTypAnnotation.h"
#import "SLocationAnnotation.h"
#import "SHisTypAnnotation.h"
#import "NSDictionary+BSJSONAdditions.h"
#import "ControlDogCascade.h"

@class TFList;
@class TFPathInfo;
@class TFYBList;
@interface smellydogViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MKMapViewDelegate,OneTyphoonViewDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate,ControlDogCascadeDelegate,UIWebViewDelegate> {
	//IBOutlet
	UIView *loginView;
	UIButton *barTyphoonBtn;
	UIButton *barCloudBtn;
	UIButton *barSearchBtn;
	UIButton *barTrashBtn;
	UIButton *yearNameButton;
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
	UIImageView *outFrameImgView;
	UIImageView *hideImgView;
	UIButton *hideBtn;
	UIView *satelliteTimeView;
	UILabel *satelliteNameBtn;
	UIView *wattingView;
	UIView *typhoonScrl;
	
	//Others
	UIView *gestureView;
	NSMutableArray *oneYearTyphList;
	NSInteger calibrateYear;
	UITableView *yearListTable;
	UIImageView *myYLTableBottomVew;
	NSMutableArray *yearListArray;
	NSInteger minusType;
	NSMutableArray *newTyphoonArray;
	NSInteger oldTyphoonTag;
	CSMapRouteLayerView * _routeView;
	CSHisMapRouteLayerView *_hisrouteView;
	CSHisMapRouteLayerView *_sHisrouteView;
	CSSatlliteRouterLayer *_saterouteView;
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
    UIPopoverController *cListPopoverController;
	UIPopoverController *lListPopoverController;
	UIPopoverController *hisPinPopoverController;
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
	BOOL typhoonLayer;// about clear layer
	BOOL satelliteLayer;
	BOOL searchLayer;
	BOOL sTyphoonLayer;
	BOOL itsSAnno;
	BOOL isVirginCheckTy;// first check typhoon;
	NSInteger mapTypeInt;
	BOOL hisTyphoonKey;
	BOOL actTyphoonKey;
	BOOL sHisTyphoonKey;
	BOOL you;
    
    //新加入
    BOOL isNewVersion;
    UIButton *updateBtn;
    UIView *updateView;
    UIWebView *updateWebView;
}
//IBOutlet
@property (nonatomic,retain) IBOutlet UIView *loginView;
@property (nonatomic,retain) IBOutlet UIButton *barTyphoonBtn;
@property (nonatomic,retain) IBOutlet UIButton *barCloudBtn;
@property (nonatomic,retain) IBOutlet UIButton *barSearchBtn;
@property (nonatomic,retain) IBOutlet UIButton *barTrashBtn;
@property (nonatomic,retain) IBOutlet UIButton *yearNameButton;
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
@property (nonatomic,retain) IBOutlet UIImageView *outFrameImgView;
@property (nonatomic,retain) IBOutlet UIImageView *hideImgView;
@property (nonatomic,retain) IBOutlet UIButton *hideBtn;
@property (nonatomic,retain) IBOutlet UIView *satelliteTimeView;
@property (nonatomic,retain) IBOutlet UILabel *satelliteNameBtn;
@property (nonatomic,retain) IBOutlet UIView *wattingView;
@property (nonatomic,retain) IBOutlet UIView *typhoonScrl;
@property (nonatomic,retain) IBOutlet UIView *projectPacTypeView;
@property (nonatomic,retain) IBOutlet UIButton *projectNameButton;
@property (nonatomic,retain) IBOutlet UIImageView *outPFrameImgView;
@property (nonatomic,retain) IBOutlet UIImageView *hidePImgView;
@property (nonatomic,retain) IBOutlet UIButton *hidePBtn;

//Others
@property (nonatomic,retain) UIView *gestureView;
@property (nonatomic,retain) NSMutableArray *oneYearTyphList;
@property (nonatomic) NSInteger calibrateYear;
@property (nonatomic,retain) UITableView *yearListTable;
@property (nonatomic,retain) UIImageView *myYLTableBottomVew;
@property (nonatomic,retain) NSMutableArray *yearListArray;
@property (nonatomic) NSInteger minusType;
@property (nonatomic,retain) NSMutableArray *newTyphoonArray;
@property (nonatomic) NSInteger oldTyphoonTag;
@property (nonatomic,retain) CSMapRouteLayerView * routeView;
@property (nonatomic,retain) CSHisMapRouteLayerView *hisrouteView;
@property (nonatomic,retain) CSHisMapRouteLayerView *sHisrouteView;
@property (nonatomic,retain) CSSatlliteRouterLayer *saterouteView;
@property (nonatomic,retain) SatelliteOverlay *satelliteOverlay;
@property (nonatomic,retain) NSString *myTotalCStr;
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
@property (nonatomic,retain) UIPopoverController *lListPopoverController;
@property (nonatomic,retain) UIPopoverController *cListPopoverController;
@property (nonatomic,retain) UIPopoverController *sListPopoverController;
@property (nonatomic,retain) UIPopoverController *hisPinPopoverController;
@property (nonatomic,retain) UIPopoverController *sHisPinPopoverController;
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
@property (nonatomic) BOOL typhoonLayer;
@property (nonatomic) BOOL sTyphoonLayer;
@property (nonatomic) BOOL satelliteLayer;
@property (nonatomic) BOOL searchLayer;
@property (nonatomic) BOOL itsSAnno;
@property (nonatomic) BOOL isVirginCheckTy;
@property (nonatomic) NSInteger mapTypeInt;
@property (nonatomic) BOOL hisTyphoonKey;
@property (nonatomic) BOOL actTyphoonKey;
@property (nonatomic) BOOL sHisTyphoonKey;

//新加入
@property (nonatomic) BOOL isNewVersion;
@property (nonatomic,retain) IBOutlet UIButton *updateBtn;
@property (nonatomic,retain) IBOutlet UIView *updateView;
@property (nonatomic,retain) IBOutlet UIWebView *updateWebView;

+(id)sharedDog;
-(BOOL)checkIsConnect;
-(void)addGestureViewButDisabled;
-(void)enabledGestureView;
-(void)disabledGestureView;
-(void)handleGesture:(id)sender;
-(void)initNowYear;

//fetch up the absolute file path
-(NSString *)typhoonDocumentPath;
//initialize the latest typhoon info
-(void)initiallizeLatestTyphoonInfo;
//write the latest typhoonInfo to file "latestTyphoon.plist"
-(void)writeTyphoonPlistValue:(NSString *)v forKey:(NSString *)k;
//obtain the value by key
-(NSString *)fetchTyphoonPlistValue:(NSString *)k;
//judge the time whether the forecast date is 24 hours date than history date
-(BOOL)validateForecastDate:(NSString *)d typhoonID:(NSString *)typhoonId;
//deal with the forecast mutableArray
-(void)validateForecastArray:(NSMutableArray*)fArray;

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
-(void)preparePoverTyphoon:(TFList *)tfIDInfo;
-(IBAction)preparePoverTyphoonWithNewStyle:(id)sender;
-(IBAction)showTyphoonListView:(id)sender;
-(void)checkIfNewTyphoon;
-(void)prepareShowTyphoonListView;
-(IBAction)showSearchPopver:(id)sender;
-(IBAction)hideTyphoonListView:(id)sender;
-(void)removeTyphoonListView;
-(IBAction)showCascade:(id)sender;
-(IBAction)downLoadSatelliteMapAndShow:(id)sender;
-(IBAction)addSatelliteLayer:(id)sender;
-(void)prepareSatelliteImage;
-(void)getSatelliteStrByType:(NSString *)temStr;
-(void)warningErrorFetchImage;
- (void)cacheImage: (NSString *)cCloudName;
-(void)addSatelliteView:(NSArray *)cArray;
-(IBAction)hideSatelliteTimeViewView:(id)sender;
-(void)removeTyphoon;
-(void)removeSearch;
-(void)removeSatellite;
-(void)removeAll;
-(void)initAllAnnoKey;
-(void)addWaitting;
-(void)removeWaitting;
-(void)receviceSearchTyphoonArrayAndDrawIt:(NSMutableArray *)myArray WithName:(NSString *)tfnm WithID:(NSString *)tyid;
-(void)showAlertViewIsActivity:(NSString *)temStr;
-(void)showAlertViewHasDrawed:(NSString *)temStr;
-(void)delaySAddAnnotionToAnimate;
-(void)initAnnotationShowKey;
-(void)dismissRealTyphoon;
-(void)dismissHistoryTyphoon;
-(void)dismissSearch;
@end

