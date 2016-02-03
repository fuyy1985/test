//
//  ValidateXMLParser.h
//  smellycat
//
//  Created by apple on 10-11-18.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

@interface LogUserInfo : NSObject
{
	NSString *ifval;
	NSString *username;
	NSString *yxqx;
	NSString *state;
	NSString *area;
	NSString *szx;
	NSString *mtemplateid;
	NSString *mtemplatename;
	NSString *mtemplatealias;
	NSString *mtemplatearea;
	NSString *areacode;
    NSString *versionID;
    BOOL isNew;
    
    NSString *versioncount;
    NSString *iscompel;
}
@property(nonatomic) BOOL isNew;
@property(copy)NSString *ifval;
@property(copy)NSString *username;
@property(copy)NSString *yxqx;
@property(copy)NSString *state;
@property(copy)NSString *area;
@property(copy)NSString *szx;
@property(copy)NSString *mtemplateid;
@property(copy)NSString *mtemplatename;
@property(copy)NSString *mtemplatealias;
@property(copy)NSString *mtemplatearea;
@property(copy)NSString *versionID;
@property(copy)NSString *areacode;

@property(copy)NSString *versioncount;
@property(copy)NSString *iscompel;

+(id)loguserinfo;
-(void)checkIsNew;
@end

@interface rootXMLParser : Parser {
	NSMutableString *contentOfCurrentElement;
	LogUserInfo *items;
	BOOL MySig;
}
@property (nonatomic) BOOL MySig;
@end

////////////////////////////////////////////////
@interface ModuleInfo : NSObject
{
	NSString *func;
	NSString *wip;
	NSString *alias;
	NSString *ipcode;
	NSString *funcid;
}
@property(copy)NSString *func;
@property(copy)NSString *wip;
@property(copy)NSString *alias;
@property(copy)NSString *ipcode;
@property(copy)NSString *funcid;
+(id)moduleinfo;
@end

@interface rootModuleXMLParser : Parser {
	NSMutableString *contentOfCurrentElement;
	ModuleInfo *items;
}
@end

