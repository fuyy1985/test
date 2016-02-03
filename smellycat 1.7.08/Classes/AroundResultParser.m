//
//  AroundResultParser.m
//  navag
//
//  Created by GPL on 12-12-7.
//
//

#import "AroundResultParser.h"
#import "smellycatViewController.h"
#import "GPLNAnnotation.h"

static NSString *kTable = @"table";
static NSString *kEnnmcd = @"ennmcd";
static NSString *kEnnm = @"ennm";
static NSString *kEngr = @"en_gr";
static NSString *kGrnm = @"grnm";
static NSString *kEntpnm = @"entpnm";
static NSString *kAreaname = @"areaname";
static NSString *kDsnm = @"dsnm";
static NSString *kLocation = @"location";
static NSString *kProperty1 = @"property1";
static NSString *kValue1 = @"value1";
static NSString *kUnit1 = @"unit1";
static NSString *kProperty2 = @"property2";
static NSString *kValue2 = @"value2";
static NSString *kUnit2 = @"unit2";

#define DEFAULT_ROW_HEIGHT 78
#define HEADER_HEIGHT 45

@implementation AroundResultParser
@synthesize annotaion = _annotaion;
@synthesize coordinate = _coordinate;

//排序
NSInteger sortObjectsByDistanceMethod(id obj1, id obj2, void *context)
{
    double d1 = [[(GPLNAnnotation*)obj1 distance] doubleValue];
    double d2 = [[(GPLNAnnotation*)obj2 distance] doubleValue];
    //sort by desc
    // {NSOrderedAscending = -1, NSOrderedSame, NSOrderedDescending};
    return (d2 - d1) > 0 ? NSOrderedAscending:NSOrderedDescending;
}

- (id)initWithData:(NSData *)data;
{
    self = [super init];
    if (self) {
        _data = [data retain];
        _workingPropertyString = [[NSMutableString alloc] init];
        _elementToParse = [[NSArray alloc] initWithObjects:kTable,kEnnmcd,kEnnm,kEngr,kGrnm,kEntpnm,kAreaname,kDsnm,kLocation,kProperty1,kValue1,kUnit1,kProperty2,kValue2,kUnit2,nil];
        //annotation map
        _skMapArray = [[NSMutableArray alloc] init];
        _szMapArray = [[NSMutableArray alloc] init];
        _bzMapArray = [[NSMutableArray alloc] init];
        _htMapArray = [[NSMutableArray alloc] init];
        _dfMapArray = [[NSMutableArray alloc] init];
        _dzMapArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)startParser
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_data];
    parser.delegate = self;
    [parser parse];
}

- (void)dealloc
{
    [_data release];
    [_workingPropertyString release];
    [_elementToParse release];
    [_annotaion release];
    
    //annotation 
    [_skMapArray release];
    [_szMapArray release];
    [_bzMapArray release];
    [_htMapArray release];
    [_dfMapArray release];
    [_dzMapArray release];
    [super dealloc];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName lowercaseString] isEqualToString:kTable]) {
        self.annotaion = [[[GPLNAnnotation alloc] init] autorelease];
        _annotaion.locationCoordinate = _coordinate;
    }
    _storingCharacterData = [_elementToParse containsObject:[elementName lowercaseString]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (_annotaion) {
        if (_storingCharacterData)
        {
            NSString *trimmedString = [_workingPropertyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_workingPropertyString setString:@""]; // clear the string for next time
            if ([[elementName lowercaseString] isEqualToString:kEnnmcd]) {
                _annotaion.ennmcd = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kEnnm]){
                _annotaion.ennm = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kEngr]){
                _annotaion.en_gr = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kGrnm]){
                _annotaion.grnm = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kEntpnm]){
                _annotaion.entpnm = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kAreaname]){
                _annotaion.areaname = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kDsnm]){
                _annotaion.dsnm = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kLocation]){
                _annotaion.location = trimmedString;
                //将信息转换成经纬度
                [_annotaion setLatAndLon];
                [_annotaion calculateDistanceAndArrow];
                
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kProperty1]){
                _annotaion.property1 = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kValue1]){
                _annotaion.value1 = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kUnit1]){
                _annotaion.unit1 = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kProperty2]){
                _annotaion.property2 = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kValue2]){
                _annotaion.value2 = trimmedString;
                _storingCharacterData = NO;
            } else if ([[elementName lowercaseString] isEqualToString:kUnit2]){
                _annotaion.unit2 = trimmedString;
                _storingCharacterData = NO;
                
            } else {
                _storingCharacterData = NO;
            }
        }  else  {
            if ([[elementName lowercaseString] isEqualToString:kTable]) {
                if ([_annotaion.entpnm isEqualToString:@"水库"]) {
                    [_skMapArray addObject:_annotaion];
                } else if([_annotaion.entpnm isEqualToString:@"水闸"]){
                    [_szMapArray addObject:_annotaion];
                } else if([_annotaion.entpnm isEqualToString:@"泵站"]){
                    [_bzMapArray addObject:_annotaion];
                } else if([_annotaion.entpnm isEqualToString:@"海塘"]){
                    [_htMapArray addObject:_annotaion];
                } else if([_annotaion.entpnm isEqualToString:@"堤防"]){
                    [_dfMapArray addObject:_annotaion];
                } else if([_annotaion.entpnm isEqualToString:@"电站"]){
                    [_dzMapArray addObject:_annotaion];
                } else {
                    // do nothing
                }
                self.annotaion = nil;
            }
        }
    } else {
        if ([[elementName lowercaseString] isEqualToString:@"newdataset"]) {
            //排序
            [_skMapArray sortedArrayUsingFunction:sortObjectsByDistanceMethod context:NULL];
            [_szMapArray sortedArrayUsingFunction:sortObjectsByDistanceMethod context:NULL];
            [_bzMapArray sortedArrayUsingFunction:sortObjectsByDistanceMethod context:NULL];
            [_htMapArray sortedArrayUsingFunction:sortObjectsByDistanceMethod context:NULL];
            [_dfMapArray sortedArrayUsingFunction:sortObjectsByDistanceMethod context:NULL];
            [_dzMapArray sortedArrayUsingFunction:sortObjectsByDistanceMethod context:NULL];
            
            /** 使用单例模式进行数据传递 **/
            smellycatViewController *vc = [smellycatViewController sharedCat];
            [vc performSelectorOnMainThread:@selector(addSKMapArray:) withObject:_skMapArray waitUntilDone:YES];
            [vc performSelectorOnMainThread:@selector(addSZMapArray:) withObject:_szMapArray waitUntilDone:YES];
            [vc performSelectorOnMainThread:@selector(addBZMapArray:) withObject:_bzMapArray waitUntilDone:YES];
            [vc performSelectorOnMainThread:@selector(addHTMapArray:) withObject:_htMapArray waitUntilDone:YES];
            [vc performSelectorOnMainThread:@selector(addDFMapArray:) withObject:_dfMapArray waitUntilDone:YES];
            [vc performSelectorOnMainThread:@selector(addDZMapArray:) withObject:_dzMapArray waitUntilDone:YES];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_storingCharacterData) {
        [_workingPropertyString appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    smellycatViewController *vc = [smellycatViewController sharedCat];
    [vc performSelectorOnMainThread:@selector(fetchDataError) withObject:nil waitUntilDone:YES];
}

@end
