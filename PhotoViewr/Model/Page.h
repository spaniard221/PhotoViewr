//
//  Page.h
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject

@property (retain, nonatomic) NSMutableArray *photos;
@property (assign, nonatomic) NSInteger photoCount;
@property (assign, nonatomic) NSInteger pageNumber;
@property (assign, nonatomic) NSInteger totalPages;

-(instancetype)initWithJSON:(NSDictionary *)json;


@end
