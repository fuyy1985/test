//
//  ControlCascade.h
//  smellycat
//
//  Created by apple on 10-11-19.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ControlDogCascade;
@protocol ControlDogCascadeDelegate
-(void)dealWithDogCascade:(ControlDogCascade *)myView removeName:(NSString *)cascadeStr;
@end

@interface ControlDogCascade : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	id <ControlDogCascadeDelegate> delegate;
	UITableView *tableView;
	NSMutableArray *dataSource;
	NSString *typhoonLayer;
	NSString *satelliteLayer;
	NSString *searchMemLayer;
	NSString *mapType;
	
	UIButton *removeTyphoon;
	UIButton *removeSatellite;
	UIButton *removeSearchMem;
	UISegmentedControl *mapSeg;
}
@property(nonatomic,assign) id <ControlDogCascadeDelegate> delegate;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *dataSource;
@property(nonatomic,retain) NSString *multiLayerEnable;
@property(nonatomic,retain) NSString *typhoonLayer;
@property(nonatomic,retain) NSString *satelliteLayer;
@property(nonatomic,retain) NSString *searchMemLayer;
@property(nonatomic,retain) NSString *mapType;
@property(nonatomic,retain,readonly) UIButton *removeTyphoon;
@property(nonatomic,retain,readonly) UIButton *removeSatellite;
@property(nonatomic,retain,readonly) UIButton *removeSearchMem;
@property(nonatomic,retain,readonly) UISegmentedControl *mapSeg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil typhoonInfo:(BOOL)tInfo satelliteInfo:(BOOL)sInfo searchInfo:(BOOL)seInfo mapType:(NSInteger)typeInfo;
-(BOOL)isHaveLayers;
-(void)typhoonAction:(id)sender;
-(void)satelliteAction:(id)sender;
-(void)segChanged:(id)sender;

@end
