//
//  SatelliteOverlayView.m
//  VirginImageLayer
//
//  Created by apple on 11-3-10.
//  Copyright 2011 zjdayu. All rights reserved.
//

#import "SatelliteOverlayView.h"
#import "SatelliteOverlay.h"
#import "smellycatViewController.h"
#import "smellydogViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "const.h"

@implementation SatelliteOverlayView

- (id)initWithOverlay:(id <MKOverlay>)overlay
{
    if (self = [super initWithOverlay:overlay]) {
		}
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context{
	
	SatelliteOverlay *myOverlay = (SatelliteOverlay *)self.overlay;
	NSArray *temArray = myOverlay.myarray;

	//"minLng":"90","maxLng":"178","minLat":"0","maxLat":"50"
	NSString *cloudName = [temArray objectAtIndex:0];
	NSString *minLng = [temArray objectAtIndex:1];
	NSString *minLat = [temArray objectAtIndex:2];
	NSString *maxLng = [temArray objectAtIndex:3];
	NSString *maxLat = [temArray objectAtIndex:4];
	double dMinLng = [minLng doubleValue];
	double dMinLat = [minLat doubleValue];
	double dMaxLng = [maxLng doubleValue];
	double dMaxLat = [maxLat doubleValue];
	
	NSString *uniquePath = [TMP stringByAppendingPathComponent:cloudName];
    
    UIImage *image;
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
		image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
    }
    else
    {
        smellydogViewController *punkdog = [smellydogViewController sharedDog];
        if ([punkdog respondsToSelector:@selector(warningErrorFetchImage)]) {
            //NSLog(@"Dog Bad Image!");
            [punkdog performSelectorOnMainThread:@selector(warningErrorFetchImage) withObject:nil waitUntilDone:YES];
        }
        smellycatViewController *punkcat = [smellycatViewController sharedCat];
        if ([punkcat respondsToSelector:@selector(warningErrorFetchImage)]) {
            //NSLog(@"Cat Bad Image!");
            [punkcat performSelectorOnMainThread:@selector(warningErrorFetchImage) withObject:nil waitUntilDone:YES];
        }
        return;
        // get a new one OR while none picture exists in the uniquePath
    }
	
    CGImageRef imageReference = image.CGImage;
	CLLocationCoordinate2D lowerLeft = CLLocationCoordinate2DMake(dMinLat, dMinLng);
	CLLocationCoordinate2D upperRight = CLLocationCoordinate2DMake(dMaxLat, dMaxLng);
	
	MKMapPoint lowerLeftPoint = MKMapPointForCoordinate(lowerLeft);
	MKMapPoint upperRightPoint = MKMapPointForCoordinate(upperRight);
	MKMapRect theMapRect = MKMapRectMake(lowerLeftPoint.x, upperRightPoint.y, upperRightPoint.x - lowerLeftPoint.x, lowerLeftPoint.y - upperRightPoint.y);
	
	CGRect theRect  = [self rectForMapRect:theMapRect];
    CGRect clipRect = [self rectForMapRect:mapRect];
		
    CGContextAddRect(context, clipRect);
    CGContextClip(context);
	
	//flip the overlayer
	CGContextScaleCTM(context, 1, -1);	
	CGRect myframe = theRect;
	myframe.size.height = -myframe.size.height;
	theRect = myframe;
	
    CGContextDrawImage(context, theRect, imageReference);
//    CGContextDrawTiledImage(context, theRect, imageReference);
}
@end
