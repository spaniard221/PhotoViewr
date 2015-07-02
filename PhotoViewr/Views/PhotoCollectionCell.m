//
//  PhotoCollectionCell.m
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "PhotoCollectionCell.h"

@implementation PhotoCollectionCell


-(void)setUI{
    
    if (self.imgVPhoto==nil){
        
        CGFloat padding=5.0;
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(padding, padding, self.frame.size.width-(padding*2), self.frame.size.height - (padding*2))];
        view.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
        
        
        
        padding=10.0;
        self.imgVPhoto=[[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, view.frame.size.width-(padding*2), view.frame.size.height - (padding*2))];
        
        self.imgVPhoto.contentMode=UIViewContentModeScaleAspectFill;
        
        [view addSubview:self.imgVPhoto];
        
        
        [self addSubview:view];
        
    }
    
}


@end