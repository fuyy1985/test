//
//  SearchController.h
//  navag
//
//  Created by Heiby He on 09-3-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchReaultInfo;
@class TFPathInfo;
@interface SearchDogController : UIViewController<UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource> {
	NSInteger type;
	NSMutableArray *hisc;
	NSMutableArray *hiscPath;
	IBOutlet UITableView *myTable;
	IBOutlet UISearchBar *mySearchBar;
	UIView *wattingView;
}

@property (nonatomic, retain) UITableView *myTable;
@property (nonatomic, retain) NSMutableArray *hisc;
@property (nonatomic,retain) NSMutableArray *hiscPath;
@property (nonatomic, retain) UISearchBar *mySearchBar;
@property (nonatomic,retain) IBOutlet UIView *wattingView;

+(id)sharedWork;
-(void)clearSearch:(id)sender;
-(void)addWaitting;
-(void)removeWaitting;
-(void)dealWithData:(NSString*)txt;
-(void)forWatting:(SearchReaultInfo *)myInfo;
-(void)dealWithTyPh:(NSString *)dTfid;
-(void)getHistoryTyphoonPath:(TFPathInfo *)item;
@end
