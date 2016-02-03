//
//  ValidateXMLParser.m
//  smellycat
//
//  Created by apple on 10-11-18.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "ValidateXMLParser.h"
#import "RootViewController.h"
#import "Const.h"

@implementation LogUserInfo

@synthesize ifval,username,yxqx,state,area,szx,mtemplateid,mtemplatename,mtemplatealias,mtemplatearea,areacode,isNew,versionID,versioncount,iscompel;
+(id)loguserinfo{
	return [[self alloc] init];
}

-(void)checkIsNew
{
    isNew = NO;
    if ([versionID length] > 0) {
        NSString *vi = [NSString stringWithFormat:@"%@",VERSIONID];
        //nowVersionArray表示当前应用版本号
        NSArray *nowVersionArray = [vi componentsSeparatedByString:@"."];
        NSArray *newVersionArrays = [versionID componentsSeparatedByString:@"."];
        if ([nowVersionArray count] >= 1 && [newVersionArrays count] >= 1) {
            int firstNowVersion = [[nowVersionArray objectAtIndex:0] intValue];
            int firstNewVersion = [[newVersionArrays objectAtIndex:0] intValue];
            if (firstNowVersion < firstNewVersion) {
                isNew = YES;
                return;
            }
            if ([nowVersionArray count] >= 2 && [newVersionArrays count] >= 2) {
                int secondNowVersion = [[nowVersionArray objectAtIndex:1] intValue];
                int secondNewVersion = [[newVersionArrays objectAtIndex:1] intValue];
                if (secondNowVersion < secondNewVersion) {
                    isNew = YES;
                    return;
                }
                if ([nowVersionArray count] >= 3 && [newVersionArrays count] >= 3) {
                    int thirdNowVersion = [[nowVersionArray objectAtIndex:2] intValue];
                    int thirdNewVersion = [[newVersionArrays objectAtIndex:2] intValue];
                    if (thirdNowVersion < thirdNewVersion) {
                        isNew = YES;
                        return;
                    }
                }
            }
        }
    }
}

-(void)dealloc{
	[ifval release];
	[username release];
	[yxqx release];
	[state release];
	[area release];
	[szx release];
	[mtemplateid release];
	[mtemplatename release];
	[mtemplatealias release];
	[mtemplatearea release];
	[areacode release];
    [versionID release];
    
    [iscompel release];
    [versioncount release];
	[super dealloc];
}
@end

///////////////////////////////////////

@implementation rootXMLParser
@synthesize MySig;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
		if (MySig == NO) {
			items=[LogUserInfo loguserinfo];
			MySig = YES;
		} else {
			[items release];
		}

        return;
    }
	
	if ([[elementName lowercaseString] isEqualToString:@"ifval"]) {
		contentOfCurrentElement=[NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"username"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"yxqx"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"state"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"area"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"template_id"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"template_name"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"template_alias"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"template_area"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"areacode"]) {
		contentOfCurrentElement = [NSMutableString string];
        
	}else if([[elementName lowercaseString] isEqualToString:@"version"]) {
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
		RootViewController *nad=[RootViewController sharedRT];
		[nad performSelectorOnMainThread:@selector(getvalidation:) withObject:items waitUntilDone:YES];
		return;
	}else if([[elementName lowercaseString] isEqualToString:@"ifval"]){
		items.ifval=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"username"]){
		items.username=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"yxqx"]){
		items.yxqx=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"state"]){
		items.state=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"area"]){
		items.area=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"template_id"]){
		items.mtemplateid=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"template_name"]){
		items.mtemplatename=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"template_alias"]){
		items.mtemplatealias=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"template_area"]){
		items.mtemplatearea=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"areacode"]){
		items.areacode=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"version"]){
		items.versionID=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
        [items checkIsNew];
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


/////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////

@implementation ModuleInfo
@synthesize func,wip,alias,ipcode,funcid;
+(id)moduleinfo{
	return [[self alloc] init];
}
-(void)dealloc{
	[func release];
	[wip release];
	[alias release];
	[ipcode release];
	[funcid release];
	[super dealloc];
}
@end

@implementation rootModuleXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
        items=[ModuleInfo moduleinfo];
        return;
    }
	
	if ([[elementName lowercaseString] isEqualToString:@"func"]) {
		contentOfCurrentElement=[NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"wip"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"alias"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"ip_code"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"function_id"]) {
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
        RootViewController *nad=[RootViewController sharedRT];
		[nad performSelectorOnMainThread:@selector(getModule:) withObject:items waitUntilDone:YES];
	}else if([[elementName lowercaseString] isEqualToString:@"func"]){
		items.func=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"wip"]){
		items.wip=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"alias"]){
		items.alias=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"ip_code"]){
		items.ipcode=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
	}else if([[elementName lowercaseString] isEqualToString:@"function_id"]){
		items.funcid=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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

