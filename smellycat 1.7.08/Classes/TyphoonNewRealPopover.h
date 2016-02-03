//
//  TyphoonNewRealPopover.h
//  smellycat
//
//  Created by apple on 11-5-27.
//  Copyright 2011 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TyphoonNewRealPopover : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	UILabel *nmLable;
	UILabel *subNMLable;
	UITableView *myTable;
	NSMutableArray *myTableArr;
	UISegmentedControl *mySeg;
	UIToolbar *myToolbar;
	NSInteger myIndex;
	
	NSMutableArray *infoArray;
	NSMutableArray *hisArray;
}
@property(nonatomic,retain) UILabel *nmLable;
@property(nonatomic,retain) UILabel *subNMLable;
@property(nonatomic,retain) UITableView *myTable;
@property(nonatomic,retain) NSMutableArray *myTableArr;
@property(nonatomic,retain) UISegmentedControl *mySeg;
@property(nonatomic,retain) UIToolbar *myToolbar;
@property(nonatomic) NSInteger myIndex;

@property (nonatomic,retain) NSMutableArray *infoArray;
@property (nonatomic,retain) NSMutableArray *hisArray;

-(id)initwithTyphoonInfoArray:(NSMutableArray *)temInfoArray historyArray:(NSMutableArray *)temHisArray;
-(void)changeTheSegOfTyphoon;
	
@end
