/**
* Created by Maurício Hanika on 27.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUVehicleFilter+FMUPersistence.h"
#import "MTLJSONAdapter.h"

NSString *const FMUCurrentVehicleFilterKey = @"FMUCurrentVehicleFilterKey";

////////////////////////////////////////////////////////////////////////////////
@implementation FMUVehicleFilter (FMUPersistence)

+ (instancetype)defaultFilter
{
    static FMUVehicleFilter *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ( [defaults objectForKey:FMUCurrentVehicleFilterKey] == nil )
        {
            instance = [[FMUVehicleFilter alloc] init];
            instance.maximumFuelLevel = 25;
            instance.city = @"hamburg";

            NSDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:instance];
            [defaults setObject:dictionary forKey:FMUCurrentVehicleFilterKey];
            [defaults synchronize];
        }
        else
        {
            NSDictionary *dictionary = [defaults objectForKey:FMUCurrentVehicleFilterKey];

            NSError *error = nil;
            instance = [[FMUVehicleFilter alloc] initWithDictionary:dictionary error:&error];

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
    [defaults setObject:dictionary forKey:FMUCurrentVehicleFilterKey];
    [defaults synchronize];
}


@end