//
//  WaterTableController.h
//  navag
//
//  Created by Heiby He on 09-4-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterInfo;
@interface WaterTableController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	UITableView *myTable;
	UINavigationController *navagController;
	int pageIndex;
	int totalNum;
	NSMutableArray *hisc;
	BOOL isLoaded;
}
- (id)initWithPageNumber:(int)page withTotalArray:(NSMutableArray *)tArray;
-(void)loadData;
- (void)getDataOnNewThread;
-(void)showAlertView;
@property (nonatomic, retain)UITableView *myTable;
@property (nonatomic, retain)UINavigationController *navagController;
@property (nonatomic, retain) NSMutableArray *hisc;
@property (nonatomic) int totalNum;
@property (nonatomic) int pageIndex;
@end
