/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUAPIClient.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUAPIClient ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMUAPIClient

+ (instancetype)sharedInstance
{
    static FMUAPIClient *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [configuration setHTTPAdditionalHeaders:@{
            @"Accept" : @"application/json; encoding='utf-8'"
        }];

        NSURL *URL = [NSURL URLWithString:FMUHTTPBackendURL];
        instance = [[FMUAPIClient alloc] initWithBaseURL:URL sessionConfiguration:configuration];
    });

    return instance;
}


@end