//
//  CSRainMapRouteLayerView.m
//  smellycat
//
//  Created by apple on 10-11-4.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "CSRainMapRouteLayerView.h"
#import <CoreLocation/CoreLocation.h>

@implementation CSRainMapRouteLayerView
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
	self.mapTypeKey = mapType;
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
		NSArray *tf = [Points objectAtIndex:idx];
        if ([tf count]<9) 
            continue;
		if (mapTypeKey == 0) {
			location.latitude = [[tf objectAtIndex:8] floatValue];
			location.longitude = [[tf objectAtIndex:7] floatValue];
            //judge if the point is in the visiable region
		} else {
			location.latitude = [[tf objectAtIndex:6] floatValue];
			location.longitude = [[tf objectAtIndex:5] floatValue];
		}
		
		type = [tf objectAtIndex:4];
        
		CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
		point.x -= 3;
		point.y -= 2;
        if ([self isVisibleRect:location]==NO) {
            continue;
        }
        
		[self drawImage:type withPoint:point];
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

-(void)drawImage:(NSString *)type withPoint:(CGPoint)point{
	NSString *symbol=[NSString stringWithString:@"06.gif"];
	if([type compare:@"6"] == NSOrderedSame){
		symbol=@"06.gif";
	}else if([type compare:@"5"] == NSOrderedSame){
		symbol=@"05.gif";
	}else if([type compare:@"4"] == NSOrderedSame){
		symbol=@"04.gif";
	}else if([type compare:@"3"] == NSOrderedSame){
		symbol=@"03.gif";
	}else if([type compare:@"2"] == NSOrderedSame){
		symbol=@"02.gif";
	}else if([type compare:@"1"] == NSOrderedSame){
		symbol=@"01.gif";
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
