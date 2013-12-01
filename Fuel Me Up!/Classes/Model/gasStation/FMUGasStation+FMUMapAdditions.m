/**
* Created by Matthias Steeger on 28.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "MTLModel.h"
#import "FMUGasStation+FMUMapAdditions.h"
#import "FMULocation.h"

////////////////////////////////////////////////////////////////////////////////
@implementation FMUGasStation (FMUMapAdditions)

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return [self.provider componentsJoinedByString:@", "];
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

@end