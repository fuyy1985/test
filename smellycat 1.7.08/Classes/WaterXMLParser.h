//
//  WaterXMLParser.h
//  navag
//
//  Created by Heiby He on 09-4-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"

@interface WaterCrossProjectInfo : NSObject
{
    NSString *ennmcd;
    NSString *ennm;
    
    NSString *xhhsw;  //校核洪水位
    NSString *xxsw;   //汛限水位
    NSString *jjsw;   //警戒水位
    NSString *dqsw;   //当前水位
    NSString *cjsj;   //采集时间
    NSString *bdgc;   //坝顶高程
    NSString *bxcl;   //坝型：按材料
    NSString *bxjg;   //坝型：按结构
}
@property (nonatomic,retain) NSString *ennmcd;
@property (nonatomic,retain) NSString *ennm;
@property (nonatomic,retain) NSString *xhhsw;
@property (nonatomic,retain) NSString *xxsw;
@property (nonatomic,retain) NSString *jjsw;
@property (nonatomic,retain) NSString *dqsw;
@property (nonatomic,retain) NSString *cjsj;
@property (nonatomic,retain) NSString *bdgc;
@property (nonatomic,retain) NSString *bxcl;
@property (nonatomic,retain) NSString *bxjg;
@end



@interface WaterInfo : NSObject
{
	NSString* sttp;
	NSString* stnm;
	NSString* sttpname;
	NSString* ymdhm;
	NSString* jjz;
	NSString* zu;
	NSString* jjsw;
	NSString* bzz;
	NSString* rvnm;
	NSString* subnm;
	NSString* stcdt;
	NSString* xian;
	NSString *lat;
	NSString *lon;
}
+(id)waterinfo;
@property(copy)NSString* sttp;
@property(copy)NSString* stnm;
@property(copy)NSString* sttpname;
@property(copy)NSString* ymdhm;
@property(copy)NSString* jjz;
@property(copy)NSString* zu;
@property(copy)NSString* jjsw;
@property(copy)NSString* bzz;
@property(copy)NSString* rvnm;
@property(copy)NSString* subnm;
@property(copy)NSString* stcdt;
@property(copy)NSString* xian;
@property(copy)NSString *lat;
@property(copy)NSString *lon;
@end


//////////////////////////////////////////////////////////////
@class WaterTableController;
@interface WaterXMLParser : Parser {
	WaterInfo *Item;
	NSMutableString *contentOfCurrentElement;
	WaterTableController *target;
}
@property(nonatomic,retain)WaterTableController *target;
@end

/////////////////////////////////////////////////////////////

@interface WaterCountXMLParser : Parser
{
	NSMutableArray *Count;
	NSMutableString *contentOfCurrentElement;
}
@end

////////////////////////////////////////////////////////////
@interface WaterSimpleXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
}
@end

///////////////////////////////////////
@interface WaterInfoXmlParser : Parser {
	NSMutableArray *Item;
	NSMutableString *contentOfCurrentElement;
}
@end


@interface WaterPacTypeInfo : NSObject {
	NSString *wsttp;
	NSString *wsttpName;
	NSString *wc;
}

@property (nonatomic,retain) NSString *wsttp; 
@property (nonatomic,retain) NSString *wsttpName;
@property (nonatomic,retain) NSString *wc;
@end

@interface WaterPTListViewXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	WaterPacTypeInfo *Items;
}
@end

///////////////////////////////////////
@interface WaterSInfoXmlParser : Parser {
	NSMutableArray *Item;
	NSMutableString *contentOfCurrentElement;
}
@end

////////////////////////////////////////////////////////////
@interface WaterStaticXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
}
@end

////////////////////////////////////////////////////////////
@interface WaterTotalStringXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
}
@end

////////////////////////////////////////////////////////////
@interface WaterMStaticXMLParser : Parser
{
    WaterCrossProjectInfo *item;
	NSMutableString *contentOfCurrentElement;
}
@end


