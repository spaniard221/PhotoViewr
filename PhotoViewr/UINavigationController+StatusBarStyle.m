//
//  UINavigationController+StatusBarStyle.m
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"



@implementation UINavigationController (StatusBarStyle)


-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent; // your own style
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end