//
//  SearchInfoModel.m
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import "SearchInfoModel.h"

@implementation SearchInfoModel
@synthesize srName,srSort,srType,srEnnmcd,srEngr,srDescription,srStandLng,srStandLat,srSateLng,srSateLat;

- (void)dealloc
{
    [srStandLng release];
	[srStandLat release];
	[srSateLng release];
	[srSateLat release];
	[srName release];
	[srSort release];
	[srType release];
	[srEnnmcd release];
	[srEngr release];
	[srDescription release];
	[super dealloc];
}
@end
