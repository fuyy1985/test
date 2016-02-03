//
//  FileManager.m
//  navag
//
//  Created by Heiby He on 09-4-1.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FileManager.h"
#import "Database.h"
#import "Const.h"

@implementation FileManager

-(void)createConfigFileIfNeeded{
	NSString *appFile = [[self getFileName]  stringByAppendingPathComponent:@"myconfig.plist"];
	
	NSFileManager *fm=[NSFileManager defaultManager];
	if([fm fileExistsAtPath:appFile]==NO){
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSDate date],NSFileModificationDate,
							 @"owner",@"NSFileOwnerAccountName",
							 @"group",@"NSFileGroupOwnerAccountName",
							 nil,@"NSFilePosixPermissions",
							 [NSNumber numberWithBool:YES],@"NSFileExtensionHidden",
							 nil];
		NSString *str=@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"><plist version=\"1.0\"><dict><key>mTide</key><string>http://218.108.95.11/iphoneService/qgjService.asmx</string><key>weatherLocation</key><string>杭州|58457|0</string></dict></plist>";
		[fm createFileAtPath:appFile contents:nil attributes:dic];
		[str writeToFile:appFile atomically:NO encoding:NSUTF8StringEncoding error:nil];
	}
}

-(bool)writeConfigFile:(NSString *)key ValueForKey:(NSString *)value{
	NSString *appFile = [[self getFileName]  stringByAppendingPathComponent:@"myconfig.plist"];
	bool ret;
	
	NSMutableDictionary* dict = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:appFile ];
	[ dict setObject:value forKey:key ];
	ret=[ dict writeToFile:appFile atomically:YES ];
	[dict release];
	return ret;
}
-(NSString *)getValue:(NSString *)key{
	NSString *appFile = [self getConfigName];
	if(appFile==nil) return nil;
	NSMutableDictionary* dict =  [ [ NSMutableDictionary alloc ] initWithContentsOfFile:appFile ];
	NSString *retValue=[[ dict objectForKey:key ] copy];
	[retValue autorelease];
	[dict release];
//	NSLog(retValue);
	return retValue;
} 
-(NSString *)getFileName{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	if (!documentsDirectory) {
//		NSLog(@"Documents directory not found!");
		return nil;
	}
	return documentsDirectory;	
}

-(NSString *)getConfigName{
	return  [[self getFileName]  stringByAppendingPathComponent:@"myconfig.plist"];
}
-(NSString *)getCacheDir{
	return [[self getFileName] stringByAppendingString:@"/mycache/"];
}

-(bool)saveToCacheFile:(NSData *)data fileName:(NSString *)name withType:(NSString *)wxytType{
	bool ret=YES;
	NSString *cacheDir=[self getCacheDir];
	NSFileManager *file=[NSFileManager defaultManager];
	/*NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
						 [NSDate date],NSFileModificationDate,
						 @"owner",@"NSFileOwnerAccountName",
						 @"group",@"NSFileGroupOwnerAccountName",
						 nil,@"NSFilePosixPermissions",
						 [NSNumber numberWithBool:YES],@"NSFileExtensionHidden",
						 nil];*/
	if([file fileExistsAtPath:cacheDir]==NO){
		ret=[file createDirectoryAtPath:cacheDir attributes:nil];
	}
	if(ret){
		cacheDir=[NSString stringWithFormat:@"%@%@/", [self getCacheDir],wxytType];
		if([file fileExistsAtPath:cacheDir]==NO){
			ret=[file createDirectoryAtPath:cacheDir attributes:nil];
		}
		if(ret){ 
			[file changeCurrentDirectoryPath:cacheDir];
			return [file createFileAtPath:name contents:data attributes:nil];
		}else{
			return NO;
		}
	}else{
		return NO;
	}
}
/*
-(NSArray *)getLocation{
	NSString *code = [self getValue:@"defaultarea"];
	NSString *name = @"全部";
	if(code==nil || [code compare:@"000000"]==NSOrderedSame){
		name = [self getValue:@"templatearea"];
	}else{
		Database *db=[Database alloc];
		name = [db getCityByCode:code];
		[db release];
	}

	NSArray *ret=[NSArray arrayWithObjects:code,name,nil];
	return ret;
}
 */

//0705change__zhejiang to quanbu
-(NSArray *)getLocation{
	NSString *code = [self getValue:@"defaultarea"]; //选取plist中的代码：例如：330000
	NSString *name = @"全省";
	if(code==nil || [code compare:@"330000"]==NSOrderedSame){
		
	}else{
		Database *db=[Database alloc];
		name = [db getCityByCode:code];
		[db release];
	}
	
	NSArray *ret=[NSArray arrayWithObjects:code,name,nil];
	return ret;
}


-(NSString *)getServerURL:(NSInteger)sType{
	switch (sType) {
		case 1:
			return ServerMain;
			break;
		case 2:
			return ServerBackup;
			break;
		default:
			return ServerMain;
			break;
	}
}

-(NSString *)getValidURL{
	return [NSString stringWithFormat:@"http://%@/%@/", [self getServerURL:[[self getValue:@"mainserver"] intValue]], MainServerURLPath];
}

-(NSString *)getIPbyModule:(NSString *)mType{
	NSString *moduleIP = [self getValue:mType];
	return moduleIP;
}

- (NSString *)getTemplateID{
	NSString *templateName = [self getValue:@"templateid"];
	return templateName;
}

- (NSString *)getTemplateName{
	NSString *templateName = [self getValue:@"templatealias"];
	return templateName;
}

@end
