//
//  OneTyphoonView.h
//  smellycat
//
//  Created by apple on 10-10-31.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OneTyphoonView;
@protocol OneTyphoonViewDelegate
-(void)dealWithNonActiveTyphoon:(OneTyphoonView *)myView;
-(void)dealWithNonActiveTyphoon:(OneTyphoonView *)myView convertTfID:(NSInteger)myTfid andWithTYName:(NSString *)myTfName;
@optional
-(void)dealWithActiveTyphoon:(OneTyphoonView *)myView convertTfID:(NSInteger)myTfid andWithTYName:(NSString *)myTfName;
@end


@class TFList;
@interface OneTyphoonView : UIView {
	id <OneTyphoonViewDelegate> delegate;
	UILabel *tfID;
	UIImageView *bottomImageView;
	UIImageView *tfImage;
	UILabel *tfName;
	UIButton *myButton;
	BOOL isActive;
	BOOL bottomSignal;
}
@property(nonatomic,assign) id <OneTyphoonViewDelegate> delegate;
@property(nonatomic,retain) UIImageView *bottomImageView;
@property(nonatomic) BOOL isActive;
@property(nonatomic) BOOL bottomSignal;
@property(nonatomic,retain) UILabel *tfName;
-(id)initWithFrame:(CGRect)frame typhoonInfo:(TFList *)tf nowTyphoonInfo:(NSMutableArray *)infoArray;
-(IBAction)jumpButtom:(id)sender;
-(IBAction)realJumpButtom:(id)sender;
-(void)down:(NSString *)add;
-(void)up:(NSString *)minus;
-(void)active:(NSString *)key;
@end
