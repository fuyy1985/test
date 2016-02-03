//
//  Work1Controller.h
//  navag
//
//  Created by Heiby He on 09-3-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkInfo;
@interface Work1Controller : UIViewController <UINavigationBarDelegate,
												UITableViewDelegate, UITableViewDataSource>
{
	NSMutableArray *hisc;
	NSMutableArray *Count;
	NSMutableArray *gcgm;
	NSString *gclx;
	NSString *sgclx;
	NSInteger type;
	NSInteger selRowIndex;
	IBOutlet UITableView *myTable;
	
	UIActivityIndicatorView *myActivity;
    
    UILabel *_totalLabel;
    NSMutableArray *_newCountArray;
}

@property (nonatomic, retain) NSMutableArray *hisc;
@property (nonatomic, retain) NSMutableArray *Count;
@property (nonatomic, retain) NSMutableArray *gcgm;
@property (nonatomic, retain) NSString *gclx;
@property (nonatomic, retain) NSString *sgclx;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *myActivity;
@property NSInteger selRowIndex;
@property (nonatomic,retain) UILabel *totalLabel;
@property (nonatomic,retain) NSMutableArray *newCountArray;

+(id)sharedWork1;
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
-(void)addCount:(NSArray *)c;
-(void)addNewCount:(WorkInfo *)c;
-(void)getCount;
-(NSString *)convertUnitByProjectNm:(NSString *)projectNm;
-(NSString *)convertTypeByOldType:(NSString *)oldType;

@end
