//
//  AppDelegate.m
//  GamesApp
//
//  Created by Michal Piwowarczyk on 21.09.2013.
//  Copyright (c) 2013 MichalPiwowarczyk. All rights reserved.
//

#import "AppDelegate.h"
#import "Store.h"
#import "MainViewController.h"

@interface AppDelegate()
@property (nonatomic, strong) Store* store;
@property (nonatomic, strong) MainViewController *mainViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.store = [[Store alloc] init];
    self.mainViewController = [[MainViewController alloc] initWithStore:self.store];
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.store saveContext];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.mainViewController downloadData];
}

@end
