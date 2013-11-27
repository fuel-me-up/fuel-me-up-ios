/**
* Created by Maurício Hanika on 27.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import "FMUVehicleFilter.h"

extern NSString * const FMUCurrentVehicleFilterKey;

@interface FMUVehicleFilter (FMUPersistence)

+ (instancetype)defaultFilter;
+ (void)persistDefaultFilter;

@end