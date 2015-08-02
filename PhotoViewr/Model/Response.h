//
//  Response.h
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property (strong, nonatomic) NSObject *object;
@property (strong, nonatomic) NSString *error;
@property (assign, nonatomic) BOOL errorOccured;

@end
