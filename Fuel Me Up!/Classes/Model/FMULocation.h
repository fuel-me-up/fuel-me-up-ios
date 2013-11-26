/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <CoreLocation/CoreLocation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface FMULocation : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

- (CLLocationCoordinate2D)coordinate;

@end