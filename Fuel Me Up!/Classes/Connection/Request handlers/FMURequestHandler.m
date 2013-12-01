/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMURequestHandler.h"
#import "FMUAPIClient.h"
#import "FMURequestBuilder.h"
#import "AFHTTPRequestOperation.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMURequestHandler ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMURequestHandler
{
    FMUAPIClient *_APIClient;
    FMURequestBuilder *_requestBuilder;
}

- (id)init
{
    self = [super init];

    if ( self )
    {
        _APIClient = [FMUAPIClient sharedInstance];
        _requestBuilder = [[FMURequestBuilder alloc] init];
    }
    return self;
}


- (void)vehiclesInCity:(NSString *)city
      maximumFuelLevel:(NSUInteger)maximumFuelLevel
            completion:(void (^)(NSArray *vehicles, NSError *error))completion
{
	[_requestBuilder vehiclesInCity:city maximumFuelLevel:maximumFuelLevel completion:completion];
}

- (void)gasStationsInCity:(NSString *)city
                 provider:(NSArray *)provider
               completion:(void (^)(NSArray *gasStations, NSError *error))completion
{
	[_requestBuilder gasStationsInCity:city provider:provider completion:completion];
}


@end