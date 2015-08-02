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
        
        SET_IF_NOT_NULL(self.id_, [json objectForKey:@"id"]);
        SET_IF_NOT_NULL(self.owner, [json objectForKey:@"owner"]);
        SET_IF_NOT_NULL(self.secret, [json objectForKey:@"secret"]);
        SET_IF_NOT_NULL(self.server, [json objectForKey:@"server"]);
        SET_IF_NOT_NULL(self.farm, [json objectForKey:@"farm"]);
        SET_IF_NOT_NULL(self.title, [json objectForKey:@"title"]);
        
    }
    
    return self;
}


@end
