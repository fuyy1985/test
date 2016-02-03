//
//  WorkXMLParser.h
//  smellycat
//
//  Created by apple on 10-12-11.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

@interface WorkInfo : NSObject
{
	NSString *ennmcd;
	NSString *ennm;
	NSString *dsnm;
	NSString *en_gr;
	NSString *grnm;
	NSString *standLon;
	NSString *standLat;
	NSString *satelliteLon;
	NSString *satelliteLat;
    
    NSString *isOver;//0表示正常，1表示超
    
    NSString *count;
    NSString *para0;
    NSString *_value0;
    NSString *_unit0;
    NSString *_para1;
    NSString *_value1;
    NSString *_unit1;
}
+(id)workinfo;
@property(copy)NSString *ennmcd;
@property(copy)NSString *ennm;
@property(copy)NSString *dsnm;
@property(copy)NSString *en_gr;
@property(copy)NSString *grnm;
@property(copy)NSString *standLon;
@property(copy)NSString *standLat;
@property(copy)NSString *satelliteLon;
@property(copy)NSString *satelliteLat;
@property(copy)NSString *count;

@property(copy)NSString *isOver;

@property(nonatomic,retain) NSString *para0;
@property(copy) NSString *value0;
@property(copy) NSString *unit0;
@property(copy) NSString *para1;
@property(copy) NSString *value1;
@property(copy) NSString *unit1;
@end

//////////////////////////////////////////////////

@interface WorkCountXMLParser : Parser {
	WorkInfo *item;
	NSMutableString *contentOfCurrentElement;
}
@property (nonatomic,retain) WorkInfo *item;

@end

/////////////////////////////////////////////////
@class WorkTableController;
@interface WorkXMLParser : Parser
{
	WorkTableController *target;
	WorkInfo *item;
	NSMutableString *contentOfCurrentElement;
}
@property(nonatomic,retain)WorkTableController *target;
@property(nonatomic,retain) WorkInfo *item;
@end


/////////////////////////////////////////////////

@interface WorkTableNameXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	NSMutableArray *item2;
	NSInteger nums;
}
@end

//////////////////////////////////////////////////

@interface WorkDetailXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	NSMutableArray *item;
}
@end

/////////////////////////////////////////////////

@interface WorkSTableNameXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	NSMutableArray *item2;
	NSInteger nums;
}
@end

//////////////////////////////////////////////////

@interface WorkSDetailXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	NSMutableArray *item;
}
@end

//////////////////////////////////////////////////

@interface WorkZDCountXMLParser : Parser {
	NSMutableString *contentOfCurrentElement;
}

@end

//////////////////////////////////////////////////

@interface WorkJSONXMLParser : Parser {
	NSMutableString *contentOfCurrentElement;
}

@end

/////////////////////////////////////////////
@interface ProjectNameAndNumberXMLParser : Parser {
	NSMutableString *contentOfCurrentElement;
	WorkInfo *items;
}
@end