/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "AFHTTPSessionManager.h"

@interface FMUAPIClient : AFHTTPSessionManager

+ (instancetype)sharedInstance;

@end