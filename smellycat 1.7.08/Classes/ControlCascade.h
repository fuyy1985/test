//
//  ControlCascade.h
//  smellycat
//
//  Created by apple on 10-11-19.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ControlCascade;
@protocol ControlCascadeDelegate
-(void)dealWithCascade:(ControlCascade *)myView removeName:(NSString *)cascadeStr;
@end

@interface ControlCascade : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	id <ControlCascadeDelegate> delegate;
	UITableView *tableView;
	NSMutableArray *dataSource;
	NSString *multiLayerEnable;
	NSString *typhoonLayer;
	NSString *rainLayer;
	NSString *waterLayer;
	NSString *projectLayer;
	NSString *satelliteLayer;
	NSString *totalLayer;
	NSString *searchMemLayer;
	NSString *mapType;
    NSString *aroundLayer;
	
	UISwitch *multiSw;
	UIButton *removeAll;
	UIButton *removeTyphoon;
	UIButton *removeRain;
	UIButton *removeWater;
	UIButton *removeProject;
	UIButton *removeSatellite;
	UIButton *removeSearchMem;
	UISegmentedControl *mapSeg;
}
@property(nonatomic,assign) id <ControlCascadeDelegate> delegate;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *dataSource;
@property(nonatomic,retain) NSString *multiLayerEnable;
@property(nonatomic,retain) NSString *typhoonLayer;
@property(nonatomic,retain) NSString *rainLayer;
@property(nonatomic,retain) NSString *waterLayer;
@property(nonatomic,retain) NSString *projectLayer;
@property(nonatomic,retain) NSString *satelliteLayer;
@property(nonatomic,retain) NSString *totalLayer;
@property(nonatomic,retain) NSString *searchMemLayer;
@property(nonatomic,retain) NSString *mapType;
@property(nonatomic,retain) NSString *aroundLayer;
@property(nonatomic,retain,readonly) UISwitch *multiSw;
@property(nonatomic,retain,readonly) UIButton *removeAll;
@property(nonatomic,retain,readonly) UIButton *removeTyphoon;
@property(nonatomic,retain,readonly) UIButton *removeRain;
@property(nonatomic,retain,readonly) UIButton *removeWater;
@property(nonatomic,retain,readonly) UIButton *removeProject;
@property(nonatomic,retain,readonly) UIButton *removeAround;
@property(nonatomic,retain,readonly) UIButton *removeSatellite;
@property(nonatomic,retain,readonly) UIButton *removeSearchMem;
@property(nonatomic,retain,readonly) UISegmentedControl *mapSeg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil multiInfo:(BOOL)mInfo typhoonInfo:(BOOL)tInfo rainInfo:(BOOL)rInfo waterInfo:(BOOL)wInfo projectInfo:(BOOL)pInfo satelliteInfo:(BOOL)sInfo aroundInfo:(BOOL)aInfo searchInfo:(BOOL)seInfo mapType:(NSInteger)typeInfo;
-(BOOL)isHaveLayers;
-(void)swAction:(id)sender;
-(void)typhoonAction:(id)sender;
-(void)rainAction:(id)sender;
-(void)waterAction:(id)sender;
-(void)projectAction:(id)sender;
-(void)satelliteAction:(id)sender;
-(void)aroundAction:(id)sender;
-(void)allAction:(id)sender;
-(void)segChanged:(id)sender;

@end
