//
//  CellObject.m
//  navag
//
//  Created by GPL on 12-12-6.
//
//

#import "GPLNAnnotation.h"
//度数转弧度
static double angToRad(double angle_d)  
{
    double Pi = 3.1415926535898;
    double rad1;
    rad1 = angle_d * Pi / 180;
    return rad1;
}

@implementation GPLNAnnotation
@synthesize ennmcd = _ennmcd;
@synthesize ennm = _ennm;
@synthesize en_gr = _en_gr;
@synthesize grnm = _grnm;
@synthesize entpnm = _entpnm;
@synthesize areaname = _areaname;
@synthesize dsnm = _dsnm;
@synthesize location = _location;
@synthesize latitude = _latitude;
@synthesize longtitude = _longtitude;
@synthesize distance = _distance;
@synthesize locationCoordinate = _locationCoordinate;
@synthesize angle = _angle;

@synthesize property1 = _property1;
@synthesize value1 = _value1;
@synthesize unit1 = _unit1;
@synthesize property2 = _property2;
@synthesize value2 = _value2;
@synthesize unit2 = _unit2;

-(NSString *)entpnm
{
    if ([_entpnm isEqualToString:@"水电站"]) {
        return @"电站";
    }
    return _entpnm;
}

-(NSString *)distance {
    return _distance;
}

-(NSString *)grnm;
{
    if ([_grnm isEqualToString:@"大（1）型"]) {
        return @"大(1)型";
    } else if ([_grnm isEqualToString:@"大（2）型"]) {
        return @"大(2)型";
    } else if ([_grnm isEqualToString:@"中型"]) {
        return @" 中  型";
    } else if ([_grnm isEqualToString:@"小（1）型"]) {
        return @"小(1)型";
    } else if ([_grnm isEqualToString:@"小（2）型"]) {
        return @"小(2)型";
    } else if([_grnm isEqualToString:@"大（一）型"]) {
        return @"大(一)型";
    } else if([_grnm isEqualToString:@"大（二）型"]) {
        return @"大(二)型";
    } else if([_grnm isEqualToString:@"小（一）型"]) {
        return @"小(一)型";
    } else if([_grnm isEqualToString:@"小（二）型"]) {
        return @"小(二)型";
    } else {
        return _grnm;
    }
}

- (void)dealloc
{
    [_ennmcd release];
    [_ennm release];
    [_en_gr release];
    [_grnm release];
    [_entpnm release];
    [_areaname release];
    [_dsnm release];
    [_location release];
    [_latitude release];
    [_longtitude release];
    [_distance release];
    
    
    [_property1 release];
    [_value1 release];
    [_unit1 release];
    [_property2 release];
    [_value2 release];
    [_unit2 release];
    
    [super dealloc];
}

-(NSString *)title
{
    if (_ennm) {
        return _ennm;
    }
    return @"未命名站点";
}

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coord;
    coord.latitude = [_latitude doubleValue];
    coord.longitude = [_longtitude doubleValue];
    return coord;
}

-(void)setLatAndLon;
{
    NSString *string0 = [_location stringByReplacingOccurrencesOfString:@"POINT (" withString:@""];
    NSString *string1 = [string0 stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSArray *array = [string1 componentsSeparatedByString:@" "];
    if ([array count] == 2) {
        self.latitude = [array objectAtIndex:1];
        self.longtitude = [array objectAtIndex:0];
    }
}

-(void)calculateDistanceAndArrow
{
    //angle_d *M_PI / 180.0
    double lat2 = angToRad([_latitude doubleValue]);
    double lng2 = angToRad([_longtitude doubleValue]);
    //lat1 lng1 这个是当前位置的纬经度
    double lat1 = angToRad(_locationCoordinate.latitude);
    double lng1 = angToRad(_locationCoordinate.longitude);
    double dlat = lat2 - lat1;
    double dlon = lng2 - lng1;
    //求距离
    double midA = pow(sin(dlat/2), 2) + cos(lat1)*cos(lat2)*pow(sin(dlon/2), 2);
    double midC = 2 * asin(sqrt(midA));
    double dis  =  midC*6371229;
    self.distance = [NSString stringWithFormat:@"%.2fkm",dis/1000];
    
    _angle = 0.0; //方位角
    //求弧度
    double Y = sin(dlon)*cos(lat2);
    double X = cos(lat1)*sin(lat2)-sin(lat1)*cos(lat2)*cos(dlon);
    _angle = atan2(Y,X);    
}

@end
