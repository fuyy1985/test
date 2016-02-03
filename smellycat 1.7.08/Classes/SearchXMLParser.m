//
//  SearchXMLParser.m
//  navag
//
//  Created by Heiby He on 09-9-12.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchXMLParser.h"
#import "SearchDogController.h"
#import "SpeakSearchViewController.h"
#import "SearchInfoModel.h"

@implementation SearchReaultInfo
@synthesize srName,srSort,srType,srEnnmcd,srEngr,srDescription,srStandLng,srStandLat,srSateLng,srSateLat;

+(id)searchresultinfo{
	return [[self alloc] init];
}
-(void)dealloc{
	[srStandLng release];
	[srStandLat release];
	[srSateLng release];
	[srSateLat release];
	[srName release];
	[srSort release];
	[srType release];
	[srEnnmcd release];
	[srEngr release];
	[srDescription release];
	[super dealloc];
}
@end

////////////////////////////////////

@implementation SearchXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
        item = [[SearchInfoModel alloc] init] ;
        return;
    }
	
    if ([[elementName lowercaseString] isEqualToString:@"name"]) {
		contentOfCurrentElement=[NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"sort"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"type"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"ennmcd"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"description"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lngo"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lato"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lng"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lat"]) {
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
		//add to list
		SpeakSearchViewController *search=[SpeakSearchViewController sharedWork];
		[search performSelectorOnMainThread:@selector(addData:) withObject:item waitUntilDone:YES];
		[item release];
		
	}else if([[elementName lowercaseString] isEqualToString:@"name"]) {
		item.srName=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
    }else if([[elementName lowercaseString] isEqualToString:@"sort"]) {
		item.srSort = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"type"]) {
		item.srType = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"ennmcd"]) {
		item.srEnnmcd = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]) {
		item.srEngr = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"description"]) {
		item.srDescription = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lngo"]) {
		item.srStandLng = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lato"]) {
		item.srStandLat = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lng"]) {
		item.srSateLng = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lat"]) {
		item.srSateLat = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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

@implementation SearchDogXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"Table"]) {
        // An Table in the RSS feed represents an earthquake, so create an instance of it.
        item = [SearchReaultInfo searchresultinfo] ;
        return;
    }
	
    if ([[elementName lowercaseString] isEqualToString:@"name"]) {
		contentOfCurrentElement=[NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"sort"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"type"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"ennmcd"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"description"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lngo"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lato"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lng"]) {
		contentOfCurrentElement = [NSMutableString string];
		
	}else if([[elementName lowercaseString] isEqualToString:@"lat"]) {
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
		//add to list
		SearchDogController *search=[SearchDogController sharedWork];
		[search performSelectorOnMainThread:@selector(addData:) withObject:item waitUntilDone:YES];
		[item release];
		
	}else if([[elementName lowercaseString] isEqualToString:@"name"]) {
		item.srName=(contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
    }else if([[elementName lowercaseString] isEqualToString:@"sort"]) {
		item.srSort = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"type"]) {
		item.srType = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"ennmcd"]) {
		item.srEnnmcd = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"en_gr"]) {
		item.srEngr = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"description"]) {
		item.srDescription = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lngo"]) {
		item.srStandLng = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lato"]) {
		item.srStandLat = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lng"]) {
		item.srSateLng = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
		
	}else if([[elementName lowercaseString] isEqualToString:@"lat"]) {
		item.srSateLat = (contentOfCurrentElement==nil?@"":contentOfCurrentElement);
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


