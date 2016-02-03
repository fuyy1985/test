//
//  OneWaterView.h
//  smellycat
//
//  Created by apple on 10-11-10.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterXMLParser.h"
@class WaterPacTypeInfo;
@class OneWaterView;
@protocol OneWaterViewDelegate
-(void)dealWithWaterPacType:(OneWaterView *)myView convertWaterType:(NSInteger)typeInt;
@end

@interface TDWBadgeView : UIView
{
	NSUInteger width;
	NSString *badgeNumber;
	UIFont *font;
	UIColor *badgeColor;
}
@property (nonatomic, readonly) NSUInteger width;
@property (nonatomic, assign) NSString *badgeNumber;
@property (nonatomic, retain) UIColor *badgeColor;
- (id) initWithFrame:(CGRect)frame myBadgeNumber:(NSString *)mybadNum;
@end

@class WaterPacTypeInfo;
@interface OneWaterView : UIView {
	id <OneWaterViewDelegate> delegate;
	UIButton *myButton;
	NSString *badgeNumber;
}

@property(nonatomic,assign) id <OneWaterViewDelegate> delegate;
@property(nonatomic,retain) NSString *badgeNumber;
-(id)initWithFrame:(CGRect)frame WithImage:(UIImage *)imageType convertWData:(NSString *)info;
-(IBAction)drawWaterPointAndSPopver:(id)sender;

@end
