/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUFilterViewController.h"
#import "FMUVehicleFilter.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUFilterViewController ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMUFilterViewController
{
    UISlider *_maximumFuelSlider;
    FMUVehicleFilter *_vehicleFilter;
    UILabel *_maximumFuelLabel;
}

- (id)initWithVehicleFilter:(FMUVehicleFilter *)vehicleFilter
{
    self = [super init];

    if ( self )
    {
        _vehicleFilter = vehicleFilter;
        
        self.navigationItem.title = @"Filter";
        self.navigationItem.leftBarButtonItem =
            [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                     target:self
                                     action:@selector(done:)];
    }

    return self;
}

- (void)loadView
{
    [super loadView];

    _maximumFuelLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.f, 100.f, 55.f, 24.f)];
    _maximumFuelLabel.text = [NSString stringWithFormat:@"%d %%", _vehicleFilter.maximumFuelLevel];
    _maximumFuelLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _maximumFuelLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_maximumFuelLabel];

    _maximumFuelSlider = [[UISlider alloc]
        initWithFrame:CGRectMake(CGRectGetMaxX(_maximumFuelLabel.frame) + 18.f, 100.f, CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(_maximumFuelLabel.frame) - 36.f, 24.f)];
    _maximumFuelSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _maximumFuelSlider.minimumValue = 1;
    _maximumFuelSlider.maximumValue = 100;
    _maximumFuelSlider.continuous = YES;
    _maximumFuelSlider.value = _vehicleFilter.maximumFuelLevel;
    [_maximumFuelSlider addTarget:self
                           action:@selector(maximumFuelLevelUpdated:)
                 forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_maximumFuelSlider];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Actions

- (void)maximumFuelLevelUpdated:(id)sender
{
    _maximumFuelLabel.text = [NSString stringWithFormat:@"%d %%", (int)round(_maximumFuelSlider.value)];
}

- (void)done:(id)done
{
    _vehicleFilter.maximumFuelLevel = (NSUInteger)round(_maximumFuelSlider.value);
    if ( [_delegate respondsToSelector:@selector(filterViewController:didUpdateFilters:)] )
    {
        [_delegate filterViewController:self didUpdateFilters:_vehicleFilter];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end