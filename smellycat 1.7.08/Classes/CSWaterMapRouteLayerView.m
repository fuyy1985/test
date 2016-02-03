//
//  CSWaterMapRouteLayerView.m
//  smellycat
//
//  Created by apple on 10-11-17.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "CSWaterMapRouteLayerView.h"
#import <CoreLocation/CoreLocation.h>

@implementation CSWaterMapRouteLayerView
@synthesize mapView   = _mapView;
@synthesize points    = _points;
@synthesize lineColor = _lineColor; 
@synthesize mapTypeKey;

-(id) initWithRoute:(NSMutableArray*)Points 
			mapView:(MKMapView*)mapView
			mapType:(NSInteger)mapType
{
	//	self = [super initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
	self = [super initWithFrame:CGRectMake(0, 0, 1024, 768)];
	[self setBackgroundColor:[UIColor clearColor]];
	[self setMapView:mapView];
	[self setPoints:Points];
	
	[self setUserInteractionEnabled:NO];
	[self.mapView addSubview:self];
	
	return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 0.3);
	
	if(!self.hidden && nil != self.points && self.points.count > 0)
	{
		[self drawImages:self.points];
	}
	
}

-(void) drawImages:(NSMutableArray*)Points{
	for(int idx = 0; idx < Points.count; idx++)
	{
		CLLocationCoordinate2D location;
		NSString *type;
		NSString *isChao;
		NSArray *tf = [Points objectAtIndex:idx];
        //defend the ERROR 
        if([tf count]<12)
            continue;
		if (mapTypeKey == 0) {
			location.latitude = [[tf objectAtIndex:11] floatValue];
			location.longitude = [[tf objectAtIndex:10] floatValue];
		} else {
			location.latitude = [[tf objectAtIndex:9] floatValue];
			location.longitude = [[tf objectAtIndex:8] floatValue];
		}
		
		type = [tf objectAtIndex:2];
		isChao = [tf objectAtIndex:7];
		BOOL chaoKey = NO;
		if ([isChao isEqualToString:@"1"]) {
			chaoKey = YES;
		} else {
			chaoKey = NO;
		}
        
        if([self isVisibleRect:location]==NO)
        {
            continue;
        }

		CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
		point.x -= 8;
		point.y -= 6;
		[self drawImage:type withPoint:point chaoSig:chaoKey];
	}
}


-(BOOL)isVisibleRect:(CLLocationCoordinate2D )loc{
    MKMapPoint point = MKMapPointForCoordinate(loc);
    MKMapRect myRect = self.mapView.visibleMapRect;
    BOOL yArrowOK=point.y<=MKMapRectGetMaxY(myRect)&&point.y>=MKMapRectGetMinY(myRect)?YES:NO;
    BOOL xArrowOK=point.x>=MKMapRectGetMinX(myRect)&&point.x<=MKMapRectGetMaxX(myRect)?YES:NO;
    if (yArrowOK&&xArrowOK) {
        return YES;
    } else{
        return NO;
    }
}


-(void)drawImage:(NSString *)type withPoint:(CGPoint)point chaoSig:(BOOL)cKey{
	NSString *symbol=[NSString stringWithString:@"river_a.gif"];
	if([type compare:@"ZZ"] == NSOrderedSame){
		if (cKey) {
			symbol=[NSString stringWithString:@"river_c.gif"];
		} else {
			symbol=[NSString stringWithString:@"river_a.gif"];
		}
	}else if([type compare:@"DD"] == NSOrderedSame){
		if (cKey) {
			symbol=[NSString stringWithString:@"gate_c.gif"];
		} else {
			symbol=[NSString stringWithString:@"gate_a.gif"];
		}
	}else if([type compare:@"RR"] == NSOrderedSame){
		if (cKey) {
			symbol=[NSString stringWithString:@"reservoir_c.gif"];
		} else {
			symbol=[NSString stringWithString:@"reservoir_a.gif"];
		}
	}else if([type compare:@"TT"] == NSOrderedSame){
		if (cKey) {
			symbol=[NSString stringWithString:@"tide_c.gif"];
		} else {
			symbol=[NSString stringWithString:@"tide_a.gif"];
		}
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
