//
//  CSMapRouteLayerView.h
//  mapLines
//
//  Created by Craig on 4/12/09.
//  Copyright Craig Spitzkoff 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class TFYBList;
@interface CSMapRouteLayerView : UIView
{
	MKMapView* _mapView;
	NSMutableArray * _points;
	NSMutableArray *_newTyphoonArray;
	NSMutableArray * _foreChinaPoints;
	NSMutableArray * _foreHongKongPoints;
	NSMutableArray * _foreTaiWanPoints;
	NSMutableArray * _foreAmericaPoints;
	NSMutableArray * _foreJapanPoints;
	
	NSMutableArray *typhoonRings;
    NSMutableArray *typhoonForecastV;
	UIColor* _lineColor;
}

-(id) initWithRoute:(NSMutableArray*)Points 
 forNewTyphoonArray:(NSMutableArray *)newTyphoonArray
		  foreChina:(NSMutableArray *)foreChinaPoints 
	   foreHongKong:(NSMutableArray *)foreHongKongPoints
		 foreTaiWan:(NSMutableArray *)foreTaiWanPoints 
		foreAmerica:(NSMutableArray *)foreAmericaPoints 
		  foreJapan:(NSMutableArray *)foreJapanPoints 
			mapView:(MKMapView*)mapView
     withNoNeedMove:(BOOL)needMove;
-(void) drawLine:(CGContextRef)context withPoints:(NSMutableArray *)Points withLineColor:(UIColor *)mlineColor withLineWidth:(double)mLineWidth withDash:(BOOL)isDash;
-(void) drawImages:(NSMutableArray*)Points;
-(void)drawImage:(NSString *)type withPoint:(CGPoint)point;
-(void)drawTwoWarningLines:(CGContextRef)context;
-(NSString *)createViewTag:(NSString *)s withTFID:(NSString *)tfId withIndex:(NSInteger)index;
-(BOOL)checkIfTouchOneForecastV:(CGPoint)p;
-(void)drawImages:(CGPoint )point withForecastInfo:(TFYBList *)ybL withIndex:(NSInteger)index;
-(void)drawRound:(CGContextRef)context withBeginP:(CGPoint)bP withEndP:(CGPoint)eP;
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic,retain) NSMutableArray *newTyphoonArray;
@property (nonatomic, retain) NSMutableArray * foreChinaPoints;
@property (nonatomic, retain) NSMutableArray * foreHongKongPoints;
@property (nonatomic, retain) NSMutableArray * foreTaiWanPoints;
@property (nonatomic, retain) NSMutableArray * foreAmericaPoints;
@property (nonatomic, retain) NSMutableArray * foreJapanPoints;
@property (nonatomic,retain) NSMutableArray *typhoonRings;
@property (nonatomic,retain) NSMutableArray *typhoonForecastV;
@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) UIColor* lineColor; 

@end
