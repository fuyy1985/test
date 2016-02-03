//
//  FlowLeftViewController.h
//  GovOfQGJ
//
//  Created by apple on 10-6-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMFlowChart.h"

@class FlowInfo;
@class MyMFlowChart;
@class WaterCrossProjectInfo;
@class MyMSFlowChart;
@interface FlowLeftViewController : UIViewController<UIScrollViewDelegate,MyMFlowChartDelegate> {
	BOOL isOK;//处理横屏事宜
	NSMutableArray *flowdays;
	NSString *specialstring;
    WaterCrossProjectInfo *specialInfo;
	MyMFlowChart *chartView;
    MyMSFlowChart *chartView2;
	//处理放大事宜
	UIScrollView *myscrollview;
	
	NSString *pointCode;
    BOOL isPMT;
    NSString *pointType;
    NSString *pointNM;
    UILabel *titleLabel;
    UIButton *myGQBtn;
    UIButton *myXMBtn;
}
@property(nonatomic,retain)NSMutableArray *flowdays;
@property(nonatomic) BOOL isOK;
@property(nonatomic,retain) NSString *specialstring;
@property(nonatomic,retain) WaterCrossProjectInfo *specialInfo;
@property(nonatomic,retain) MyMFlowChart *chartView;
@property(nonatomic,retain) MyMSFlowChart *chartView2;
@property(nonatomic,retain) IBOutlet UIScrollView *myscrollview;
@property(nonatomic,retain) NSString *pointType;
@property(nonatomic,retain) NSString *pointNM;
@property(nonatomic,retain) IBOutlet UILabel *titleLabel;
@property(nonatomic,retain) IBOutlet UIButton *myGQBtn;
@property(nonatomic,retain) IBOutlet UIButton *myXMBtn;
@property(nonatomic) BOOL isPMT;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withPointC:(NSString*)pointC;
- (void)addRainItem:(FlowInfo *)Items;
- (void)getSpecialData:(NSString *)str;
- (void)getWaterCrossProjectInfo:(WaterCrossProjectInfo *)info;
-(IBAction)toggle:(id)sender;
-(IBAction)pushToProject:(id)sender;
-(void)showTheThingsOnView;
+(id)shareflowleft;
@end