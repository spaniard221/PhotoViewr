//
//  Page.m
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "Page.h"
#import "Photo.h"


@implementation Page

-(instancetype)initWithJSON:(NSDictionary *)json{
    
    self=[super init];
    if (self) {
        
      
        self.pageNumber=[self obtainIntegerValueFromDictionary:json WithKey:@"page"];
        self.photoCount=[self obtainIntegerValueFromDictionary:json WithKey:@"perpage"];
        self.totalPages=[self obtainIntegerValueFromDictionary:json WithKey:@"pages"];
        
        
        NSArray *tmp=json[@"photo"];
        self.photos=[NSMutableArray array];
        if (tmp != nil){
            
            for (NSDictionary *photo in tmp) {
                
                // Add current photo object to collection
                [self.photos addObject:[[Photo alloc] initWithJSON:photo]];
            }
        }
    }

    return self;
}

-(NSInteger)obtainIntegerValueFromDictionary:(NSDictionary *)json WithKey:(NSString *)key{

    return (NSNull *)json[key] != [NSNull null] ? [json[key] integerValue] : 0;
}


@end