//
//  Water1Controller.h
//  navag
//
//  Created by Heiby He on 09-3-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Water1Controller : UIViewController <UINavigationBarDelegate,UIScrollViewDelegate>
{
	IBOutlet UIScrollView *myScroll;
	IBOutlet UIPageControl *myPage;
	IBOutlet UILabel *myLabel;
	NSInteger numPages;
	NSMutableArray *AllPages;
	NSMutableArray *hisc;
	BOOL pageControlUsed;
	BOOL isFirstLoad;
	NSString *orderby;
	NSString *totalCount;
	NSString *waterType;
	NSInteger closePage;
}
+(id)sharedWater1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withArray:(NSMutableArray *)myArray;
- (IBAction)changePage:(id)sender;
-(void)reloadData;
-(void)loadPages;
- (void)loadScrollViewWithPage:(int)page;
@property(nonatomic,retain) UIScrollView *myScroll;
@property(nonatomic,retain) UIPageControl *myPage;
@property(nonatomic, retain)NSMutableArray *AllPages;
@property(nonatomic,retain) NSMutableArray *hisc;
@property(nonatomic, retain) UILabel *myLabel;
@property(nonatomic,retain) NSString *orderby;
@property(nonatomic,retain) NSString *totalCount;
@property(nonatomic,retain) NSString *waterType;
@property(nonatomic) BOOL isFirstLoad;
@property NSInteger closePage;
@property NSInteger numPages;
@end
