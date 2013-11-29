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
        @"location"       : @"coordinate",
        @"usableProvider" : @"provider"
    };
}

+ (NSValueTransformer *)locationJSONTransformer __unused
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FMULocation class]];
}

+ (NSValueTransformer *)usableProviderTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NSString class]];
}


#pragma mark - setter
- (void)setUsableProvider:(NSArray *)usableProvider
{
    _usableProvider = usableProvider;

    NSString *availableProvider = @"";
    for ( NSString *provider in _usableProvider )
    {
        availableProvider = [availableProvider stringByAppendingString:[NSString stringWithFormat:@" %@", provider]];
    }

    _availableProviderString = availableProvider;
}


@end