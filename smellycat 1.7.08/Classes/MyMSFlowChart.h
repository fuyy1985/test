//
//  MyMFlowChart.h
//  GovOfQGJ
//
//  Created by apple on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterCrossProjectInfo;
@interface  MyMSFlowChart: UIView {
	NSMutableArray *data;
	NSArray *valueArray;
	WaterCrossProjectInfo *sInfo;
	BOOL isValueOK;
	int theMaxValue;
	int theMinValue;
	int theZone;
	int numSquare;
	float heightOfSqure;
	NSMutableArray *initialValueArr;
	NSMutableDictionary *specialDictionary;
}
@property (nonatomic,retain) NSMutableArray *data;
@property (nonatomic,retain) NSArray *valueArray;
@property (nonatomic,retain) WaterCrossProjectInfo *sInfo;
@property (nonatomic) BOOL isValueOK;
@property (nonatomic) int theMaxValue;
@property (nonatomic) int theMinValue;
@property (nonatomic) int theZone;
@property (nonatomic) int numSquare;
@property (nonatomic) float heightOfSqure;
@property (nonatomic,retain) NSMutableArray *initialValueArr;
@property (nonatomic,retain) NSMutableDictionary *specialDictionary;
- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)vArray withSpecial:(WaterCrossProjectInfo *)info;
-(void)checkHowToSetTheDrawZone:(int)temReallyHoldSqureNum;
- (void)getScaleValue:(NSArray *)temOnlyVArray;
-(void)drawTheZeroLineForTrangleTime:(CGContextRef)context withCircleK:(int)t inHeight:(float)h isPlus:(float)f;
-(void)drawDangerousLine:(CGContextRef)context inThePoint:(CGPoint)originBottom;
-(void)drawXHHSWLine:(CGContextRef)context inThePoint:(CGPoint)originBottom;
-(void)drawDQSWLine:(CGContextRef)context inThePoint:(CGPoint)originBottom;
@end
