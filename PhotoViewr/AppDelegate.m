//
//  AppDelegate.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "AppDelegate.h"
#import "PhotosVC.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface AppDelegate ()

@property (retain, nonatomic) UINavigationController *naviController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    PhotosVC *photosVC=[PhotosVC new];
    self.naviController=[[UINavigationController alloc] initWithRootViewController:photosVC];
    [self.naviController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:144.0/255.0 blue:62.0/255.0 alpha:1.0]];
    self.naviController.navigationBar.tintColor=[UIColor whiteColor];
    [self.naviController.navigationBar setTranslucent:NO];
    
    
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController=self.naviController;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
