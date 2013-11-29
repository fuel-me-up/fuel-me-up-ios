/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import "FMUMapFilter.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUMapFilter ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMUMapFilter

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

+ (NSValueTransformer *)providerForGasStationTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NSString class]];
}


@end