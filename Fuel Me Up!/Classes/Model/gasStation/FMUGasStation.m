/**
* Created by Matthias Steeger on 28.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import "MTLModel.h"
#import "FMUGasStation.h"
#import "FMULocation.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUGasStation ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMUGasStation
{

}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"location" : @"coordinate"
    };
}

+ (NSValueTransformer *)locationJSONTransformer __unused
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FMULocation class]];
}

+ (NSValueTransformer *)usableProviderTransformer __unused
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NSString class]];
}


@end