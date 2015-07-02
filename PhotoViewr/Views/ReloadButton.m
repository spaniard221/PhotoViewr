//
//  ReloadButton.m
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "ReloadButton.h"


@interface ReloadButton()

@property (copy)void (^completeRemovalBlock)(void);

@end

@implementation ReloadButton


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        
        [self setImage:[UIImage imageNamed:@"i-reload"] forState:UIControlStateNormal];
        self.backgroundColor=[UIColor whiteColor];
        self.contentEdgeInsets=UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
        
        self.layer.cornerRadius=6.0;
        self.layer.borderColor=[[UIColor darkGrayColor] CGColor];
        self.layer.borderWidth=1.0;
        self.layer.shadowColor=[[UIColor blackColor] CGColor];
        self.layer.shadowOffset=CGSizeMake(2.0, 2.0);
        self.layer.shadowRadius=10.0;
        self.layer.shadowOpacity=8.0;
    }
    
    return self;
}


-(void)showWithAnimationInView:(UIView *)view{
    
    [self setPositionInsideViewFrame:view.frame];
    
    self.alpha=0.0;
    self.translatesAutoresizingMaskIntoConstraints=NO;
    self.transform=CGAffineTransformMakeScale(0.0, 0.0);
    
    [view addSubview:self];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha=1.0;
        self.transform=CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

-(void)removeWithAnimation:(void(^)(void))block{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.transform=CGAffineTransformMakeScale(0.01, 0.01);
        self.alpha=0.0;
        
    } completion:^(BOOL finished){
        
        
        self.completeRemovalBlock=block;
        
        [self removeFromSuperview];
        [self completeButtonRemoval];
    }];
}

-(void)completeButtonRemoval{
    
    if (self.completeRemovalBlock != nil)
        self.completeRemovalBlock();
}

-(void)setPositionInsideViewFrame:(CGRect)vFrame{
    
    CGRect frame=self.frame;
    
    CGFloat xPos=(vFrame.size.width  - frame.size.width)/2;
    CGFloat yPos= (vFrame.size.height - frame.size.height)/2;
    frame.origin=CGPointMake(xPos, yPos);
    
    self.frame=frame;
}

@end

