/**
* Created by Matthias Steeger on 28.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import <Mantle/MTLJSONAdapter.h>

@class FMULocation;

@interface FMUGasStation : MTLModel <MTLJSONSerializing> {
@protected
    NSString *_availableProviderString;
}

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) FMULocation *location;
@property(nonatomic, strong) NSArray *provider;

@end