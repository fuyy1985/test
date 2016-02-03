//
//  SearchInfoModel.h
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import <Foundation/Foundation.h>

@interface SearchInfoModel : NSObject
@property(copy)NSString *srName;
@property(copy)NSString *srSort;
@property(copy)NSString *srType;
@property(copy)NSString *srEnnmcd;
@property(copy)NSString *srEngr;
@property(copy)NSString *srDescription;
@property(copy)	NSString *srStandLng;
@property(copy)	NSString *srStandLat;
@property(copy)	NSString *srSateLng;
@property(copy)	NSString *srSateLat;
@end
