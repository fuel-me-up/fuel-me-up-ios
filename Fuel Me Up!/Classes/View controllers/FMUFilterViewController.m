/**
* Created by Maurício Hanika on 26.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUFilterViewController.h"
#import "FMUMapFilter.h"
#import "FMUStyle.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUFilterViewController ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMUFilterViewController
{
    UISlider *_maximumFuelSlider;
    FMUMapFilter *_mapFilter;
    UILabel *_maximumFuelLabel;


    UILabel *_gasStationLabel;
    UISwitch *_gasStationSwitch;
}

- (id)initWithMapFilter:(FMUMapFilter *)mapFilter
{
    self = [super init];

    if ( self )
    {
        _mapFilter = mapFilter;

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

    CGFloat padding = 18.f;
    _maximumFuelLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 100.f, 55.f, 24.f)];
    [FMUStyle styleFMUFilterLabel:_maximumFuelLabel];
    _maximumFuelLabel.text = [NSString stringWithFormat:@"%d %%", _mapFilter.maximumFuelLevel];
    [self.view addSubview:_maximumFuelLabel];

    _maximumFuelSlider = [[UISlider alloc]
        initWithFrame:CGRectMake(CGRectGetMaxX(_maximumFuelLabel.frame) + padding, 100.f, CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(_maximumFuelLabel.frame) - padding * 2, 24.f)];
    _maximumFuelSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _maximumFuelSlider.minimumValue = 1;
    _maximumFuelSlider.maximumValue = 100;
    _maximumFuelSlider.continuous = YES;
    _maximumFuelSlider.value = _mapFilter.maximumFuelLevel;
    [_maximumFuelSlider addTarget:self
                           action:@selector(maximumFuelLevelUpdated:)
                 forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_maximumFuelSlider];

    _gasStationLabel = [[UILabel alloc] initWithFrame:CGRectMake(
        _maximumFuelLabel.frame.origin.x,
        CGRectGetMaxY(_maximumFuelLabel.frame) + 22.f,
        200.f,
        CGRectGetHeight(_maximumFuelSlider.frame))
    ];
    [FMUStyle styleFMUFilterLabel:_gasStationLabel];
    _gasStationLabel.text = @"Enable Gas-Stations";
    [self.view addSubview:_gasStationLabel];

    _gasStationSwitch = [[UISwitch alloc] init];
    [_gasStationSwitch setFrame:CGRectMake(
        CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(_gasStationSwitch.frame) - padding,
        CGRectGetMinY(_gasStationLabel.frame),
        _gasStationSwitch.frame.size.width,
        _gasStationSwitch.frame.size.height
    )];
    [_gasStationSwitch setOn:_mapFilter.gasStationsEnabled];

    [self.view addSubview:_gasStationSwitch];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Actions

- (void)maximumFuelLevelUpdated:(id)sender
{
    _maximumFuelLabel.text = [NSString stringWithFormat:@"%d %%", ( int ) round(_maximumFuelSlider.value)];
}

- (void)done:(id)done
{
    _mapFilter.maximumFuelLevel = ( NSUInteger ) round(_maximumFuelSlider.value);
    _mapFilter.gasStationsEnabled = _gasStationSwitch.isOn;

    if ( [_delegate respondsToSelector:@selector(filterViewController:didUpdateFilters:)] )
    {
        [_delegate filterViewController:self didUpdateFilters:_mapFilter];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end