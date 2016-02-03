//
//  CSZJRouterLayer.h
//  smellycat
//
//  Created by apple on 10-11-18.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CSZJRouterLayer : UIView
{
	MKMapView* _mapView;
}

-(id) initWithZJRoute:(MKMapView*)mapView;
@property (nonatomic, retain) MKMapView* mapView;
@end