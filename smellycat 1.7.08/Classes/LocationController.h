//
//  LocationController.h
//  navag
//
//  Created by Heiby He on 09-8-28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ProvinceComponent 0
#define CityComponent 1
#define TownComponent 2
@class LocationController;
@protocol LocationControllerDelegate
-(void)dealLocationController:(LocationController *)myController withName:(NSString *)cname withPac:(NSString *)cpac;
@end

@interface LocationController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	IBOutlet	UIPickerView *picker;
	IBOutlet    UILabel *myLabel;
	NSTimer	*timer;
	NSMutableArray *provinces;
	NSMutableArray *citys;
	NSMutableArray *towns;
	NSInteger intProvince;
	NSInteger intCity;
	NSInteger intTown;
	NSInteger current;
	BOOL isOnlyChoose;
	UIButton *myButton;
	id <LocationControllerDelegate> delegate;
	
	BOOL isFirstLoad;
}
@property (retain, nonatomic) UIPickerView *picker;
@property (retain, nonatomic) UILabel *myLabel;
@property (nonatomic, retain) NSTimer *timer;
@property (retain, nonatomic) NSMutableArray *provinces;
@property (retain, nonatomic) NSMutableArray *citys;
@property (retain, nonatomic) NSMutableArray *towns;
@property (nonatomic) NSInteger intProvince;
@property (nonatomic) NSInteger intCity;
@property (nonatomic) NSInteger intTown;
@property (nonatomic) NSInteger current;
@property (nonatomic) BOOL isOnlyChoose;
@property (nonatomic,retain) IBOutlet UIButton *myButton;

@property (nonatomic,assign) id <LocationControllerDelegate> delegate;
@property (nonatomic) BOOL isFirstLoad;

- (NSInteger)getIndexofArray:(NSArray *)locations withKey:(NSString *)key;
- (NSString *)getAreaName;
-(IBAction)SaveArea:(id)sender;
-(IBAction)dismissPopover:(id)sender;
- (NSString *)getAreaname;

@end
