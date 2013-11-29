/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <CoreLocation/CoreLocation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@class FMULocation;

@interface FMUVehicle : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy) NSString *vin;
@property(nonatomic, copy) NSString *licensePlate;
@property(nonatomic, strong) FMULocation *location;
@property(nonatomic, assign) NSUInteger fuelLevel;
@property(nonatomic, copy) NSString *provider;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, strong) NSDate *date;

@end
