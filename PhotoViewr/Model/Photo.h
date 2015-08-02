//
//  Photo.h
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSString *id_;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *secret;
@property (strong, nonatomic) NSString *server;
@property (strong, nonatomic) NSString *farm;
@property (strong, nonatomic) NSString *title;


-(instancetype)initWithJSON:(NSDictionary *)json;


@end
