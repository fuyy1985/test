//
//  SearchXMLParser.h
//  navag
//
//  Created by Heiby He on 09-9-12.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

@interface SearchReaultInfo : NSObject
{
	NSString *srName;
	NSString *srSort;
	NSString *srType;
	NSString *srEnnmcd;
	NSString *srEngr;
	NSString *srDescription;
	NSString *srStandLng;
	NSString *srStandLat;
	NSString *srSateLng;
	NSString *srSateLat;
}
+(id)searchresultinfo;
@property(copy)NSString *srName;
@property(copy)NSString *srSort;
@property(copy)NSString *srType;
@property(copy)NSString *srEnnmcd;
@property(copy)NSString *srEngr;
@property(copy)NSString *srDescription;
@property(copy)	NSString *srStandLng;
@property(copy)	NSString *srStandLat;
@property(copy)	NSString *srSateLng;
@property(copy)	NSString *srSateLat;
@end

///////////////////////////////////////////////////

@class SearchInfoModel;
@interface SearchXMLParser : Parser {
	SearchInfoModel *item;
	NSMutableString *contentOfCurrentElement;
}
@end

/***************OK DOG*****************/
///////////////////////////////////////////////////
@interface SearchDogXMLParser : Parser {
	SearchReaultInfo *item;
	NSMutableString *contentOfCurrentElement;
}
@end
