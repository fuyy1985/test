//
//  RainTableController.h
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RainXmlParser.h"

@interface RainTableController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate> {
	UITableView *myTable;
	UINavigationController *navagController;
	NSMutableArray *hisc;
	int pageIndex;
	int totalNum;
	BOOL isLoaded;
}

@property (nonatomic, retain)UITableView *myTable;
@property (nonatomic, retain)UINavigationController *navagController;
@property (nonatomic,retain) NSMutableArray *hisc;
@property (nonatomic) int totalNum;
@property (nonatomic) int pageIndex;

- (id)initWithPageNumber:(int)page withTotalArray:(NSMutableArray *)tArray;
-(void)loadData;
- (void)getDataOnNewThread;
-(void)showAlertView;
@end
