//
//  SatelliteOverlay.m
//  VirginImageLayer
//
//  Created by apple on 11-3-10.
//  Copyright 2011 zjdayu. All rights reserved.
//
//boundingMapRect,coordinate
#import "SatelliteOverlay.h"

@implementation SatelliteOverlay
@synthesize myarray;
-(id)initWithVirginInfo:(NSArray *)imgArray{
	if (self = [super init]) {
		[imgArray retain];
		[myarray release];
		self.myarray = imgArray;
		[imgArray release];
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMidX(boundingMapRect),MKMapRectGetMidY(boundingMapRect)));
}

- (MKMapRect)boundingMapRect
{
	//"minLng":"90","maxLng":"178","minLat":"0","maxLat":"50"
	NSString *minLng = [self.myarray objectAtIndex:1];
	NSString *minLat = [self.myarray objectAtIndex:2];
	NSString *maxLng = [self.myarray objectAtIndex:3];
	NSString *maxLat = [self.myarray objectAtIndex:4];
	double dMinLng = [minLng doubleValue];
	double dMinLat = [minLat doubleValue];
	double dMaxLng = [maxLng doubleValue];
	double dMaxLat = [maxLat doubleValue];

	CLLocationCoordinate2D lowerLeft = CLLocationCoordinate2DMake(dMinLat, dMinLng);
	CLLocationCoordinate2D upperRight = CLLocationCoordinate2DMake(dMaxLat, dMaxLng);
	
	MKMapPoint lowerLeftPoint = MKMapPointForCoordinate(lowerLeft);
	MKMapPoint upperRightPoint = MKMapPointForCoordinate(upperRight);
	
	MKMapRect pointRect = MKMapRectMake(lowerLeftPoint.x, upperRightPoint.y, upperRightPoint.x - lowerLeftPoint.x, lowerLeftPoint.y - upperRightPoint.y);

    return pointRect;
}
- (void) dealloc
{
	[myarray release];
	[super dealloc];
}

@end
