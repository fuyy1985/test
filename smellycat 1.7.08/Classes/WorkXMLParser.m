//
//  WorkXMLParser.m
//  smellycat
//
//  Created by apple on 10-12-11.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "WorkXMLParser.h"
#import "smellycatViewController.h"
#import "Work1Controller.h"
#import "WorkTableController.h"
#import "Work3Controller.h"
#import "Work2Controller.h"
#import "Work3SController.h"
////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WorkInfo
@synthesize ennmcd,ennm,dsnm,en_gr,grnm,standLon,standLat,satelliteLon,satelliteLat,count,isOver;
@synthesize para0;
@synthesize value0 = _value0;
@synthesize unit0 = _unit0;
@synthesize para1 = _para1;
@synthesize value1 = _value1;
@synthesize unit1 = _unit1;
+(id)workinfo{
	return [[self alloc] init];
}
-(void)dealloc{
	[standLon release];
	[standLat release];
	[satelliteLon release];
	[satelliteLat release];
	[ennmcd release];
	[ennm release];
	[dsnm release];
	[en_gr release];
	[grnm release];
    [isOver release];
    
    [count release];
    [para0 release];
    [_value0 release];
    [_unit0 release];
    [_para1 release];
    [_value1 release];
    [_unit1 release];
	[super dealloc];
}

-(NSString*)para0
{
    NSString *strN = [para0 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *strW = [strN stringByReplacingOccurrencesOfString:@" " withString:@""];
    //_unit1!=nil 这个判断依据是没有办法的办法
    if ([strW isEqualToString:@"总库容"]||_unit1!=nil) {
        return strW;
    } else {
        return [NSString stringWithFormat:@"总%@",strW];
    }
}
@end

//////////////////////////////////////////////////////////

@implementation WorkCountXMLParser
@synthesize item;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if([elementName isEqualToString:@"Table"]){
		self.item = [WorkInfo workinfo];
		return;
	}else if([[elementName lowercaseString] isEqualToString:@"c"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"grnm"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]){
		contentOfCurrentElement=[NSMutableString string];
    }else if([[elementName lowercaseString] isEqualToString:@"property1"]){
		contentOfCurrentElement=[NSMutableString string];
    }else if([[elementName lowercaseString] isEqualToString:@"sumvalue"]){
		contentOfCurrentElement=[NSMutableString string];
    }else if([[elementName lowercaseString] isEqualToString:@"property2"]){
		contentOfCurrentElement=[NSMutableString string];
    }else if([[elementName lowercaseString] isEqualToString:@"maxvalue"]){
		contentOfCurrentElement=[NSMutableString string];
    }else if([[elementName lowercaseString] isEqualToString:@"unit1"]){
		contentOfCurrentElement=[NSMutableString string];
	} else{
		contentOfCurrentElement=nil;
	}
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
        elementName = qName;
    }
	if([elementName isEqualToString:@"Table"]){
		Work1Controller *work1=[Work1Controller sharedWork1];
		[work1 performSelectorOnMainThread:@selector(addNewCount:) withObject:item waitUntilDone:YES];
        self.item = nil;
	}else if([[elementName lowercaseString] isEqualToString:@"grnm"]){
		item.grnm=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]){
		item.en_gr=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"c"]){
		item.count=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"property1"]){
		item.para0=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sumvalue"]){
		item.value0=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"property2"]){
		item.para1=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"maxvalue"]){
		item.value1=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"unit1"]){
		item.unit0=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
    [item release];
	[super dealloc];
}

@end


////////////////////////////////////////////////////////////

@implementation WorkXMLParser

@synthesize target,item;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([[elementName lowercaseString] isEqualToString:@"table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
        self.item = [[WorkInfo workinfo] autorelease] ;
        return;
    }
	
    if ([[elementName lowercaseString] isEqualToString:@"ennmcd"]) {
		contentOfCurrentElement=[NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"ennm"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"dsnm"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"grnm"]) {
		contentOfCurrentElement = [NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"property1"]) {
		contentOfCurrentElement = [NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"value1"]) {
		contentOfCurrentElement = [NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"unit1"]) {
		contentOfCurrentElement = [NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"property2"]) {
		contentOfCurrentElement = [NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"value2"]) {
		contentOfCurrentElement = [NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"unit2"]) {
		contentOfCurrentElement = [NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"lato"]){
		contentOfCurrentElement=[NSMutableString string];
        
	}else if([[elementName lowercaseString] isEqualToString:@"lngo"]){
		contentOfCurrentElement=[NSMutableString string];
        
	}else if([[elementName lowercaseString] isEqualToString:@"lat"]){
		contentOfCurrentElement=[NSMutableString string];
        
	}else if([[elementName lowercaseString] isEqualToString:@"lng"]){
		contentOfCurrentElement=[NSMutableString string];
        
    }else if([[elementName lowercaseString] isEqualToString:@"isover"]) {
		contentOfCurrentElement = [NSMutableString string];
        
	}else{
        // The element isn't one that we care about, so set the property that holds the
        // character content of the current element to nil. That way, in the parser:foundCharacters:
        // callback, the string that the parser reports will be ignored.
        contentOfCurrentElement = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
        elementName = qName;
    }
    
	if([[elementName lowercaseString] isEqualToString:@"table"]){
		//add to list
		[target performSelectorOnMainThread:@selector(addData:) withObject:item waitUntilDone:YES];
		
	}else if([[elementName lowercaseString] isEqualToString:@"ennmcd"]) {
		item.ennmcd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
    }else if([[elementName lowercaseString] isEqualToString:@"ennm"]) {
		item.ennm = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"dsnm"]) {
		item.dsnm = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]) {
		item.en_gr = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"grnm"]) {
		item.grnm = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
        
    }else if([[elementName lowercaseString] isEqualToString:@"property1"]) {
		item.para0 = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
        
    }else if([[elementName lowercaseString] isEqualToString:@"value1"]) {
		item.value0 = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
        
    }else if([[elementName lowercaseString] isEqualToString:@"unit1"]) {
		item.unit0 = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
        
    }else if([[elementName lowercaseString] isEqualToString:@"property2"]) {
		item.para1 = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
        
    }else if([[elementName lowercaseString] isEqualToString:@"value2"]) {
		item.value1 = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
        
    }else if([[elementName lowercaseString] isEqualToString:@"unit2"]) {
		item.unit1 = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
    }else if([[elementName lowercaseString] isEqualToString:@"lato"]){
		item.standLat=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"lngo"]){
		item.standLon=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"lat"]){
		item.satelliteLat=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"lng"]){
		item.satelliteLon=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"isover"]) {
		item.isOver = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
    [item release];
	[target release];
	[super dealloc];
}

@end

///////////////////////////////////////////////////////////

@implementation WorkTableNameXMLParser
- (void)parserDidStartDocument:(NSXMLParser *)parser{
	nums=0;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	
	if ([elementName isEqualToString:@"datas"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
		item2=[NSMutableArray array];
        return;
    }
	
	if([[elementName lowercaseString] isEqualToString:@"name"]){
		contentOfCurrentElement=[NSMutableString string];
	}
	else if([[elementName lowercaseString] isEqualToString:@"value"]){
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
	if([elementName isEqualToString:@"datas"]){
		//add segment
		nums+=1;
		Work3Controller *work3=[Work3Controller sharedWork3];
		[work3 performSelectorOnMainThread:@selector(addSegment:) withObject:item2 waitUntilDone:YES];
	}
	else if([[elementName lowercaseString] isEqualToString:@"name"]){
		[item2 insertObject:contentOfCurrentElement atIndex:0];
		//item.tableName=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}
	else if([[elementName lowercaseString] isEqualToString:@"value"]){
		NSString *tvalue=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		//using the new logical
		//the index of the segment
		NSRange r=[tvalue rangeOfString:@"$"];
		if ((r.location+1) <= r.length) {
			[item2 insertObject:@"" atIndex:1];
		} else {
			[item2 insertObject:[tvalue substringFromIndex:(r.location+1)] atIndex:1];
		}
		
		//the type of the view tag---1 AS TableView,2 As WebView
		NSRange r1=[tvalue rangeOfString:@"-"];
		if ((r.location+1) <= r.length) {
			[item2 insertObject:@"" atIndex:2];
		} else {
			[item2 insertObject:[tvalue substringFromIndex:(r1.location+1)] atIndex:2];
		}		
		//the total string
		[item2 insertObject:tvalue atIndex:3];
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

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    //此次数据调用是在子线程中完成，因此当改变界面时候需要调用主线程来改变UI
	Work3Controller *work3=[Work3Controller sharedWork3];
    if(nums>0)
    {
        [work3 performSelectorOnMainThread:@selector(setSegIndexEqualZeroAndFetch) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [work3 performSelectorOnMainThread:@selector(disableTabBar) withObject:nil waitUntilDone:YES];
    }
}

-(void)dealloc{
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////

@implementation WorkDetailXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if ([elementName isEqualToString:@"Table1"]) {
        item=[NSMutableArray array];
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
		Work3Controller *work3=[Work3Controller sharedWork3];
		[work3 performSelectorOnMainThread:@selector(addList:) withObject:item waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		[item insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"value"]){
		[item insertObject:contentOfCurrentElement atIndex:1];
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

///////////////////////////////////////////////////////////

@implementation WorkSTableNameXMLParser

- (void)parserDidStartDocument:(NSXMLParser *)parser{
	nums=0;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	
	if ([elementName isEqualToString:@"Table1"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
		item2=[NSMutableArray array];
        return;
    }
	
	if([[elementName lowercaseString] isEqualToString:@"name"]){
		contentOfCurrentElement=[NSMutableString string];
	}
	else if([[elementName lowercaseString] isEqualToString:@"value"]){
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
		nums+=1;
		Work3SController *work3=[Work3SController sharedWork3];
		[work3 performSelectorOnMainThread:@selector(addSegment:) withObject:item2 waitUntilDone:YES];
	}
	else if([[elementName lowercaseString] isEqualToString:@"name"]){
		[item2 insertObject:contentOfCurrentElement atIndex:0];
		//item.tableName=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}
	else if([[elementName lowercaseString] isEqualToString:@"value"]){
		NSString *tvalue=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		NSRange r=[tvalue rangeOfString:@"$"];
		[item2 insertObject:[tvalue substringToIndex:r.location] atIndex:1];
		[item2 insertObject:[tvalue substringFromIndex:(r.location+1)] atIndex:2];
		//item.tableValue=[tvalue substringToIndex:r.location];
		//item.tableType=[tvalue substringFromIndex:(r.location+1)];
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

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	Work3SController *work3=[Work3SController sharedWork3];
	if(nums>0)work3.tabBar.selectedSegmentIndex=0;
	else work3.tabBar.enabled=NO;
}

-(void)dealloc{
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////

@implementation WorkSDetailXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if ([elementName isEqualToString:@"Table1"]) {
        item=[NSMutableArray array];
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
		Work3SController *work3=[Work3SController sharedWork3];
		[work3 performSelectorOnMainThread:@selector(addList:) withObject:item waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		[item insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"value"]){
		[item insertObject:contentOfCurrentElement atIndex:1];
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


///////////////////////////////////////////////////////////

@implementation WorkZDCountXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([[elementName lowercaseString] isEqualToString:@"string"]) {
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
		//add to list
		Work2Controller *tc=[Work2Controller sharedWork2];
		NSString *item = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		[tc performSelectorOnMainThread:@selector(getWorkZDCount:) withObject:item waitUntilDone:YES];
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


///////////////////////////////////////////////////////////

@implementation WorkJSONXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([[elementName lowercaseString] isEqualToString:@"string"]) {
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
		//add to list
		Work3SController *tc=[Work3SController sharedWork3];
		NSString *item = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		[tc performSelectorOnMainThread:@selector(getJSON:) withObject:item waitUntilDone:YES];
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

/////////////////////////////////////////////
@implementation ProjectNameAndNumberXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
        items=[WorkInfo workinfo];
        return;
    }
	
	if ([[elementName lowercaseString] isEqualToString:@"key"]) {
		contentOfCurrentElement=[NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"name"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"value"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else{
        // The element isn't one that we care about, so set the property that holds the 
        // character content of the current element to nil. That way, in the parser:foundCharacters:
        // callback, the string that the parser reports will be ignored.
        contentOfCurrentElement = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
    
	if([elementName isEqualToString:@"Table"]){
        smellycatViewController *nad=[smellycatViewController sharedCat];
		[nad performSelectorOnMainThread:@selector(getProjectListArray:) withObject:items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"key"]){
		items.ennmcd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		items.ennm=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"value"]){
		items.dsnm=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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



