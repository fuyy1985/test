//
//  MyChart.m
//  navag
//
//  Created by Heiby He on 09-4-2.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MyChart.h"
#import "RainXmlParser.h"

@implementation P_Point
@synthesize x,y;
@end


////////////////////////////////////////
@implementation MyChart
@synthesize data,mRainDays,convertData;

- (id)initWithFrame:(CGRect)frame with:(NSMutableArray *)dataRain {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
		[dataRain retain];
		self.convertData = dataRain;
		if ([self.convertData count] ==0) {
			NSString *temStr =[NSString stringWithFormat:@"0"];
			for (int i=0; i<7; i++) {
				[self.convertData addObject:temStr];
			}
		}
		self.backgroundColor=[UIColor whiteColor];
		self.data=[[NSMutableArray alloc] init];
		self.mRainDays=[[NSMutableArray alloc] init];
		//316>=p.x>=20
		//260>=p.y>=20
		
		int iScale=[self getScale:convertData];
		P_Point *pInfo = [[P_Point alloc] init];
		pInfo.x = iScale;
		pInfo.y = 0;
		[data addObject:pInfo];
		[pInfo release];pInfo=nil;
		
		for(int i=0; i<[dataRain count]; i++)	
		{
			float rainDay= [[convertData objectAtIndex:i] floatValue];
			P_Point *pInfoT = [[P_Point alloc] init];
			pInfoT.y=260-((rainDay*240)/iScale);
			pInfoT.x=((41*i)+30);
			[data addObject:pInfoT];
			[pInfoT release];pInfoT = nil;
			[mRainDays addObject:[convertData objectAtIndex:i]];
		}
	} 
	return self;
}

- (int)getScale:(NSMutableArray *)rainDays{
	int intScale = 10;
	float rainDay=[[rainDays objectAtIndex:0] floatValue];
	float rainDay1=[[rainDays objectAtIndex:1] floatValue];
	
	for(int j=1; j<7; j++)
	{
		rainDay1 = [[rainDays objectAtIndex:j] floatValue];
		if(rainDay < rainDay1)
		{
			rainDay= rainDay1;
		}
	}
	
	if(rainDay < 10)
		intScale=10;
	else if(rainDay<20)
		intScale=20;
	else if(rainDay<30)
		intScale=30;
	else if(rainDay<40)
		intScale=40;
	else if(rainDay<50)
		intScale=50;
	else if(rainDay<80)
		intScale=80;
	else if(rainDay<100)
		intScale=100;
	else if(rainDay<120)
		intScale=120;
	else if(rainDay<240)
		intScale=240;
	else
		intScale=360;
	
	return intScale;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context=UIGraphicsGetCurrentContext();
	
	NSString *title=[NSString stringWithFormat:@"降雨量（mm）"];
	[title drawAtPoint:CGPointMake(4.0,0.0) withFont:[UIFont systemFontOfSize:11]];
	
	//画坐标系
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(context, 2.0);
	
	CGContextMoveToPoint(context, 14, 20);
	CGContextAddLineToPoint(context, 20.0, 14.0);
	CGContextAddLineToPoint(context, 26, 20);
	
	CGContextMoveToPoint(context, 20.0, 14.0);
	CGContextAddLineToPoint(context, 20, 260);
	CGContextAddLineToPoint(context, 316, 260);
	CGContextAddLineToPoint(context, 310, 254);
	
	CGContextMoveToPoint(context, 316, 260);
	CGContextAddLineToPoint(context, 310, 266);
	CGContextStrokePath(context);
	
	//画横向刻度线
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(context, 0.3);
	
	P_Point *pm=[data objectAtIndex:0];
	int iMax=pm.x;
	for(int i=0;i<10;i++){
		CGContextMoveToPoint(context, 20.0, 20.0+24.0*i);
		CGContextAddLineToPoint(context, rect.size.width, 20.0+24.0*i);
		CGContextStrokePath(context);
		
		NSString *value=[NSString stringWithFormat:@"%d",(iMax/10)*(10-i)];
		[value drawAtPoint:CGPointMake(2.0,10.0+24.0*i) withFont:[UIFont systemFontOfSize:11]];
	}
	[[NSString stringWithFormat:@"%d",iMax] drawAtPoint:CGPointMake(2.0,10) withFont:[UIFont systemFontOfSize:11]];
	[@"0" drawAtPoint:CGPointMake(2.0,250) withFont:[UIFont systemFontOfSize:11]];
	
	//画垂直刻度线
	NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormat setDateFormat: @"MM-dd"]; 
	
	NSDate *offsetDate=[[NSDate date] addTimeInterval:-24*8*3600];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *offsetComponents = [gregorian components:NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate:offsetDate];
	[offsetComponents setHour:24];

	NSDate *startDate = [gregorian dateFromComponents:offsetComponents];
	[gregorian release];
	for(int j=0;j<7;j++){
		NSString *time=[dateFormat stringFromDate: startDate];
		[time drawInRect:CGRectMake(25+41.0*j,260.0,40,30) withFont:[UIFont systemFontOfSize:11.0]];
		startDate=[startDate addTimeInterval:24*3600];
	}
	CGContextSetLineWidth(context, 2.0);
	for(int k=0;k<7;k++){
		CGContextMoveToPoint(context, 60.0+41*k, 260.0);
		CGContextAddLineToPoint(context, 60.0+41*k, 255);
		CGContextStrokePath(context);
	}
	
	//画数据
	//CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
	//CGContextSetLineWidth(context, 2.0);
	
	CGContextSetRGBFillColor(context, 0.4, 0.6, 1.0, 1.0);
	for(int i=1;i<[data count];i++){
		P_Point *p=[data objectAtIndex:i];
		CGRect rc=CGRectMake(p.x, p.y, 21, 260-p.y);
		CGContextFillRect(context, rc);
		CGContextStrokePath(context);
		
		if([[mRainDays objectAtIndex:i-1] floatValue] > 0)
		{
			NSString *value=[NSString stringWithFormat:@"%.1f",[[mRainDays objectAtIndex:i-1] floatValue]];
			[value drawAtPoint:CGPointMake(p.x+2, p.y-15) withFont:[UIFont systemFontOfSize:12]];
		}
	}
}
		
				
		
- (void)dealloc {
	[data release];
	[convertData release]; convertData = nil;
	[data release]; data = nil;
	[mRainDays release];
	[mRainDays release]; mRainDays = nil;
	[super dealloc];
}
@end
