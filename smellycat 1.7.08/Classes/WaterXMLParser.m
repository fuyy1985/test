//
//  WaterXMLParser.m
//  navag
//
//  Created by Heiby He on 09-4-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WaterXMLParser.h"
#import "smellycatViewController.h"
#import "WaterInfoController.h"
#import "WaterSInfoController.h"
#import "FlowLeftViewController.h"

@implementation WaterCrossProjectInfo
@synthesize xhhsw,xxsw,jjsw,dqsw,cjsj,bdgc,bxcl,bxjg;
@synthesize ennmcd,ennm;

- (void)dealloc
{
    [ennmcd release];
    [ennm release];
    
    [xhhsw release];
    [xxsw release];
    [jjsw release];
    [dqsw release];
    [cjsj release];
    [bdgc release];
    [bxcl release];
    [bxjg release];
    [super dealloc];
}
@end


@implementation WaterInfo

@synthesize sttp,stnm,sttpname,ymdhm,jjz,zu,jjsw,bzz,rvnm,subnm,stcdt,xian,lat,lon;
+(id)waterinfo{
	return [[self alloc] init];
}
-(void)dealloc{
	[sttp release];
	[stnm release];
	[sttpname release];
	[ymdhm release];
	[jjz release];
	[zu release];
	[jjsw release];
	[bzz release];
	[rvnm release];
	[subnm release];
	[stcdt release];
	[xian release];
	[lat release];
	[lon release];
	[super dealloc];
}
@end


//////////////////////////////////////////////////////////////////

@implementation WaterXMLParser

@synthesize target;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
        Item = [WaterInfo waterinfo] ;
        return;
    }
	
    if ([[elementName lowercaseString] isEqualToString:@"sttp"]) {
		contentOfCurrentElement=[NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"stnm"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"sttpname"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"ymdhm"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"jjz"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"zu"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"jjsw"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"bzz"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"rvnm"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"subnm"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"stcdt"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"xian"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"x"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"y"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else{
		contentOfCurrentElement=nil;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
    
	if([elementName isEqualToString:@"Table"]){
		//add to list
		[target performSelectorOnMainThread:@selector(addData:) withObject:Item waitUntilDone:YES];
		
	}else if([[elementName lowercaseString] isEqualToString:@"sttp"]) {
		Item.sttp=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"stnm"]) {
		Item.stnm=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
    }else if([[elementName lowercaseString] isEqualToString:@"sttpname"]) {
		Item.sttpname = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"ymdhm"]) {
		Item.ymdhm = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"jjz"]) {
		Item.jjz = (contentOfCurrentElement==nil?@"-":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"zu"]) {
		Item.zu = (contentOfCurrentElement==nil?@"-":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"jjsw"]) {
		Item.jjsw = (contentOfCurrentElement==nil?@"-":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"bzz"]) {
		Item.bzz = (contentOfCurrentElement==nil?@"-":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"rvnm"]) {
		Item.rvnm = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"subnm"]) {
		Item.subnm = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"stcdt"]) {
		Item.stcdt = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"xian"]) {
		Item.xian = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"x"]) {
		Item.lon = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"y"]) {
		Item.lat = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentOfCurrentElement) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [contentOfCurrentElement appendString:string];
    }
}
-(void)dealloc{
	[super dealloc];
	[target release];
}

@end

////////////////////////////////////////////////////////////////////

@implementation WaterCountXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if ([elementName isEqualToString:@"Table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
        Count = [NSMutableArray array];
        return;
    }else if([[elementName lowercaseString] isEqualToString:@"sttp"]) {
		contentOfCurrentElement=[NSMutableString string];
    }else if([[elementName lowercaseString] isEqualToString:@"sttpname"]) {
		contentOfCurrentElement=[NSMutableString string];
    }else if([[elementName lowercaseString] isEqualToString:@"c"]){
		contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
	if([elementName isEqualToString:@"Table"]){
		//add to list
	//	WaterController *wc=[WaterController sharedWater];
		//[rv addCount:Count];
		//[wc performSelectorOnMainThread:@selector(addCount:) withObject:Count waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"sttp"]) {
		[Count insertObject:(contentOfCurrentElement==nil?@"":contentOfCurrentElement) atIndex:0];
    }else if([[elementName lowercaseString] isEqualToString:@"sttpname"]){
		[Count insertObject:(contentOfCurrentElement==nil?@"":contentOfCurrentElement) atIndex:1];
	}else if([[elementName lowercaseString] isEqualToString:@"c"]){
		[Count insertObject:(contentOfCurrentElement==nil?@"":contentOfCurrentElement) atIndex:2];
	}
}	
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentOfCurrentElement) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [contentOfCurrentElement appendString:string];
    }
}

-(void)dealloc{
	[super dealloc];
}
@end

////////////////////////////////////////////////////////////////////////////

@implementation WaterSimpleXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if([[elementName lowercaseString] isEqualToString:@"c"]){
		contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
	if([[elementName lowercaseString] isEqualToString:@"c"]){
		//Water3Controller *water3=[Water3Controller sharedWater3];
		//[water3 performSelectorOnMainThread:@selector(showListView:) withObject:contentOfCurrentElement waitUntilDone:NO];
	}
}	
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentOfCurrentElement) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [contentOfCurrentElement appendString:string];
    }
}

-(void)dealloc{
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////

@implementation WaterInfoXmlParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if ([elementName isEqualToString:@"Table1"]) {
        Item=[NSMutableArray array];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"name"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"value"]){
		contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
	if([elementName isEqualToString:@"Table1"]){
		//add segment
		WaterInfoController *ric=[WaterInfoController sharedWater];
		[ric performSelectorOnMainThread:@selector(getWaterInfo:) withObject:Item waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		[Item insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"value"]){
		[Item insertObject:contentOfCurrentElement atIndex:1];
	}
}	
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (contentOfCurrentElement) {
		// If the current element is one whose content we care about, append 'string'
		// to the property that holds the content of the current element.
		/*
		NSString *str = [string stringByReplacingOccurrencesOfString: @"\n" withString:@""];
		str = [str stringByReplacingOccurrencesOfString: @"\r" withString:@""];
		str = [str stringByReplacingOccurrencesOfString: @" " withString:@""];
		[contentOfCurrentElement appendString:str];
		*/
		[contentOfCurrentElement appendString:string];

	}
}

-(void)dealloc{
	[super dealloc];
}

@end


@implementation WaterPacTypeInfo
@synthesize wsttp,wsttpName,wc;

- (void) dealloc
{
	[wsttp release];
	[wsttpName release];
	[wc release];
	[super dealloc];
}
@end



@implementation WaterPTListViewXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[[WaterPacTypeInfo alloc] init];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"sttp"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"sttpname"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"c"]){
		contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
    
	if([elementName isEqualToString:@"Table"]){
		//add to list
		smellycatViewController *tc=[smellycatViewController sharedCat];
		[tc performSelectorOnMainThread:@selector(getWaterPTList:) withObject:Items waitUntilDone:YES];
		[Items release];
	}else if([[elementName lowercaseString] isEqualToString:@"sttp"]){
		Items.wsttp=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sttpname"]){
		Items.wsttpName=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"c"]){
		Items.wc=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (contentOfCurrentElement) {
		// If the current element is one whose content we care about, append 'string'
		// to the property that holds the content of the current element.
		NSString *str = [string stringByReplacingOccurrencesOfString: @"\n" withString:@""];
		str = [str stringByReplacingOccurrencesOfString: @"\r" withString:@""];
		str = [str stringByReplacingOccurrencesOfString: @" " withString:@""];
		[contentOfCurrentElement appendString:str];
	}
}
@end

////////////////////////////////////////////////////////////

@implementation WaterSInfoXmlParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if ([elementName isEqualToString:@"Table1"]) {
        Item=[NSMutableArray array];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"name"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"value"]){
		contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
	if([elementName isEqualToString:@"Table1"]){
		//add segment
		WaterSInfoController *ric=[WaterSInfoController sharedWater];
		[ric performSelectorOnMainThread:@selector(getWaterInfo:) withObject:Item waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		[Item insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"value"]){
		[Item insertObject:contentOfCurrentElement atIndex:1];
	}
}	
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentOfCurrentElement) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [contentOfCurrentElement appendString:string];
    }
}

-(void)dealloc{
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////////////////////
@implementation WaterStaticXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if([[elementName lowercaseString] isEqualToString:@"string"]){
		contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
	if([[elementName lowercaseString] isEqualToString:@"string"]){
		FlowLeftViewController *water3=[FlowLeftViewController shareflowleft];
		NSString *item = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		[water3 performSelectorOnMainThread:@selector(getSpecialData:) withObject:item waitUntilDone:YES];
	}
}	
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentOfCurrentElement) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [contentOfCurrentElement appendString:string];
    }
}

-(void)dealloc{
	[super dealloc];
}

@end

/**************WaterTotalStr*******************/
////////////////////////////////////////////////////////////////////////////
@implementation WaterTotalStringXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if([[elementName lowercaseString] isEqualToString:@"string"]){
		contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
	if([[elementName lowercaseString] isEqualToString:@"string"]){
		smellycatViewController *punkCat=[smellycatViewController sharedCat];
		[punkCat performSelectorOnMainThread:@selector(getWaterListByTypeString:) withObject:contentOfCurrentElement waitUntilDone:YES];
	}
}	
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentOfCurrentElement) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [contentOfCurrentElement appendString:string];
    }
}

-(void)dealloc{
	[super dealloc];
}

@end


////////////////////////////////////////////////////////////////////////////
@implementation WaterMStaticXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if([elementName isEqualToString:@"Table"]){
		item = [[[WaterCrossProjectInfo alloc] init] autorelease];
    } else if([elementName isEqualToString:@"ennmcd"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"ennm"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"校核洪水位"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"汛限水位"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"警戒水位"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"实时水位"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"采集时间"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"坝顶高程_x0028_m_x0029_"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"主坝类型_x0028_材料分_x0029_"]) {
        contentOfCurrentElement=[NSMutableString string];
    } else if([elementName isEqualToString:@"主坝类型_x0028_结构分_x0029_"]) {
        contentOfCurrentElement=[NSMutableString string];
	}else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
        elementName = qName;
    }
	if([elementName isEqualToString:@"Table"]){
		FlowLeftViewController *water3=[FlowLeftViewController shareflowleft];
		[water3 performSelectorOnMainThread:@selector(getWaterCrossProjectInfo:) withObject:item waitUntilDone:YES];
    } else if([elementName isEqualToString:@"ennmcd"]) {
        item.ennmcd = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"ennm"]) {
        item.ennm = contentOfCurrentElement;
	} else if([elementName isEqualToString:@"校核洪水位"]) {
        item.xhhsw = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"汛限水位"]) {
        item.xxsw = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"警戒水位"]) {
        item.jjsw = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"实时水位"]) {
        item.dqsw = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"采集时间"]) {
        item.cjsj = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"坝顶高程_x0028_m_x0029_"]) {
        item.bdgc = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"主坝类型_x0028_材料分_x0029_"]) {
        item.bxcl = contentOfCurrentElement;
    } else if([elementName isEqualToString:@"主坝类型_x0028_结构分_x0029_"]) {
        item.bxjg = contentOfCurrentElement;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentOfCurrentElement) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        NSString *strN = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *strW = [strN stringByReplacingOccurrencesOfString:@"        " withString:@""];
        [contentOfCurrentElement appendString:strW];
    }
}

-(void)dealloc{
	[super dealloc];
}

@end



