/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface FMUMapFilter : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSUInteger maximumFuelLevel;
@property(nonatomic, copy) NSString *city;

@property(nonatomic, assign) BOOL gasStationsEnabled;
@property(nonatomic, strong)NSArray *providerForGasStation;

@end