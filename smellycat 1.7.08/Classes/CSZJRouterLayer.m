//
//  CSZJRouterLayer.m
//  smellycat
//
//  Created by apple on 10-11-18.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "CSZJRouterLayer.h"
#import <CoreLocation/CoreLocation.h>

@implementation CSZJRouterLayer
@synthesize mapView   = _mapView;

-(id) initWithZJRoute:(MKMapView*)mapView;
{
	self = [super initWithFrame:CGRectMake(0, 0, 1024, 696)];
	[self setBackgroundColor:[UIColor clearColor]];
	[self setMapView:mapView];
	
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = 29.080555;
	newRegion.center.longitude = 119.122078;
	newRegion.span.latitudeDelta = 5.564740;
	newRegion.span.longitudeDelta = 9.370728;
	
	[self.mapView setRegion:newRegion animated:YES];
	
	[self setUserInteractionEnabled:NO];
	[self.mapView addSubview:self];
	return self;
}


- (void)drawRect:(CGRect)rect
{
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = 29.180555;
	newRegion.center.longitude = 120.360000;
	newRegion.span.latitudeDelta = 4.069209;
	newRegion.span.longitudeDelta = 4.724121;

	
	CGRect imageframe = [_mapView convertRegion:newRegion toRectToView:self];
	    
    UIImage *image = [UIImage imageNamed:@"zjbg.png"];
	[image drawInRect:imageframe];
	
}


-(void) dealloc
{
	[_mapView release];
	[super dealloc];
}

@end

