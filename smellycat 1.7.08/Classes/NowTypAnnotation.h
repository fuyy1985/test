//
//  NowTypAnnotation.h
//  smellycat
//
//  Created by apple on 10-11-17.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface NowTypAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString * TyphShowInfo;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *TyphShowInfo;
// add an init method so you can set the coordinate property on startup
- (id) initWithCoordinate:(CLLocationCoordinate2D)coord;
-(NSString *)title;

@end