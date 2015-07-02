//
//  CoreVC.h
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "UINavigationController+StatusBarStyle.h"

#import "APIHandler.h"



@interface CoreVC : UIViewController

-(void)setNavigationTitle:(NSString *)title;
-(void)setUpBgImage:(UIImage *)image WithWidth:(CGFloat)width Height:(CGFloat)height;
-(void)showLoader:(BOOL)show;
-(void)showAlertWithText:(NSString *)text ;

-(NSString *)appName;

@end