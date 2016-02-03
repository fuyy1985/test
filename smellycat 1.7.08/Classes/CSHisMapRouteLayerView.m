//
//  CSHisMapRouteLayerView.m
//  smellycat
//
//  Created by apple on 10-9-28.
//  Copyright 2010 zjdayu. All rights reserved.
//


#import "CSHisMapRouteLayerView.h"
#import <CoreLocation/CoreLocation.h>
#import "typhoonXMLParser.h"

@implementation CSHisMapRouteLayerView
@synthesize mapView   = _mapView;
@synthesize points    = _points;
@synthesize lineColor = _lineColor; 

-(id) initWithRoute:(NSMutableArray*)Points 
			mapView:(MKMapView*)mapView;
{
	//	self = [super initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
	self = [super initWithFrame:CGRectMake(0, 0, 1024, 696)];
	[self setBackgroundColor:[UIColor clearColor]];
	
	[self setMapView:mapView];
	[self setPoints:Points];
	
	// determine the extents of the trip points that were passed in, and zoom in to that area. 
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 90;
	CLLocationDegrees minLon = 180;
	
	for(int idx = 0; idx < [self.points count]; idx++)
	{
		TFPathInfo* pathinfo = [self.points objectAtIndex:idx];
		if([pathinfo.WD floatValue] > maxLat)
			maxLat = [pathinfo.WD floatValue];
		if([pathinfo.WD floatValue] < minLat)
			minLat = [pathinfo.WD floatValue];
		if([pathinfo.JD floatValue] > maxLon)
			maxLon = [pathinfo.JD floatValue];
		if([pathinfo.JD floatValue] < minLon)
			minLon = [pathinfo.JD floatValue];
	}

	
	MKCoordinateRegion region;
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = (maxLat - minLat)>25?(maxLat-minLat):25;
	region.span.longitudeDelta = (maxLat - minLat)>40?(maxLat-minLat):40;
	
	[self.mapView setRegion:region];
	
	[self setUserInteractionEnabled:NO];
	[self.mapView addSubview:self];
	
	return self;
}


- (void)drawRect:(CGRect)rect
{
	// only draw our lines if we're not int he moddie of a transition and we 
	// acutally have some points to draw. 
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 0.3);
	
	if(!self.hidden && nil != self.points && self.points.count > 0)
	{
		[self drawLine:context withPoints:self.points withLineColor:[UIColor blackColor] withLineWidth:2.0 withDash:NO];
	}
	
}


-(void) drawLine:(CGContextRef)context withPoints:(NSMutableArray *)Points withLineColor:(UIColor *)mlineColor withLineWidth:(double)mLineWidth withDash:(BOOL)isDash{
	CGContextSetStrokeColorWithColor(context, mlineColor.CGColor);
	CGContextSetLineWidth(context, mLineWidth);
	
	if(isDash)
	{
		const float pattern[2] = {2, 3};
		CGContextSetLineDash(context, 0.0, pattern, 1);
	}
	else
	{
		const float pattern[2] = {0, 0};
		CGContextSetLineDash(context, 0.0, pattern, 0);
	}
	
	for(int idx = 0; idx < Points.count; idx++)
	{
		CLLocationCoordinate2D location;
		
		if ([[Points objectAtIndex:idx] isKindOfClass:[TFPathInfo class]]) {
			TFPathInfo *tf = [Points objectAtIndex:idx];
			location.latitude = [tf.WD floatValue];
			location.longitude = [tf.JD floatValue];
		} else if ([[Points objectAtIndex:idx] isKindOfClass:[TFYBList class]]) {
			TFYBList *tf = [Points objectAtIndex:idx];
			location.latitude = [tf.wd floatValue];
			location.longitude = [tf.jd floatValue];
		}
		
		CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
		
		if(idx == 0)
		{
			// move to the first point
			CGContextMoveToPoint(context, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(context, point.x, point.y);
		}
			
		
	}
	
	CGContextStrokePath(context);
	
	[self drawImages:Points];
}

-(void) drawImages:(NSMutableArray*)Points{
	for(int idx = 0; idx < Points.count; idx++)
	{
		CLLocationCoordinate2D location;
		NSString *type;
		if ([[Points objectAtIndex:idx] isKindOfClass:[TFPathInfo class]]) {
			TFPathInfo *tf = [Points objectAtIndex:idx];
			location.latitude = [tf.WD floatValue];
			location.longitude = [tf.JD floatValue];
			type = tf.type;
			
		} else if ([[Points objectAtIndex:idx] isKindOfClass:[TFYBList class]]) {
			TFYBList *tf = [Points objectAtIndex:idx];
			location.latitude = [tf.wd floatValue];
			location.longitude = [tf.jd floatValue];
			type = @"预报";
		}
		CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
		point.x -= 2;
		point.y -= 2;
		[self drawImage:type withPoint:point];
	}
}

-(void)drawImage:(NSString *)type withPoint:(CGPoint)point{
	
	NSString *symbol=[NSString stringWithString:@"预报_previous.gif"];
	
	if([type compare:@"热带低压"] == NSOrderedSame){
		symbol=@"热带低压.gif";
	}else if([type compare:@"热带风暴"] == NSOrderedSame){
		symbol=@"热带风暴.gif";
	}else if([type compare:@"强热带风暴"] == NSOrderedSame){
		symbol=@"强热带风暴.gif";
	}else if([type compare:@"台风"] == NSOrderedSame){
		symbol=@"台风.gif";
	}else if([type compare:@"强台风"] == NSOrderedSame){
		symbol=@"强台风.gif";
	}else if([type compare:@"超强台风"] == NSOrderedSame){
		symbol=@"超强台风.gif";
	}else if([type compare:@"当前点"] == NSOrderedSame){
		symbol=@"当前点.gif";
	}else{
		symbol=@"预报_previous.gif";
	}
	UIImage *image = [UIImage imageNamed:symbol];
	[image drawAtPoint:point];
}



-(void) dealloc
{
	[_points release];
	[_mapView release];
	[_lineColor release];
	[super dealloc];
}
@end
