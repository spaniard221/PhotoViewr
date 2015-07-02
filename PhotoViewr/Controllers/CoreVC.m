//
//  CoreVC.m
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//


#import "CoreVC.h"
#import "UIImage+ImageEffects.h"


@interface CoreVC ()

@end

@implementation CoreVC


-(void)loadView{
    
    [super loadView];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGRect fr= self.view.frame;
    fr.size.height= fr.size.height -  (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
    self.view.frame=fr;
    
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}






#pragma mark Public functions and methods

-(void)setNavigationTitle:(NSString *)title{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, self.navigationController.navigationBar.frame.size.height)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    self.navigationItem.titleView=titleLabel;
}

-(NSString *)appName{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
}


-(void)setUpBgImage:(UIImage *)image WithWidth:(CGFloat)width Height:(CGFloat)height{
    
    UIImage *img=[image applyLightEffect];
    UIImageView *imgVBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [imgVBg setImage:img];
    [self.view addSubview:imgVBg];
    
}

-(void)showLoader:(BOOL)show{
    
    if (show){
        
        // Start loader indicator
        [SVProgressHUD setForegroundColor:[UIColor orangeColor]];
        [SVProgressHUD show];
    }
    else
        [SVProgressHUD dismiss];
}


-(void)showAlertWithText:(NSString *)text {
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[self appName]
                                                  message:text
                                                 delegate:nil
                                        cancelButtonTitle:NSLocalizedString(@"button_text_ok", nil)
                                        otherButtonTitles:nil, nil];
    [alert show];
    
}







#pragma mark Warnings

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end



