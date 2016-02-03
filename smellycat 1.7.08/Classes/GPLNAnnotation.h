//
//  GPLNAnnotation
//  navag
//
//  Created by GPL on 12-12-6.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GPLNAnnotation : NSObject<MKAnnotation>
{
    NSString *_ennmcd;//code
    NSString *_ennm; //portInfo
    NSString *_en_gr;
    NSString *_grnm;
    NSString *_entpnm;
    NSString *_areaname;
    NSString *_dsnm;
    NSString *_location;
    NSString *_latitude;
    NSString *_longtitude;
    double _angle;
    
    NSString *_property1;
    NSString *_value1;
    NSString *_unit1;
    NSString *_property2;
    NSString *_value2;
    NSString *_unit2;
    
    NSString *_distance;
    CLLocationCoordinate2D _locationCoordinate;
}
@property (nonatomic,retain) NSString *ennmcd;
@property (nonatomic,retain) NSString *ennm;
@property (nonatomic,retain) NSString *en_gr;
@property (nonatomic,retain) NSString *grnm;
@property (nonatomic,retain) NSString *entpnm;
@property (nonatomic,retain) NSString *areaname;
@property (nonatomic,retain) NSString *dsnm;
@property (nonatomic,retain) NSString *location;
@property (nonatomic,retain) NSString *latitude;
@property (nonatomic,retain) NSString *longtitude;
@property (nonatomic,assign) double angle;

@property (nonatomic,retain) NSString *property1;
@property (nonatomic,retain) NSString *value1;
@property (nonatomic,retain) NSString *unit1;
@property (nonatomic,retain) NSString *property2;
@property (nonatomic,retain) NSString *value2;
@property (nonatomic,retain) NSString *unit2;

@property (nonatomic,retain) NSString *distance;
@property (nonatomic,assign) CLLocationCoordinate2D locationCoordinate;

-(void)setLatAndLon;
-(void)calculateDistanceAndArrow;

@end
