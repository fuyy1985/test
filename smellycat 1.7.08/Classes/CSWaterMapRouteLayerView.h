//
//  CSWaterMapRouteLayerView.h
//  smellycat
//
//  Created by apple on 10-11-17.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CSWaterMapRouteLayerView : UIView {
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
-(void)drawImage:(NSString *)type withPoint:(CGPoint)point chaoSig:(BOOL)cKey;
-(BOOL)isVisibleRect:(CLLocationCoordinate2D )loc;

@end
