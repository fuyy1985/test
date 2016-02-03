//
//  Parser.h
//  smellycat
//
//  Created by apple on 10-9-28.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Parser : NSObject <NSXMLParserDelegate>{

}
- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;
@end
