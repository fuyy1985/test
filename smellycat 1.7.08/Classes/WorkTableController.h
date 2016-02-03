//
//  WorkTableController.h
//  navag
//
//  Created by Heiby He on 09-5-4.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkInfo;
@interface WorkTableController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	UITableView *myTable;
	UINavigationController *navagController;
	NSMutableArray *hisc;
	NSString *gclx;
	NSString *gcgm;
	NSInteger pageIndex;
	BOOL isLoaded;
}
- (id)initWithPageNumber:(int)page wlx:(NSString *)lx wgm:(NSString *)gm;
-(void)loadData;
- (void)getDataOnNewThread;
-(void)addData:(WorkInfo *)info;
- (NSString *)GetSampleName:(NSString *)ProjectName;
-(void)showAlertView;
@property (nonatomic, retain)UITableView *myTable;
@property (nonatomic, retain)UINavigationController *navagController;
@property (nonatomic, retain)NSMutableArray *hisc;
@property (copy) NSString *gclx;
@property (copy) NSString *gcgm;
@end
