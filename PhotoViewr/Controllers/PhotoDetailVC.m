//
//  PhotoDetailVC.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "PhotoDetailVC.h"

@interface PhotoDetailVC ()<UIScrollViewDelegate>

@property (retain, nonatomic) Photo *photoSelected;
@property (retain, nonatomic) UIImage *imageBg;

@property (retain, nonatomic) UIScrollView *scrollView;

@property (retain, nonatomic) UIImageView *imgVPhoto;


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

-(void)loadView{
    
    [super loadView];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=self.view.frame.size.height;
    
    [self setNavigationTitle:self.photoSelected.title];
    
    [self setUpBgImage:self.imageBg WithWidth:width Height:height];
    
    
    [self setupScrollViewWithWidth:width Height:height];
    
    [self setupPhotoViewWithWidth:width Height:height];
    
    
    [self showLoader:YES];
    
    [self.imgVPhoto sd_setImageWithURL:[NSURL URLWithString:[APIHandler photoURL:self.photoSelected isThumbnail:NO]]
                             completed:^(UIImage *image, NSError *error,
                                         SDImageCacheType cacheType, NSURL *imageURL){
                                 
                                 
                                 [self showLoader:NO];
                                 
                                 
                                 if (error != nil)
                                     [self showAlertWithText:[error localizedDescription]];
                                 
                             }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}






#pragma mark Private functions and methods

-(void)setupScrollViewWithWidth:(CGFloat)width Height:(CGFloat)height{
    
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.scrollView.backgroundColor=[UIColor clearColor];
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.contentSize = self.imgVPhoto.frame.size;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

-(void)setupPhotoViewWithWidth:(CGFloat)width Height:(CGFloat)height{
    
    self.imgVPhoto=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.imgVPhoto.contentMode=UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.imgVPhoto];
}






#pragma mark UIScrolView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imgVPhoto;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{}






#pragma mark Warnings

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
