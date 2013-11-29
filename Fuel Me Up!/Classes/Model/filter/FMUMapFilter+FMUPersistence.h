/**
* Created by Maurício Hanika on 27.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import "FMUMapFilter.h"

extern NSString * const FMUCurrentMapFilterKey;

@interface FMUMapFilter (FMUPersistence)

+ (instancetype)defaultFilter;
+ (void)persistDefaultFilter;

@end