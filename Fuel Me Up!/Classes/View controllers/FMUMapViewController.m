//
//  FMUViewController.m
//  Fuel Me Up!
//
//  Created by Maurício Hanika on 26.11.13.
//  Copyright (c) 2013 Maurício Hanika. All rights reserved.
//

@import MapKit;

#import "FMUMapViewController.h"
#import "FMURequestHandler.h"
#import "FMUFilterViewController.h"
#import "FMUVehicleFilter.h"
#import "FMUVehicle.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUMapViewController () <FMUFilterViewControllerDelegate, MKMapViewDelegate>

@end

////////////////////////////////////////////////////////////////////////////////
@implementation FMUMapViewController
{
    FMUVehicleFilter *_vehicleFilter;
    MKMapView *_mapView;
    NSArray *_vehicles;
}

- (id)init
{
    self = [super init];

    if ( self )
    {
        _vehicleFilter = [[FMUVehicleFilter alloc] init];
        _vehicleFilter.maximumFuelLevel = 25;
        _vehicleFilter.city = @"hamburg";

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
            initWithTitle:@"Filter"
                    style:UIBarButtonItemStyleBordered
                   target:self
                   action:@selector(presentFilterViewController:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
            initWithTitle:@"Locate me"
                    style:UIBarButtonItemStyleBordered
                   target:self
                   action:@selector(locateMe:)];
    }

    return self;
}

- (void)presentFilterViewController:(id)sender
{
    FMUFilterViewController *filterViewController =
        [[FMUFilterViewController alloc] initWithVehicleFilter:_vehicleFilter];
    filterViewController.delegate = self;

    UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:filterViewController];

    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
}


- (void)loadView
{
    self.view = [[MKMapView alloc] init];

    _mapView = ( MKMapView * ) self.view;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self fetchVehiclesWithFilter:_vehicleFilter];
}


#pragma mark - FMUFilterViewControllerDelegate

- (void)filterViewController:(FMUFilterViewController *)controller didUpdateFilters:(FMUVehicleFilter *)filter
{
    [self fetchVehiclesWithFilter:_vehicleFilter];
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ( [annotation isKindOfClass:[FMUVehicle class]] )
    {
        static NSString *pinViewIdentifier = @"pinViewIdentifier";

        MKPinAnnotationView *view =
            ( MKPinAnnotationView * ) [mapView dequeueReusableAnnotationViewWithIdentifier:pinViewIdentifier];
        if ( view == nil )
        {
            view = [[MKPinAnnotationView alloc]
                initWithAnnotation:annotation reuseIdentifier:pinViewIdentifier];
        }

        view.annotation = annotation;
        view.canShowCallout = YES;
        view.pinColor = [[( FMUVehicle * ) annotation provider] isEqualToString:@"car2go"] ?
            MKPinAnnotationColorGreen : MKPinAnnotationColorRed;

        return view;
    }

    return nil;
}


#pragma mark - Actions

- (void)locateMe:(id)sender
{
    MKUserLocation *userLocation = _mapView.userLocation;
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, userLocation.location.horizontalAccuracy + 250, userLocation.location.horizontalAccuracy + 250)
               animated:YES];
}


#pragma mark - Private methods

- (void)fetchVehiclesWithFilter:(FMUVehicleFilter *)filter
{
    FMURequestHandler *handler = [[FMURequestHandler alloc] init];
    [handler vehiclesInCity:filter.city
           maximumFuelLevel:filter.maximumFuelLevel
                 completion:^(NSArray *vehicles, NSError *error)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^
                     {
                         if ( _vehicles.count > 0 )
                         {
                             [_mapView removeAnnotations:_vehicles];
                         }

                         _vehicles = vehicles;
                         [_mapView addAnnotations:_vehicles];
                     });
                 }];
}

@end