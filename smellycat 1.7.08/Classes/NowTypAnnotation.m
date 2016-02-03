//
//  NowTypAnnotation.m
//  smellycat
//
//  Created by apple on 10-11-17.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "NowTypAnnotation.h"

@implementation NowTypAnnotation
@synthesize coordinate,TyphShowInfo;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
	return self;
}

- (NSString *)title
{
	if (TyphShowInfo!=nil) {
		return [NSString stringWithFormat:@"%@",self.TyphShowInfo];
	}
    return @"未命名台风";
}


- (void) dealloc
{
	[TyphShowInfo release];
	[super dealloc];
}

@end
