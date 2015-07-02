//
//  PhotoCollectionCell.h
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionCell : UICollectionViewCell

@property (retain, nonatomic) UIImageView *imgVPhoto;
@property (retain, nonatomic) UIImageView *imgVBg;


-(void)setUI;

@end
