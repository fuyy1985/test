//
//  Database.h
//  navag
//
//  Created by Heiby He on 09-5-6.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class LocationInfo;
@interface Database : NSObject {

}
-(NSString *)getDBPath;
- (void)createEditableCopyOfDatabaseIfNeeded;
-(void)distinctBooks;

-(NSString *)getNameOfCity:(NSNumber *)key;
-(NSArray *)getPrimaryKeysOfCity;
-(NSString *)getCodeOfCity:(NSNumber *)key;
-(NSMutableArray *)getCodeIDOfCityByName:(NSString *)key;

-(NSArray *)getAllProvince;
-(NSArray *)getAllCity;
-(NSArray *)getAllTown;
-(NSArray *)getCityByProvice:(NSString *)key;
-(NSArray *)getTownByCity:(NSString *)key;
-(NSString *)getCityByCode:(NSString *)key;
-(LocationInfo *)getCityInfoByCode:(NSString *)key;

@end
