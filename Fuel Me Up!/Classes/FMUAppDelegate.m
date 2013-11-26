//
//  FMUAppDelegate.m
//  Fuel Me Up!
//
//  Created by Maurício Hanika on 26.11.13.
//  Copyright (c) 2013 Maurício Hanika. All rights reserved.
//

#import "FMUAppDelegate.h"
#import "FMUMapViewController.h"

@implementation FMUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[FMUMapViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
