//
//  LocationAnnotation.h
//  smellycat
//
//  Created by apple on 10-11-11.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface LocationAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *customPointName;
	NSString *customPointData;
	NSString *titleData;
	NSString *subtitleData;
	NSString *type;
    
    NSString *subType;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *customPointName;
@property (nonatomic,retain) NSString *customPointData;
@property (nonatomic,retain) NSString *titleData;
@property (nonatomic,retain) NSString *subtitleData;
@property (nonatomic,retain) NSString *type;

@property (nonatomic,retain) NSString *subType;
// add an init method so you can set the coordinate property on startup
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord;
-(NSString *)title;
- (NSString *)subtitle;
@end