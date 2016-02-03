//
//  RainSDInfoController.h
//  smellycat
//
//  Created by apple on 10-12-2.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyChart,RainInfo;
@interface RainSDInfoController : UIViewController {
	UILabel *wsys;
	NSMutableArray *rainDays;
	RainInfo *info;
	NSString *lat;
	NSString *lon;
	
}
@property(nonatomic,retain) IBOutlet UILabel *wsys;
@property(nonatomic,retain)NSMutableArray *rainDays;
@property(nonatomic,retain)RainInfo *info;
@property(nonatomic,retain) NSString *lat;
@property(nonatomic,retain) NSString *lon;

+(id)shareSRain2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withRainID:(NSString *)rainID withRainName:(NSString *)rainNM withRainAdd:(NSString *)rainAdd;
- (void)addSRainItem:(NSMutableArray *)Items;
-(void)locationToPoint;

@end
