//
//  WebServices.h
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WebServices : NSObject {

}
+(NSURL *)getNRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSString *) params;

+(NSURL *)getNNRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSString *) params withMobile:(NSString *)mobile;

@end
