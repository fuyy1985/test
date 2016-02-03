//
//  LocationInfo.h
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocationInfo.h"


@implementation LocationInfo

@synthesize pac, pacname;
+(id)locationinfo{
	return [[self alloc] init];
}
-(id)infoWithDefaultValue{
	self.pac=@"000000";
	self.pacname=@"全部";
	return self;
}
-(void)dealloc{
	[pac release];
	[pacname release];
	[super dealloc];
}
@end
