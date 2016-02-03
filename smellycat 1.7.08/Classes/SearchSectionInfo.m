//
//  SearchSectionInfo.m
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import "SearchSectionInfo.h"

@implementation SearchSectionInfo
@synthesize sectionname,searchInfos;
- (void)dealloc
{
    [sectionname release];
    [searchInfos release];
    [super dealloc];
}
@end
