//
//  Work3Controller.h
//  navag
//
//  Created by DY LOU on 10-3-25.
//  Copyright 2010 Zhejiang Dayu Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableInfo;
@class WorkInfo;
@interface Work3Controller : UIViewController <UINavigationBarDelegate,
												UITableViewDelegate, UITableViewDataSource>
{
    NSString *myEnnm;
    NSString *myEnnmcd;
    NSString *myEngr;
	NSInteger type;
	WorkInfo *info;
	NSMutableArray *list;
	NSMutableArray *list2;
    NSMutableArray *heightArray;
    NSString *gclx;
    NSString *nowKey;
    NSString *nowLevel;
    NSString *warningLevel;
    NSString *beyondLeve;
    NSString *titleName;
    
    UITableView *myTable;
	UISegmentedControl *tabBar;
	UIWebView *myWeb;
    UILabel *titleLabel;
    UILabel *nowWaterLabel;
    UILabel *nowWaterDateLabel;
    UILabel *beyondTitleLabel;
    UILabel *beyondLabel;
    UIImageView *beyondIcon;
    UIButton *backBtn;
    BOOL backShow;
}

@property (nonatomic, retain) NSString *myEnnm;
@property (nonatomic, retain) NSString *myEnnmcd;
@property (nonatomic, retain) NSString *myEngr;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) WorkInfo *info;
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) NSMutableArray *list2;
@property (nonatomic, retain) NSMutableArray *heightArray;
@property (nonatomic, retain) NSString *gclx;
@property (nonatomic, retain) NSString *nowKey;
@property (nonatomic, retain) NSString *nowLevel;
@property (nonatomic, retain) NSString *warningLevel;
@property (nonatomic, retain) NSString *beyondLeve;
@property (nonatomic, retain) NSString *titleName;
@property (nonatomic,assign) BOOL backShow;

@property (nonatomic,retain) IBOutlet UITableView *myTable;
@property (nonatomic,retain) IBOutlet UISegmentedControl *tabBar;
@property (nonatomic,retain) IBOutlet UIWebView *myWeb;
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UILabel *nowWaterLabel;
@property (nonatomic,retain) IBOutlet UILabel *nowWaterDateLabel;
@property (nonatomic,retain) IBOutlet UILabel *beyondTitleLabel;
@property (nonatomic,retain) IBOutlet UILabel *beyondLabel;
@property (nonatomic,retain) IBOutlet UIImageView *beyondIcon;
@property (nonatomic,retain) IBOutlet UIButton *backBtn;

+(id)sharedWork3;
-(void)initWater;
-(void)initSluice;
-(void)initRiver;
-(void)initDike;
-(void)initFormation;
-(void)initPowerStation;
-(void)initIrrigation;
-(void)initReclamation;
-(void)initRankIrrigation;
-(void)initWeiyuan;
-(void)initController;
-(void)initFlood;

-(void)setSegIndexEqualZeroAndFetch;
-(void)disableTabBar;

-(void)loadData:(NSString *)tname;
-(IBAction)chageTable; 
-(void)initSegment;
-(void)addList:(NSArray *)li;
-(void)showTitle;
-(void)addSegment:(NSArray *)ti;
-(IBAction)backToLastViewController:(id)sender;
-(NSString *)isNeedYellowWarning:(NSArray *)array withIndex:(NSInteger)row;

@end
