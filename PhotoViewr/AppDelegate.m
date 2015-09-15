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

@property (strong, nonatomic) UINavigationController *naviController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:144.0/255.0 blue:62.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *dTextAttribs=@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:dTextAttribs];
    
    
    PhotosVC *photosVC=[PhotosVC new];
    self.naviController=[[UINavigationController alloc] initWithRootViewController:photosVC];
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
