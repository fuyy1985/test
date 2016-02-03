//
//  FileManager.h
//  navag
//
//  Created by Heiby He on 09-4-1.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FileManager : NSObject {

}
-(bool)writeConfigFile:(NSString *)key ValueForKey:(NSString *)value;
-(NSString *)getValue:(NSString *)key;
-(NSString *)getFileName;
-(NSString *)getConfigName;
-(NSArray *)getLocation;
-(NSString *)getServerURL:(NSInteger)sType;
-(NSString *)getValidURL;
-(void)createConfigFileIfNeeded;
-(NSString *)getIPbyModule:(NSString *)mType;
- (NSString *)getTemplateID;
- (NSString *)getTemplateName;

-(NSString *)getCacheDir;
-(bool)saveToCacheFile:(NSData *)data fileName:(NSString *)name withType:(NSString *)wxytType;
@end
