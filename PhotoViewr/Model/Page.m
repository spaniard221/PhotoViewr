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
        
        
        if ((NSNull *)[json objectForKey:@"page"] != [NSNull null])
            self.pageNumber=[[json objectForKey:@"page"] integerValue];
        
        if ((NSNull *)[json objectForKey:@"perpage"] != [NSNull null])
            self.photoCount=[[json objectForKey:@"perpage"] integerValue];
        
        
        if ((NSNull *)[json objectForKey:@"pages"] != [NSNull null])
            self.totalPages=[[json objectForKey:@"pages"] integerValue];
        
        NSArray *tmp=[json objectForKey:@"photo"];
        self.photos=[NSMutableArray array];
        if (tmp != nil){
            
            // Loop through the array
            for (NSDictionary *photo in tmp) {
                
                // Add current photo object to collection
                [self.photos addObject:[[Photo alloc] initWithJSON:photo]];
            }
        }
        else
            self.photos=nil;
        
    }

    return self;
}


@end