//
//  SLocationAnnotation.h
//  smellycat
//
//  Created by apple on 10-11-27.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SLocationAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *customPointName;
	NSString *customPointData;
	NSString *type;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *customPointName;
@property (nonatomic,retain) NSString *customPointData;
@property (nonatomic,retain) NSString *type;
// add an init method so you can set the coordinate property on startup
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord;
-(NSString *)title;

@end
