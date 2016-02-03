//
//  TyphoonSListPopovers.h
//  smellycat
//
//  Created by apple on 10-11-27.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFPathInfo;
@interface TyphoonSListPopovers : UIViewController {
	NSString *dTfid;
	NSString *dTfName;
	NSMutableArray *hiscPath;
	NSInteger parserSelection;
	UITableView *myTable;
	UIView *wattingView;
}
@property (nonatomic, retain) NSMutableArray *hiscPath;
@property (nonatomic,retain) NSString *dTfid;
@property (nonatomic,retain) NSString *dTfName;
@property (nonatomic,retain) IBOutlet UITableView *myTable;
@property (nonatomic,retain) IBOutlet UIView *wattingView;
+(id)shareSTf;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithTfID:(NSString*)tfIDStr WIthTfName:(NSString *)tfNameStr;
-(void)getHistoryTyphoonPath:(TFPathInfo *)item;
-(void)convertTyphoonArrayToDelegate;
-(void)addWaitting;
-(void)removeWaitting;
-(void)dealWithData;

@end
