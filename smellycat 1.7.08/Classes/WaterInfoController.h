//
//  WaterInfoController.h
//  navag
//
//  Created by Heiby He on 09-9-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WaterInfoController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTable;
	NSMutableArray *hisc;
	NSString *waterEnnmcd;
	NSString *waterName;
	UILabel *titleLabel;
	UIActivityIndicatorView *myActivity;
}

@property (nonatomic, retain) UITableView *myTable;
@property (nonatomic, retain) NSMutableArray *hisc;
@property (nonatomic, retain) NSString *waterEnnmcd;
@property (nonatomic,retain ) NSString *waterName;
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *myActivity;


+(id)sharedWater;
- (void)getWaterInfo:(NSMutableArray *)item;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTitle:(NSString *)tit withEmmcd:(NSString *)emmcdt withDist:(NSString *)disti;
-(IBAction)removePin:(id)sender;

@end
