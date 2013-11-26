/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUVehicle+FMUMapAdditions.h"
#import "FMULocation.h"

////////////////////////////////////////////////////////////////////////////////
@implementation FMUVehicle (FMUMapAdditions)

- (NSString *)title
{
    return self.vin;
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%d%% fuel, %@", self.fuelLevel, self.provider];
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

@end