//
//  SLocationAnnotation.m
//  smellycat
//
//  Created by apple on 10-11-27.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "SLocationAnnotation.h"


@implementation SLocationAnnotation
@synthesize coordinate,customPointName,customPointData,type;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
	return self;
}

- (NSString *)title
{		
	NSString *str= [NSString stringWithFormat:@"%@",self.customPointName];
    return str;
}


- (void) dealloc
{
	[customPointData release];
	[customPointName release];
	[type release];
	[super dealloc];
}

@end

