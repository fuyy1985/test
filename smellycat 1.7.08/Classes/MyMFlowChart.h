//
//  MyMFlowChart.h
//  GovOfQGJ
//
//  Created by apple on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFlow_Point : NSObject {
	float x;
	float y;
}

@property (nonatomic)float x;
@property (nonatomic)float y;
-(id)initWithX:(float)xZ Y:(float)yZ;

@end

@class MyMFlowChart;
@protocol MyMFlowChartDelegate
-(void)changeTheTitleStatus:(MyMFlowChart *)myPunkChartView withSignal:(NSInteger)punkSignal;
@end


@interface  MyMFlowChart: UIView {
	id <MyMFlowChartDelegate> delegate;
	NSMutableArray *data;
	NSArray *valueArray;
	NSArray *specialArray;
	BOOL isValueOK;
	int theMaxValue; 
	int theMinValue;
	int theZone;
	int numSquare;
	float heightOfSqure;
	NSMutableArray *dateValueArr;
	NSMutableArray *initialValueArr;
	NSMutableDictionary *specialDictionary;
}
@property (nonatomic,assign) id <MyMFlowChartDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *data;
@property (nonatomic,retain) NSArray *valueArray;
@property (nonatomic,retain) NSArray *specialArray;
@property (nonatomic) BOOL isValueOK;
@property (nonatomic) int theMaxValue;
@property (nonatomic) int theMinValue;
@property (nonatomic) int theZone;
@property (nonatomic) int numSquare;
@property (nonatomic) float heightOfSqure;
@property (nonatomic,retain) NSMutableArray *dateValueArr;
@property (nonatomic,retain) NSMutableArray *initialValueArr;
@property (nonatomic,retain) NSMutableDictionary *specialDictionary;
- (id)initWithFrame:(CGRect)frame withValue:(NSArray *)vArray withSpecial:(NSArray *)sArray;
-(void)checkHowToSetTheDrawZone:(int)temReallyHoldSqureNum;
- (void)getScaleValue:(NSArray *)temOnlyVArray withTheSArray:(NSArray *)temOnlySArray;
-(void)drawTheZeroLineForTrangleTime:(CGContextRef)context withCircleK:(int)t inHeight:(float)h isPlus:(float)f;
-(void)drawDangerousLine:(CGContextRef)context inThePoint:(CGPoint)originBottom;

@end
