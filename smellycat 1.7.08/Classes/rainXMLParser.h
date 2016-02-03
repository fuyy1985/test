//
//  rainXMLParser.h
//  smellycat
//
//  Created by apple on 10-11-1.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

@interface RainPacHourInfo : NSObject {
	NSString *count;
	NSString *distinct;
}

@property (nonatomic,retain) NSString *count; 
@property (nonatomic,retain) NSString *distinct;
@end

@interface RainInfo : NSObject
{
	NSString* stnm;
	NSString* rvnm;
	NSString* subnm;
	NSString* stcdt;
	NSString* dyp;
	NSString* dsc;
	NSString* lat;
	NSString* lon;
}
+(id)rainInfo;
@property(copy)NSString* stnm;
@property(copy)NSString* rvnm;
@property(copy)NSString* subnm;
@property(copy)NSString* stcdt;
@property(copy)NSString* dyp;
@property(copy)NSString* dsc;
@property(copy) NSString* lat;
@property(copy) NSString* lon;
@end


@interface RainPHListViewXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	RainPacHourInfo *Items;
}
@end

/////////////////////////////////////////////
@class Rain2Controller;
@interface RainDetailXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	NSMutableArray *Items;
	Rain2Controller *target2;
}
@property(nonatomic,retain)Rain2Controller *target2;
@end

/////////////////////////////////////////////
@class RainSDInfoController;
@interface RainSDetailXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
	NSMutableArray *Items;
	RainSDInfoController *target2;
}
@property(nonatomic,retain)RainSDInfoController *target3;
@end


////////////////////////////////////////////////////////////
@interface RainTotalStringXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
}
@end

////////////////////////////////////////////////////////////
@interface RainTwentyFourHourXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
}
@end





