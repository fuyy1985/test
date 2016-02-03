//
//  CSRainMapRouteLayerView.h
//  smellycat
//
//  Created by apple on 10-11-4.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CSRainMapRouteLayerView : UIView {
	MKMapView* _mapView;
	NSMutableArray * _points;	
	UIColor* _lineColor;
	NSInteger mapTypeKey;
}
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) UIColor* lineColor; 
@property (nonatomic) NSInteger mapTypeKey;
-(id) initWithRoute:(NSMutableArray*)Points 
			mapView:(MKMapView*)mapView
			mapType:(NSInteger)mapType;
-(void) drawImages:(NSMutableArray*)Points;
-(void)drawImage:(NSString *)type withPoint:(CGPoint)point;
-(BOOL)isVisibleRect:(CLLocationCoordinate2D )loc;
@end