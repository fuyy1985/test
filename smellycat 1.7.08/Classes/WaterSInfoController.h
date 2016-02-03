//
//  WaterInfoController.h
//  navag
//
//  Created by Heiby He on 09-9-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WaterSInfoController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTable;
	NSMutableArray *hisc;
	NSString *waterEnnmcd;
	NSString *waterName;
}

@property (nonatomic, retain) UITableView *myTable;
@property (nonatomic, retain) NSMutableArray *hisc;
@property (nonatomic, retain) NSString *waterEnnmcd;
@property (nonatomic,retain) NSString *waterName;

+(id)sharedWater;
- (void)getWaterInfo:(NSMutableArray *)item;
- (id)initWithNibName:(NSString *)nibNameOrNil withID:(NSString *)waterID withNM:(NSString *)waterNM bundle:(NSBundle *)nibBundleOrNil;
-(void)locationToPoint;

@end
