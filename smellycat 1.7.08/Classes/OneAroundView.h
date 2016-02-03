//
//  OneAroundView.h
//  smellycat
//
//  Created by GPL on 13-1-30.
//
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
#import "WorkXMLParser.h"
@class OneAroundView;
@protocol OneAroundViewDelegate
-(void)dealWithAroundPacType:(OneAroundView *)myView convertProjectType:(NSInteger)typeInt;
@end

@interface TDABadgeView : UIView
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

@interface OneAroundView : UIView {
	id <OneAroundViewDelegate> delegate;
	UIButton *myButton;
	NSString *badgeNumber;
}

@property(nonatomic,assign) id <OneAroundViewDelegate> delegate;
@property(nonatomic,retain) NSString *badgeNumber;
-(id)initWithFrame:(CGRect)frame WithImage:(UIImage *)imageType convertWData:(NSString *)info;
-(IBAction)drawWaterPointAndSPopver:(id)sender;

@end
