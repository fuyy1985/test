//
//  CSSatlliteRouterLayer.m
//  smellycat
//
//  Created by apple on 10-9-29.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "CSSatlliteRouterLayer.h"
#import <CoreLocation/CoreLocation.h>
#import "const.h"

@implementation CSSatlliteRouterLayer
@synthesize mapView   = _mapView;
@synthesize myarray;

-(id) initWithRoute:(MKMapView*)mapView satelliteMapName:(NSArray *)imgArray
{
	self = [super initWithFrame:CGRectMake(0, 0, 1024,696)];
	[self setBackgroundColor:[UIColor clearColor]];
	[self setMapView:mapView];
	
	[imgArray retain];
	[myarray release];
	self.myarray = imgArray;
	[imgArray release];
		
	//setRegion
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = 17.277344;
	newRegion.center.longitude = 135.296707;
	newRegion.span.latitudeDelta = 55.932945;
	//newRegion.span.longitudeDelta = 97.515671;

	
	if (imgArray!=nil) {
		[self.mapView setRegion:newRegion animated:YES];
		[self setUserInteractionEnabled:NO];
		[self.mapView addSubview:self];
	}
	return self;
}


- (void)drawRect:(CGRect)rect
{
	NSString *cloudName = [self.myarray objectAtIndex:0];
	NSString *minLng = [self.myarray objectAtIndex:1];
	NSString *minLat = [self.myarray objectAtIndex:2];
	NSString *maxLng = [self.myarray objectAtIndex:3];
	NSString *maxLat = [self.myarray objectAtIndex:4];
	double dMinLng = [minLng doubleValue];
	double dMinLat = [minLat doubleValue];
	double dMaxLng = [maxLng doubleValue];
	double dMaxLat = [maxLat doubleValue];

	
	MKCoordinateRegion newRegion;
	newRegion.center.latitude =(dMaxLat+dMinLat)/2;
	newRegion.center.longitude = (dMinLng+dMaxLng)/2;
	newRegion.span.latitudeDelta = (dMaxLat-dMinLat);
	newRegion.span.longitudeDelta = (dMaxLng-dMinLng);
	CGRect imageframe = [_mapView convertRegion:newRegion toRectToView:self];
	
    NSString *uniquePath = [TMP stringByAppendingPathComponent:cloudName];
    
    UIImage *image;
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
		//image = [UIImage imageNamed:[NSString stringWithFormat:self.sImgName]];
       image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
	   [image drawInRect:imageframe];
		/*
		NSURL *url = [NSURL URLWithString:path];
		NSData *data = [NSData dataWithContentsOfURL:url];
		UIImage *img = [[UIImage alloc] initWithData:data cache:NO];
		*/
    }
    else
    {
        // get a new one
		//while none picture exists in the uniquePath
    }

}


-(void) dealloc
{
	[myarray release];
	[_mapView release];
	[super dealloc];
}

@end

