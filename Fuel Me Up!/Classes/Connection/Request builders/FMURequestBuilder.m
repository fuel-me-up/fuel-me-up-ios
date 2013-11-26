/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMURequestBuilder.h"
#import "AFHTTPRequestOperation.h"
#import "FMUAPIClient.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "FMUVehicle.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMURequestBuilder ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMURequestBuilder
{
    FMUAPIClient *_APIClient;
}

- (id)init
{
    self = [super init];

    if ( self )
    {
        _APIClient = [FMUAPIClient sharedInstance];
    }

    return self;
}

- (NSURLSessionDataTask *)vehiclesInCity:(NSString *)city
                        maximumFuelLevel:(NSUInteger)maximumFuelLevel
                              completion:(void (^)(NSArray *, NSError *))completion
{
    NSParameterAssert(completion);

    return [_APIClient GET:[NSString stringWithFormat:@"vehicles/%@", city]
                parameters:@{@"max_fuel_level" : @(maximumFuelLevel)}
                   success:^(NSURLSessionDataTask *task, id responseObject)
                   {
                       if ( completion )
                       {
                           NSArray *vehicles =
                               [[MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[FMUVehicle class]]
                                   transformedValue:responseObject];
                           completion(vehicles, nil);
                       }
                   }
                   failure:^(NSURLSessionDataTask *task, NSError *error)
                   {
                       if ( completion )
                       {
                           completion(nil, error);
                       }
                   }];
}

@end