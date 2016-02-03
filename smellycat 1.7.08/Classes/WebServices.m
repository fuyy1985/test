//
//  WebServices.m
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebServices.h"
#import "NSData+Base64.h"
#import "StringEncryption.h"
#import "UIDevice+serialNumber.h"

NSString *_key = @"3d5900ae-111a-45be-96b3-d9e4606ca793";
#define MYUDID [UIDevice currentDevice].serialFinalNumber
@implementation WebServices

+(NSURL *)getNRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSString *) params
{
	//keyStr
	NSString *keyStr = @"";
	
	//PART A--fetch up the sys time as the style in 2011-05-29 16:20:51
	NSDate *timeStr=[NSDate date];
	NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	NSString *partTime = [dateFormat stringFromDate:timeStr];
	keyStr=[keyStr stringByAppendingString:partTime];
    
	//PART B--fetch up the UDID
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *mobile = [defaults objectForKey:@"MOBILE"];
	keyStr=[keyStr stringByAppendingString:@"&"];
	keyStr=[keyStr stringByAppendingString:mobile];
    
	//PART C--compose the value as idenfitier of '|'
	if ([params length]>0) {
		keyStr=[keyStr stringByAppendingString:@"&"];
		keyStr=[keyStr stringByAppendingString:params];
	}
	//NSLog(@"Before cry:%@",keyStr);
	//Encypt the keyStr
	StringEncryption *cry =[[[StringEncryption alloc] init] autorelease];
	NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    
	CCOptions padding = kCCOptionPKCS7Padding;
	
	NSData *keyCryData = [cry encrypt:keyData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
    
	NSString *cryStr = [keyCryData base64EncodingWithLineLength:0];
	//NSLog(@"After cry: %@",cryStr);
	//change the url as the urlcode
	NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																				   (CFStringRef)cryStr,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 );
    //NSLog(@"%@",encodedString);
	
	//default webservice url ----use it as the total str
	NSString *myNewURL = [NSString stringWithFormat:@"%@%@?key=%@",url,methodName,encodedString];
	
    //NSLog(myNewURL);
	
	return [NSURL URLWithString:[(NSString*) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)myNewURL, NULL, NULL, kCFStringEncodingUTF8) autorelease]];
}


+(NSURL *)getNNRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSString *) params withMobile:(NSString *)mobile
{
	//keyStr
	NSString *keyStr = @"";
	
	//PART A--fetch up the sys time as the style in 2011-05-29 16:20:51
	NSDate *timeStr=[NSDate date];
	NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	NSString *partTime = [dateFormat stringFromDate:timeStr];
	keyStr=[keyStr stringByAppendingString:partTime];
    
	//PART B--fetch up the UDID
	keyStr=[keyStr stringByAppendingString:@"&"];
	keyStr=[keyStr stringByAppendingString:mobile];
    
	//PART C--compose the value as idenfitier of '|'
	if ([params length]>0) {
		keyStr=[keyStr stringByAppendingString:@"&"];
		keyStr=[keyStr stringByAppendingString:params];
	}
	//NSLog(@"Before cry:%@",keyStr);
	//Encypt the keyStr
	StringEncryption *cry =[[[StringEncryption alloc] init] autorelease];
	NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    
	CCOptions padding = kCCOptionPKCS7Padding;
	
	NSData *keyCryData = [cry encrypt:keyData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
    
	NSString *cryStr = [keyCryData base64EncodingWithLineLength:0];
	//NSLog(@"After cry: %@",cryStr);
	//change the url as the urlcode
	NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																				   (CFStringRef)cryStr,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 );
    //NSLog(@"%@",encodedString);
	
	//default webservice url ----use it as the total str
	NSString *myNewURL = [NSString stringWithFormat:@"%@%@?key=%@",url,methodName,encodedString];
	
    //NSLog(myNewURL);
	
	return [NSURL URLWithString:[(NSString*) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)myNewURL, NULL, NULL, kCFStringEncodingUTF8) autorelease]];
}


@end
