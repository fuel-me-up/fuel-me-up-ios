/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface FMURequestHandler : NSObject

- (void)vehiclesInCity:(NSString *)city
      maximumFuelLevel:(NSUInteger)maximumFuelLevel
            completion:(void (^)(NSArray *vehicles, NSError *error))completion;

- (void)gasStationsInCity:(NSString *)city
                 provider:(NSArray *)provider
               completion:(void (^)(NSArray *gasStations, NSError *error))completion;
@end