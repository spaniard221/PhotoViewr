//
//  LoaderCollectionCell.h
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoaderCollectionCell : UICollectionViewCell

@property (retain, nonatomic) UIActivityIndicatorView *loader;

-(void)setUpUI;

@end