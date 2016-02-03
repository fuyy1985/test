//
//  OneRainView.h
//  smellycat
//
//  Created by apple on 10-11-1.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rainXMLParser.h"
@class OneRainView;
@protocol OneRainViewDelegate
-(void)dealWithRainPacHour:(OneRainView *)myView convertRainType:(NSInteger)typeInt;
@end

@interface TDBadgeView : UIView
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

@class RainPacHourInfo;
@interface OneRainView : UIView {
	id <OneRainViewDelegate> delegate;
	UIButton *myButton;
	NSString *badgeNumber;
}

@property(nonatomic,assign) id <OneRainViewDelegate> delegate;
@property(nonatomic,retain) NSString *badgeNumber;
-(id)initWithFrame:(CGRect)frame WithImage:(UIImage *)imageType convertData:(NSString *)infoCount;
-(IBAction)drawRainPointAndSPopver:(id)sender;

@end
