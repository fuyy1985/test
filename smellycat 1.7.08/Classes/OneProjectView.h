//
//  OneProjectView.h
//  smellycat
//
//  Created by apple on 10-12-11.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
#import "WorkXMLParser.h"
@class OneProjectView;
@protocol OneProjectViewDelegate
-(void)dealWithProjectPacType:(OneProjectView *)myView convertProjectType:(NSInteger)typeInt;
@end

@interface TDPBadgeView : UIView
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

@interface OneProjectView : UIView {
	id <OneProjectViewDelegate> delegate;
	UIButton *myButton;
	NSString *badgeNumber;
}

@property(nonatomic,assign) id <OneProjectViewDelegate> delegate;
@property(nonatomic,retain) NSString *badgeNumber;
-(id)initWithFrame:(CGRect)frame WithImage:(UIImage *)imageType convertWData:(NSString *)info;
-(IBAction)drawWaterPointAndSPopver:(id)sender;

@end