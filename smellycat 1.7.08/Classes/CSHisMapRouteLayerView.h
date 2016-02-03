//
//  CSHisMapRouteLayerView.h
//  smellycat
//
//  Created by apple on 10-9-28.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CSHisMapRouteLayerView : UIView
{
	MKMapView* _mapView;
	NSMutableArray * _points;	
	UIColor* _lineColor;
}

-(id) initWithRoute:(NSMutableArray*)Points 
			mapView:(MKMapView*)mapView;
-(void) drawLine:(CGContextRef)context withPoints:(NSMutableArray *)Points withLineColor:(UIColor *)mlineColor withLineWidth:(double)mLineWidth withDash:(BOOL)isDash;
-(void) drawImages:(NSMutableArray*)Points;
-(void)drawImage:(NSString *)type withPoint:(CGPoint)point;
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) UIColor* lineColor; 

@end
