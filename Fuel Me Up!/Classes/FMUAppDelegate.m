//
//  FMUAppDelegate.m
//  Fuel Me Up!
//
//  Created by Maurício Hanika on 26.11.13.
//  Copyright (c) 2013 Maurício Hanika. All rights reserved.
//

#import "FMUAppDelegate.h"
#import "FMUMapViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "FMUMapFilter.h"
#import "FMUMapFilter+FMUPersistence.h"

@implementation FMUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup networking
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    // Setup logging
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    // Setup user interface
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    FMUMapViewController *mapViewController = [[FMUMapViewController alloc] init];

    UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:mapViewController];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [FMUMapFilter persistDefaultFilter];
}


@end
