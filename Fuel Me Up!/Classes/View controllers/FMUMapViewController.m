//
//  FMUViewController.m
//  Fuel Me Up!
//
//  Created by Maurício Hanika on 26.11.13.
//  Copyright (c) 2013 Maurício Hanika. All rights reserved.
//

@import MapKit;

#import <CoreLocation/CoreLocation.h>

#import "FMUMapViewController.h"
#import "FMURequestHandler.h"
#import "FMUFilterViewController.h"
#import "FMUMapFilter.h"
#import "FMUMapFilter+FMUPersistence.h"
#import "FMUVehicle.h"
#import "FMUVehicle+FMUMapAdditions.h"
#import "FMUGasStation.h"
#import "FMUGasStation+FMUMapAdditions.h"
#import "FMULocation.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUMapViewController () <FMUFilterViewControllerDelegate, MKMapViewDelegate>

@end

////////////////////////////////////////////////////////////////////////////////
@implementation FMUMapViewController
{
    FMUMapFilter *_mapFilter;
    MKMapView *_mapView;
    NSArray *_vehicles;
    NSArray *_gasStations;
    MKUserLocation *_initialLocation;
}

- (id)init
{
    self = [super init];

    if ( self )
    {
        _mapFilter = [FMUMapFilter defaultFilter];

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

        [[NSNotificationCenter defaultCenter]
            addObserverForName:UIApplicationDidBecomeActiveNotification
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification *note)
                    {
                        [self fetchVehiclesWithFilter:_mapFilter];
                    }];
    }

    return self;
}

- (void)presentFilterViewController:(id)sender
{
    FMUFilterViewController *filterViewController =
        [[FMUFilterViewController alloc] initWithMapFilter:_mapFilter];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self fetchVehiclesWithFilter:_mapFilter];
    [self fetchGasStationsWithFilter:_mapFilter];
}


#pragma mark - FMUFilterViewControllerDelegate

- (void)filterViewController:(FMUFilterViewController *)controller didUpdateFilters:(FMUMapFilter *)filter
{
    if ( !_gasStations )
    {
        [self fetchGasStationsWithFilter:_mapFilter];
    }
    else if ( !_mapFilter.gasStationsEnabled )
    {
        [_mapView removeAnnotations:_gasStations];
    }
    else
    {
        [_mapView addAnnotations:_gasStations];
    }
    //TODO just fetch if _mapFilter is different to filter from delegate.
    [self fetchVehiclesWithFilter:_mapFilter];
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
        //  view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        view.pinColor = [[( FMUVehicle * ) annotation provider] isEqualToString:@"car2go"] ?
            MKPinAnnotationColorGreen : MKPinAnnotationColorRed;

        return view;
    }
    else if ( [annotation isKindOfClass:[FMUGasStation class]] )
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
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.pinColor = MKPinAnnotationColorPurple;

        return view;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView
               annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    if ( [view.annotation isKindOfClass:[FMUGasStation class]] )
    {
        FMUGasStation *gasstation = ( FMUGasStation * ) view.annotation;

        MKPlacemark *startPlace = [[MKPlacemark alloc] initWithCoordinate:gasstation.coordinate addressDictionary:nil];
        MKMapItem *start = [[MKMapItem alloc] initWithPlacemark:startPlace];
        start.name = gasstation.name;

        NSArray *items = @[start];

        [MKMapItem openMapsWithItems:items
                       launchOptions:@{MKLaunchOptionsDirectionsModeDriving : MKLaunchOptionsDirectionsModeKey}];
    }
    else if ( [view.annotation isKindOfClass:[FMUVehicle class]] )
    {
        FMUVehicle *vehicle = ( FMUVehicle * ) view.annotation;
        if ( [vehicle.provider isEqualToString:@"car2go"] )
        {
            NSURL *url = [NSURL URLWithString:@"//car2go:"];
            if ( [[UIApplication sharedApplication] canOpenURL:url] )
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if ( _initialLocation == nil )
    {
        _initialLocation = userLocation;
        [_mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, userLocation.location.horizontalAccuracy + 250, userLocation.location.horizontalAccuracy + 250)
                   animated:YES];
    }
}


#pragma mark - Actions

- (void)locateMe:(id)sender
{
    MKUserLocation *userLocation = _mapView.userLocation;
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, userLocation.location.horizontalAccuracy + 250, userLocation.location.horizontalAccuracy + 250)
               animated:YES];
}

#pragma mark - Private methods

- (void)fetchVehiclesWithFilter:(FMUMapFilter *)filter
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
                         if ( _vehicles.count > 0 )
                         {
                             FMUVehicle *nearestVehicle =
                                 ( FMUVehicle * ) [self nearestAnnotationToLocation:_mapView.userLocation.location
                                                                        annotations:_vehicles];

                             MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(
                                 2.5 * (fabs(_mapView.userLocation.coordinate.latitude - nearestVehicle.location.coordinate.latitude)),
                                 2.5 * (fabs(_mapView.userLocation.coordinate.longitude - nearestVehicle.location.coordinate.longitude))
                             );
                             [_mapView setRegion:MKCoordinateRegionMake(_mapView.userLocation.coordinate, coordinateSpan)
                                        animated:YES];
                         }

                         [_mapView addAnnotations:_vehicles];
                     });
                 }];
}

- (void)fetchGasStationsWithFilter:(FMUMapFilter *)filter
{
    if ( filter.gasStationsEnabled )
    {
        FMURequestHandler *handler = [[FMURequestHandler alloc] init];
        [handler gasStationsInCity:filter.city
                          provider:filter.providerForGasStation
                        completion:^(NSArray *gasStations, NSError *error)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^
                            {
                                if ( _gasStations.count > 0 )
                                {
                                    [_mapView removeAnnotations:_gasStations];
                                }

                                _gasStations = gasStations;
                                [_mapView addAnnotations:_gasStations];
                            });
                        }];
    }
}


- (id <MKAnnotation>)nearestAnnotationToLocation:(CLLocation *)location annotations:(NSArray *)annotations
{
    // Nearest vehicle to user
    __block id <MKAnnotation> nearestAnnotation = nil;
    __block CLLocationDistance minimumDistance = -1;
    [annotations enumerateObjectsUsingBlock:^(id <MKAnnotation> annotation, NSUInteger index, BOOL *stop)
    {
        CLLocation *annotationLocation = [[CLLocation alloc]
            initWithLatitude:annotation.coordinate.latitude
                   longitude:annotation.coordinate.longitude];
        CLLocationDistance distance = [annotationLocation distanceFromLocation:location];

        if ( minimumDistance == -1 || distance < minimumDistance )
        {
            minimumDistance = distance;
            nearestAnnotation = annotation;
        }
    }];

    return nearestAnnotation;
}

@end