//
//  AroundResultParser.h
//  navag
//
//  Created by GPL on 12-12-7.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class GPLNAnnotation;
@interface AroundResultParser : NSObject<NSXMLParserDelegate>
{
    NSData *_data;
    CLLocationCoordinate2D _coordinate;
    /** 处理解析 **/
    BOOL _storingCharacterData;//判断字符
    NSArray *_elementToParse;//判断数组
    NSMutableString *_workingPropertyString;//解析传递数组
    GPLNAnnotation *_annotaion;
    //annotation array
    NSMutableArray *_skMapArray;
    NSMutableArray *_szMapArray;
    NSMutableArray *_bzMapArray;
    NSMutableArray *_htMapArray;
    NSMutableArray *_dfMapArray;
    NSMutableArray *_dzMapArray;
}
@property(nonatomic,retain) GPLNAnnotation *annotaion;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
- (id)initWithData:(NSData *)data;
-(void)startParser;
@end
