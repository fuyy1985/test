//
//  Parser.m
//  smellycat
//
//  Created by apple on 10-9-28.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "Parser.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation Parser
- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error {	
	//OLD APPLE' BUG in IOS 4
//  NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];

	NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [parser setDelegate:self];
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
	[data release];
	[parser release];
}

- (void) dealloc
{
	[super dealloc];
}


@end

