/**
* Created by Maurício Hanika on 27.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUMapFilter+FMUPersistence.h"

NSString *const FMUCurrentMapFilterKey = @"FMUCurrentMapFilterKey";

////////////////////////////////////////////////////////////////////////////////
@implementation FMUMapFilter (FMUPersistence)

+ (instancetype)defaultFilter
{
    static FMUMapFilter *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ( [defaults objectForKey:FMUCurrentMapFilterKey] == nil )
        {
            instance = [[FMUMapFilter alloc] init];
            instance.maximumFuelLevel = 25;
            instance.city = @"hamburg";
            instance.gasStationsEnabled = YES;
            instance.providerForGasStation = @[@"car2go",@"drive-now"];

            NSDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:instance];
            [defaults setObject:dictionary forKey:FMUCurrentMapFilterKey];
            [defaults synchronize];
        }
        else
        {
            NSDictionary *dictionary = [defaults objectForKey:FMUCurrentMapFilterKey];

            NSError *error = nil;
            instance = [[FMUMapFilter alloc] initWithDictionary:dictionary error:&error];

            if ( instance == nil )
            {
                DDLogVerbose(@"Error deseializing from user defaults: %@", error);
            }
        }
    });

    return instance;
}

+ (void)persistDefaultFilter
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:[[self class] defaultFilter]];
    [defaults setObject:dictionary forKey:FMUCurrentMapFilterKey];
    [defaults synchronize];
}


@end