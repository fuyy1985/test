//
//  Rain2Controller.h
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyChart;
@interface Rain2Controller : UIViewController {
	IBOutlet UILabel *zcode;
	IBOutlet UILabel *wsys;
	IBOutlet UILabel *type;
	NSMutableArray *rainDays;
	NSString *ntitle;
	NSString *emmcd;
	NSString *dist;
	UIActivityIndicatorView *myActivity;
}
@property(nonatomic,retain)UILabel *wsys;
@property(nonatomic,retain)UILabel *zcode;
@property(nonatomic,retain)UILabel *type;
@property(nonatomic,retain)NSMutableArray *rainDays;
@property(nonatomic,retain)NSString *ntitle;
@property(nonatomic,retain)NSString *emmcd;
@property(nonatomic,retain)NSString *dist;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *myActivity;

+(id)shareRain2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTitle:(NSString *)tit withEmmcd:(NSString *)emmcdt withDist:(NSString *)disti;
- (void)addRainItem:(NSMutableArray *)Items;
-(IBAction)removePin:(id)sender;

@end
