//
//  SatelliteOverlay.h
//  VirginImageLayer
//
//  Created by apple on 11-3-10.
//  Copyright 2011 zjdayu. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface SatelliteOverlay : NSObject<MKOverlay> {
	MKMapRect boundingMapRect;
	NSArray *myarray;
}
@property(nonatomic,retain) NSArray *myarray;
-(id)initWithVirginInfo:(NSArray *)imgArray;

@end
