//
//  SHisTypAnnotation.m
//  smellycat
//
//  Created by apple on 10-11-27.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "SHisTypAnnotation.h"
@implementation SHisTypAnnotation
@synthesize coordinate,TyphShowInfo;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
	return self;
}

- (NSString *)title
{
	if (TyphShowInfo!=nil) {
		return [NSString stringWithFormat:@"%@",[TyphShowInfo stringByReplacingOccurrencesOfString:@" " withString:@""]];
	}
    return @"历史台风";
}


- (void) dealloc
{
	[TyphShowInfo release];
	[super dealloc];
}

@end

