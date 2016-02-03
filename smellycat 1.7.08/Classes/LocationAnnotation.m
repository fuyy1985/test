//
//  LocationAnnotation.m
//  smellycat
//
//  Created by apple on 10-11-11.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "LocationAnnotation.h"
@implementation LocationAnnotation
@synthesize coordinate,customPointName,customPointData,type,titleData,subtitleData;
@synthesize subType;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
	return self;
}

- (NSString *)title
{
	NSString *titleStr = [self.titleData length]>0?self.titleData:@"--";
	NSString *groupStr =[NSString stringWithFormat:@""];
	NSString *pointName = [NSString stringWithFormat:@"%@",self.customPointName];
	if ([self.type isEqualToString:@"雨情"]) {
		groupStr =[NSString stringWithFormat:@"%@:%@mm",pointName,titleStr];
	} else if ([self.type isEqualToString:@"水情"]) {
		groupStr =[NSString stringWithFormat:@"%@:%@米",pointName,titleStr];
	} else if ([self.type isEqualToString:@"工情"]||[self.type isEqualToString:@"搜雨情"]||[self.type isEqualToString:@"搜水情"]||[self.type isEqualToString:@"搜工情"]) {
		groupStr = [NSString stringWithFormat:@"%@",titleData];
	}
	if ([pointName length]==0) {
		groupStr =[NSString stringWithFormat:@"获取站点信息失败"];
	}
	return groupStr ;
}
- (NSString *)subtitle{
	NSMutableString *subGroupStr=[NSMutableString stringWithFormat: @""];
	if ([self.type isEqualToString:@"水情"]&&[self.subtitleData floatValue]>0) {
		subGroupStr = [NSMutableString stringWithFormat:@"超警(限):%@米",self.subtitleData];
	} else {
		subGroupStr = nil;
	}
	if ([self.customPointName length]==0) {
		subGroupStr =nil;
	}
	return subGroupStr;
}

- (void) dealloc
{
	[customPointData release];
	[customPointName release];
	[type release];
	[titleData release];
	[subtitleData release];
    [subType release];
	//[totalTitle release];
	[super dealloc];
}

@end
