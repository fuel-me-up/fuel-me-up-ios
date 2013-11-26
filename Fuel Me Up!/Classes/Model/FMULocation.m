/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMULocation.h"
#import "MTLValueTransformer.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMULocation ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMULocation

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(_latitude, _longitude);
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

@end