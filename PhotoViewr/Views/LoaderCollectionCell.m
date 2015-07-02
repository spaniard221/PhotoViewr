//
//  LoaderCollectionCell.m
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "LoaderCollectionCell.h"



@implementation LoaderCollectionCell

-(void)setUpUI{
    
    if (self.loader==nil){
        
        self.loader=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        CGRect frame=self.loader.frame;
        frame.origin=CGPointMake((self.frame.size.width - frame.size.width)/2, (self.frame.size.height - frame.size.height)/2);
        self.loader.frame=frame;
        self.loader.color=[UIColor whiteColor];
        self.loader.hidesWhenStopped=YES;
        
        [self addSubview:self.loader];
        
    }
    
    [self.loader startAnimating];
}

@end