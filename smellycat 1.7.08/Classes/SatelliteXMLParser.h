//
//  SatelliteXMLParser.h
//  smellycat
//
//  Created by apple on 11-7-6.
//  Copyright 2011年 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

//cat
@interface SatelliteTotalStringXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
}
@end

//dog
@interface SatelliteTotalStringDogXMLParser : Parser
{
	NSMutableString *contentOfCurrentElement;
}
@end