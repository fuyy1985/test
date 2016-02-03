//
//  MyChart.h
//  navag
//
//  Created by Heiby He on 09-4-2.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_Point : NSObject{
	int x;
	int y;
}
@property int x;
@property int y;
@end
//////////////////////////////////////////

@interface MyChart : UIView {
	NSMutableArray *data;
	NSMutableArray *mRainDays;
	NSMutableArray *convertData;
}
@property (nonatomic,retain) NSMutableArray *data;
@property (nonatomic,retain) NSMutableArray *mRainDays;
@property (nonatomic,retain) NSMutableArray *convertData;
- (id)initWithFrame:(CGRect)frame with:(NSMutableArray *)dataRain;
- (int)getScale:(NSMutableArray *)rainDays;
@end
