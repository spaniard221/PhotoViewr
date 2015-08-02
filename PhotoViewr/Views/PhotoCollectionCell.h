//
//  PhotoCollectionCell.h
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imgVPhoto;
@property (strong, nonatomic) UIImageView *imgVBg;


-(void)setUI;

@end
