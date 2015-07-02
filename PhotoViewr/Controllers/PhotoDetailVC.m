//
//  PhotoDetailVC.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "PhotoDetailVC.h"

@interface PhotoDetailVC ()

@property (retain, nonatomic) Photo *photoSelected;
@property (retain, nonatomic) UIImage *imageBg;

@end

@implementation PhotoDetailVC

-(instancetype)initWithPhoto:(Photo *)photo Image:(UIImage *)image{
    
    self=[super init];
    if (self) {
        
        self.photoSelected=photo;
        self.imageBg=image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
