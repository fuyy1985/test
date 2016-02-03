//
//  Work3Controller.h
//  navag
//
//  Created by Heiby He on 09-3-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+BSJSONAdditions.h"

@class TableInfo;
@class WorkInfo;
@interface Work3SController : UIViewController <UINavigationBarDelegate,
												UITableViewDelegate, UITableViewDataSource>
{
	NSInteger type;
	WorkInfo *info;
	IBOutlet UITableView *myTable;
	IBOutlet UISegmentedControl *tabBar;
	IBOutlet UIWebView *myWeb;
	NSString *JSONStr;
	
	NSMutableArray *list;
	NSMutableArray *list2;
}
+(id)sharedWork3;
-(void)getJSON:(NSString *)item;
-(void)LocationPoint;
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
-(IBAction)chageTable; 
-(void)initSegment;
-(void)addList:(NSArray *)li;
-(void)addSegment:(NSArray *)ti;
@property (nonatomic,retain) NSString *JSONStr;
@property (nonatomic, retain) WorkInfo *info;
@property (nonatomic, retain) UISegmentedControl *tabBar;
@property (nonatomic, retain) UIWebView *myWeb;
@end
