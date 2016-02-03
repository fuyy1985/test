//
//  Work2Controller.h
//  navag
//
//  Created by Heiby He on 09-3-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Work2Controller : UIViewController<UIScrollViewDelegate>
{
	NSInteger type;
	
	NSInteger numPages;
	NSMutableArray *AllPages;
	BOOL pageControlUsed;
	BOOL isFirstLoad;
	NSString *ntitle;
	NSString *gclx;
	NSString *gcgm;
	NSString *workCount;
	
	IBOutlet UIBarItem *total;
	IBOutlet UIBarButtonItem *location;
	IBOutlet UIScrollView *myScroll;
	IBOutlet UIPageControl *myPage;
	NSInteger closePage;
}
-(void)initWork:(NSString *)titletext;
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
- (IBAction)changePage:(id)sender;

-(NSString *)convertUnitByProjectNm:(NSString *)projectNm;
+(id)sharedWork2;
-(void)reloadData;
-(void)loadPages;
- (void)loadScrollViewWithPage:(int)page;
@property (nonatomic) BOOL isFirstLoad;
@property (nonatomic, retain) NSMutableArray *AllPages;
@property (nonatomic, retain) NSString *ntitle;
@property (nonatomic, retain) NSString *gclx;
@property (nonatomic, retain) NSString *gcgm;
@property (nonatomic, retain) NSString *workCount;
@property NSInteger closePage;
@property NSInteger numPages;
@end
