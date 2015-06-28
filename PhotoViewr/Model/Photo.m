//
//  Photo.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "Photo.h"

@implementation Photo


-(instancetype)initWithJSON:(NSDictionary *)json{

    self=[super init];
    if (self) {
        
        if ((NSNull *)[json objectForKey:@"id"] != [NSNull null])
            self.id_=[json objectForKey:@"id"];

        if ((NSNull *)[json objectForKey:@"owner"] != [NSNull null])
            self.pOwner=[json objectForKey:@"owner"];
        
        if ((NSNull *)[json objectForKey:@"secret"] != [NSNull null])
            self.pSecret=[json objectForKey:@"secret"];
        
        if ((NSNull *)[json objectForKey:@"server"] != [NSNull null])
            self.pServer=[json objectForKey:@"server"];
        
        if ((NSNull *)[json objectForKey:@"farm"] != [NSNull null])
            self.pFarm=[json objectForKey:@"farm"];
        
        if ((NSNull *)[json objectForKey:@"title"] != [NSNull null])
            self.pTitle=[json objectForKey:@"title"];
        
    }
    
    return self;
}


@end
