//
//  CSSatlliteRouterLayer.h
//  smellycat
//
//  Created by apple on 10-9-29.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CSSatlliteRouterLayer : UIView
{
	MKMapView* _mapView;
	NSArray *myarray;
}

-(id) initWithRoute:(MKMapView*)mapView satelliteMapName:(NSArray *)imgArray;

@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic,retain) NSArray *myarray;
@end
