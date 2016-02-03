//
//  rainXMLParser.m
//  smellycat
//
//  Created by apple on 10-11-1.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "rainXMLParser.h"
#import "smellycatViewController.h"
#import "Rain2Controller.h"
#import "RainSDInfoController.h"

@implementation RainPacHourInfo
@synthesize count,distinct;

- (void) dealloc
{
	[count release];
	[distinct release];
	[super dealloc];
}
@end

@implementation RainInfo
@synthesize stnm;
@synthesize rvnm;
@synthesize subnm;
@synthesize stcdt;
@synthesize dyp;
@synthesize dsc;
@synthesize lat;
@synthesize lon;

+(id)rainInfo{
	return [[self alloc] init];
}

-(void) dealloc{
	[stnm release];
	[rvnm release];
	[subnm release];
	[stcdt release];
	[dyp release];
	[dsc release];
	[lat release];
	[lon release];
	[super dealloc];
}
@end


@implementation RainPHListViewXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[[RainPacHourInfo alloc] init];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"count"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"dyp"]){
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
		[tc performSelectorOnMainThread:@selector(getRainPHList:) withObject:Items waitUntilDone:YES];
		[Items release];
	}else if([[elementName lowercaseString] isEqualToString:@"count"]){
		Items.count=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"dyp"]){
		Items.distinct=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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

@implementation RainSDetailXMLParser
@synthesize target3;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if ([elementName isEqualToString:@"Table"]) {
        Items=[NSMutableArray array];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"dy_1"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_3"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_4"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_5"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_6"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_7"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"x"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"y"]){
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
		RainSDInfoController *r2c=[RainSDInfoController shareSRain2];
		[r2c performSelectorOnMainThread:@selector(addSRainItem:) withObject:Items waitUntilDone:YES];
		return;
	}else if([[elementName lowercaseString] isEqualToString:@"dy_1"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_2"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_3"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_4"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_5"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_6"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_7"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"x"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
	}else if([[elementName lowercaseString] isEqualToString:@"y"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
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

-(void)dealloc{
	[target3 release];
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////

@implementation RainDetailXMLParser
@synthesize target2;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if ([elementName isEqualToString:@"Table"]) {
        Items=[NSMutableArray array];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"dy_1"]){
		contentOfCurrentElement=[[NSMutableString alloc] init];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_2"]){
		contentOfCurrentElement=[[NSMutableString alloc] init];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_3"]){
		contentOfCurrentElement=[[NSMutableString alloc] init];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_4"]){
		contentOfCurrentElement=[[NSMutableString alloc] init];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_5"]){
		contentOfCurrentElement=[[NSMutableString alloc] init];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_6"]){
		contentOfCurrentElement=[[NSMutableString alloc] init];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_7"]){
		contentOfCurrentElement=[[NSMutableString alloc] init];
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
		Rain2Controller *r2c=[Rain2Controller shareRain2];
		[r2c performSelectorOnMainThread:@selector(addRainItem:) withObject:Items waitUntilDone:YES];
		return;
	}else if([[elementName lowercaseString] isEqualToString:@"dy_1"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
		[contentOfCurrentElement release];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_2"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
		[contentOfCurrentElement release];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_3"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
		[contentOfCurrentElement release];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_4"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
		[contentOfCurrentElement release];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_5"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
		[contentOfCurrentElement release];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_6"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
		[contentOfCurrentElement release];
	}else if([[elementName lowercaseString] isEqualToString:@"dy_7"]){
		[Items insertObject:contentOfCurrentElement atIndex:0];
		[contentOfCurrentElement release];
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
	[target2 release];
	[super dealloc];
}

@end


/**************RAINTOTALSTRING*******************/
////////////////////////////////////////////////////////////////////////////
@implementation RainTotalStringXMLParser
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
		[punkCat performSelectorOnMainThread:@selector(getRainListByHourString:) withObject:contentOfCurrentElement waitUntilDone:YES];
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

/**************RAINTOTALSTRING*******************/
////////////////////////////////////////////////////////////////////////////
@implementation RainTwentyFourHourXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	if([[elementName lowercaseString] isEqualToString:@"boolean"]){
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
	if([[elementName lowercaseString] isEqualToString:@"boolean"]){
		smellycatViewController *punkCat=[smellycatViewController sharedCat];
		[punkCat performSelectorOnMainThread:@selector(get24HourRainfallIdentifier:) withObject:contentOfCurrentElement waitUntilDone:YES];
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



