//
//  Photo.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "Photo.h"

#define SET_IF_NOT_NULL(TARGET, VAL) if(VAL != [NSNull null]) { TARGET = VAL; }

@implementation Photo


-(instancetype)initWithJSON:(NSDictionary *)json{

    self=[super init];
    if (self) {
        
        SET_IF_NOT_NULL(self.id_, json[@"id"]);
        SET_IF_NOT_NULL(self.owner, json[@"owner"]);
        SET_IF_NOT_NULL(self.secret, json[@"secret"]);
        SET_IF_NOT_NULL(self.server, json[@"server"]);
        SET_IF_NOT_NULL(self.farm, json[@"farm"]);
        SET_IF_NOT_NULL(self.title, json[@"title"]);
        
    }
    
    return self;
}


@end
