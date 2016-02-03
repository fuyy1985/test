//
//  Around1Controller.h
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Around1Controller : UIViewController <UINavigationBarDelegate,
											    UIScrollViewDelegate>
{
	NSMutableArray *hisc;
	IBOutlet UIScrollView *myScroll;
	IBOutlet UIPageControl *myPage;
	NSInteger numPages;
	NSMutableArray *AllPages;
	//UIAlertView *alert;
	NSString *totalCount;
	BOOL pageControlUsed;
	NSString *hours;
	NSString *orderBy;
	IBOutlet UIActivityIndicatorView *activityShow;
	NSOperationQueue *opQueue;	
	BOOL isFirstLoad;
	NSInteger closePage;
    NSInteger _typeNm;
}
@property (nonatomic,retain) NSMutableArray *hisc;
@property (nonatomic, retain) UIActivityIndicatorView *activityShow;
@property (nonatomic, retain)UIScrollView *myScroll;
@property (nonatomic, retain)UIPageControl *myPage;
@property (nonatomic, retain)NSMutableArray *AllPages;
@property (nonatomic, retain) NSString *totalCount;
@property (nonatomic, retain) NSString *hours;
@property (nonatomic, retain) NSString *orderBy;
@property NSInteger closePage;

@property (nonatomic) BOOL isFirstLoad;

@property NSInteger numPages;
@property (nonatomic,assign) NSInteger typeNm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withArray:(NSMutableArray *)myArray;
+ (id)sharedAround1;
- (IBAction)changePage:(id)sender;
- (IBAction)OrderByRain;
- (void)reloadData;
- (void)loadPages;
- (void)loadScrollViewWithPage:(int)temPage;

@end
