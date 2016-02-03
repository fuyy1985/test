//
//  SatelliteXMLParser.m
//  smellycat
//
//  Created by apple on 11-7-6.
//  Copyright 2011年 zjdayu. All rights reserved.
//

#import "SatelliteXMLParser.h"
#import "smellydogViewController.h"
#import "smellycatViewController.h"

//cat
@implementation SatelliteTotalStringXMLParser
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
        if([punkCat respondsToSelector:@selector(getSatelliteStrByType:)]){
            [punkCat performSelectorOnMainThread:@selector(getSatelliteStrByType:) withObject:contentOfCurrentElement waitUntilDone:YES];
        }
        smellydogViewController *punkDog=[smellydogViewController sharedDog];
        if([punkDog respondsToSelector:@selector(getSatelliteStrByType:)]){
            [punkDog performSelectorOnMainThread:@selector(getSatelliteStrByType:) withObject:contentOfCurrentElement waitUntilDone:YES];
        }
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

//dog
@implementation SatelliteTotalStringDogXMLParser
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
        if([punkCat respondsToSelector:@selector(getSatelliteStrByType:)]){
		[punkCat performSelectorOnMainThread:@selector(getSatelliteStrByType:) withObject:contentOfCurrentElement waitUntilDone:YES];
        }
        smellydogViewController *punkDog=[smellydogViewController sharedDog];
        if([punkDog respondsToSelector:@selector(getSatelliteStrByType:)]){
            [punkDog performSelectorOnMainThread:@selector(getSatelliteStrByType:) withObject:contentOfCurrentElement waitUntilDone:YES];
        }
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

