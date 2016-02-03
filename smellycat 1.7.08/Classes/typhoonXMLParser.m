//
//  typhoonXMLParser.m
//  smellycat
//
//  Created by apple on 10-9-28.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "typhoonXMLParser.h"
#import "smellycatViewController.h"
#import "smellydogViewController.h"
#import "TyphoonSListPopovers.h"
#import "SpeakSearchViewController.h"
#import "SearchDogController.h"


@implementation TFList
@synthesize tfID,cNAME,NAME;
+(id)tflist{
	return [[self alloc] init];
}
-(void)dealloc{
	[tfID release];
	[cNAME release];
	[NAME release];
	[super dealloc];
}
@end

//////////////////////////////////////////////////////
@implementation TFPathInfo
@synthesize tfNM,tfID,RQSJ2,SJ,JD,WD,QY,FS,FL,type,radius7,radius10,movesd,movefx;
+(id)tfpathinfo{
	return [[self alloc] init];
}
-(void)dealloc{
	[tfNM release];
	[tfID release];
	[RQSJ2 release];
	[SJ release];
	[JD release];
	[WD release];
	[QY release];
	[FS release];
	[FL release];
	[type release];
	[radius7 release];
	[radius10 release];
	[movesd release];
	[movefx release];
	[super dealloc];
}
@end

////////////////////////////////////
@implementation TFYBList
@synthesize tfID,RQSJ2,YBSJ,jd,wd,QY,FS,FL,TM;

+(id)tfyblist{
	return [[self alloc] init];
}
-(void)dealloc{
	[super dealloc];
	[tfID release];
	[RQSJ2 release];
	[YBSJ release];
	[jd release];
	[wd release];
	[QY release];
	[FS release];
	[FL release];
	[TM release];
}
@end

////////////////////////////////////
@implementation typhoonXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFPathInfo tfpathinfo];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
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
		[tc performSelectorOnMainThread:@selector(getTyHisPath:) withObject:Items waitUntilDone:YES];
		[Items release];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		Items.SJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.JD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.WD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		Items.type=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		Items.radius7=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		Items.radius10=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		Items.movesd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
		Items.movefx=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end

////////////////////////////////////

@implementation typhoonListXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFList tflist];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
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
		[tc performSelectorOnMainThread:@selector(getOneYearTyphList:) withObject:Items waitUntilDone:YES];
		[Items release];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		Items.cNAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		Items.NAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end


////////////////////////////////////
@implementation typhoonNewXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFList tflist];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
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
		[tc performSelectorOnMainThread:@selector(getNewTF:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		Items.cNAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		Items.NAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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


////////////////////////////////////

@implementation typhoonYBXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFYBList tfyblist];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"ybsj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"tm"]){
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
		[tc performSelectorOnMainThread:@selector(getTyForePath:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"ybsj"]){
		Items.YBSJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.jd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.wd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"tm"]){
		Items.TM=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end

////////////////////////////////////
////////////////////////////////////

@implementation historyTyphoonXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFPathInfo tfpathinfo];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
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
		[tc performSelectorOnMainThread:@selector(getHistoryTyphoonPath:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		Items.SJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.JD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.WD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		Items.type=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		Items.radius7=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		Items.radius10=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		Items.movesd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
		Items.movefx=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end

////////////////////////////////////

@implementation sHistoryTyphoonXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFPathInfo tfpathinfo];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
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
		SpeakSearchViewController *tc=[SpeakSearchViewController sharedWork];
		[tc performSelectorOnMainThread:@selector(getHistoryTyphoonPath:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		Items.SJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.JD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.WD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		Items.type=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		Items.radius7=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		Items.radius10=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		Items.movesd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
		Items.movefx=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end

/**************SMELLYDOG***********************/
////////////////////////////////////
@implementation typhoonDogXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFPathInfo tfpathinfo];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
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
		smellydogViewController *tc=[smellydogViewController sharedDog];
		[tc performSelectorOnMainThread:@selector(getTyHisPath:) withObject:Items waitUntilDone:YES];
		[Items release];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		Items.SJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.JD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.WD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		Items.type=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		Items.radius7=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		Items.radius10=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		Items.movesd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
		Items.movefx=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end

////////////////////////////////////

@implementation typhoonListDogXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFList tflist];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
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
		smellydogViewController *tc=[smellydogViewController sharedDog];
		[tc performSelectorOnMainThread:@selector(getOneYearTyphList:) withObject:Items waitUntilDone:YES];
		[Items release];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		Items.cNAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		Items.NAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end


////////////////////////////////////

@implementation typhoonNewDogXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFList tflist];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
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
		smellydogViewController *tc=[smellydogViewController sharedDog];
		[tc performSelectorOnMainThread:@selector(getNewTF:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"cname"]){
		Items.cNAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"name"]){
		Items.NAME=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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

////////////////////////////////////
@implementation typhoonYBDogXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFYBList tfyblist];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"ybsj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"tm"]){
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
		smellydogViewController *tc=[smellydogViewController sharedDog];
		[tc performSelectorOnMainThread:@selector(getTyForePath:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"ybsj"]){
		Items.YBSJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.jd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.wd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"tm"]){
		Items.TM=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end

////////////////////////////////////
////////////////////////////////////

@implementation historyTyphoonDogXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFPathInfo tfpathinfo];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
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
		smellydogViewController *tc=[smellydogViewController sharedDog];
		[tc performSelectorOnMainThread:@selector(getHistoryTyphoonPath:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		Items.SJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.JD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.WD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		Items.type=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		Items.radius7=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		Items.radius10=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		Items.movesd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
		Items.movefx=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end



////////////////////////////////////

@implementation sHistoryTyphoonDogXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        Items=[TFPathInfo tfpathinfo];
		return;
    }else if([[elementName lowercaseString] isEqualToString:@"id"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		contentOfCurrentElement=[NSMutableString string];
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
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
		SearchDogController *tc=[SearchDogController sharedWork];
		[tc performSelectorOnMainThread:@selector(getHistoryTyphoonPath:) withObject:Items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"id"]){
		Items.tfID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"rqsj2"]){
		Items.RQSJ2=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"sj"]){
		Items.SJ=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"jd"]){
		Items.JD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wd"]){
		Items.WD=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"qy"]){
		Items.QY=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fs"]){
		Items.FS=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"fl"]){
		Items.FL=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"type"]){
		Items.type=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius7"]){
		Items.radius7=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"radius10"]){
		Items.radius10=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movesd"]){
		Items.movesd=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"movefx"]){
		Items.movefx=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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
	[super dealloc];
}
@end



