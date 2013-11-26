/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import <Foundation/Foundation.h>

@class FMUFilterViewController;
@class FMUVehicleFilter;

////////////////////////////////////////////////////////////////////////////////
@protocol FMUFilterViewControllerDelegate <NSObject>

- (void)filterViewController:(FMUFilterViewController *)controller didUpdateFilters:(FMUVehicleFilter *)filter;

@end


////////////////////////////////////////////////////////////////////////////////
@interface FMUFilterViewController : UIViewController

@property(nonatomic, weak) id <FMUFilterViewControllerDelegate> delegate;

- (id)initWithVehicleFilter:(FMUVehicleFilter *)vehicleFilter;
@end