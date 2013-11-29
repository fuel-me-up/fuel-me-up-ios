/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Foundation/Foundation.h>

@class NSURLSessionDataTask;

@interface FMURequestBuilder : NSObject

- (NSURLSessionDataTask *)vehiclesInCity:(NSString *)city
                          maximumFuelLevel:(NSUInteger)maximumFuelLevel
                                completion:(void (^)(NSArray *, NSError *))completion;

- (NSURLSessionDataTask *)gasStationsInCity:(NSString *)city
                                   provider:(NSArray *)provider
                                 completion:(void (^)(NSArray *, NSError *))completion;
@end