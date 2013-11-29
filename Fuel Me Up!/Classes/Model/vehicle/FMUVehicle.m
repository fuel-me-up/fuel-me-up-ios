/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUVehicle.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "FMULocation.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUVehicle ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMUVehicle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"date" : @"timestamp",
        @"fuelLevel" : @"fuel_level",
        @"location" : @"coordinate",
        @"licensePlate" : @"license_plate"
    };
}

+ (NSValueTransformer *)dateJSONTransformer __unused
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSNumber *timestamp)
    {
        return [NSDate dateWithTimeIntervalSince1970:([timestamp doubleValue] / 1000)];
    }
                                                         reverseBlock:^id(NSDate *date)
                                                         {
                                                             return @([date timeIntervalSince1970] * 1000);
                                                         }];
}

+ (NSValueTransformer *)locationJSONTransformer __unused
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FMULocation class]];
}

@end