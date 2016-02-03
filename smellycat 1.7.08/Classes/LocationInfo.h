//
//  LocationInfo.h
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LocationInfo : NSObject {
	NSString *pac;
	NSString *pacname;
}
+(id)locationinfo;
-(id)infoWithDefaultValue;
@property(copy)NSString *pac;
@property(copy)NSString *pacname;
@end
