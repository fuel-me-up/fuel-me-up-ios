//
//  FMUViewController.m
//  Fuel Me Up!
//
//  Created by Maurício Hanika on 26.11.13.
//  Copyright (c) 2013 Maurício Hanika. All rights reserved.
//

@import MapKit;

#import "FMUMapViewController.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUMapViewController ()

@end

////////////////////////////////////////////////////////////////////////////////
@implementation FMUMapViewController
{
    __weak MKMapView *_mapView;
}

- (void)loadView
{
	self.view = [[MKMapView alloc] init];
    
    _mapView = (MKMapView *)self.view;
    _mapView.showsUserLocation = YES;
}

@end
