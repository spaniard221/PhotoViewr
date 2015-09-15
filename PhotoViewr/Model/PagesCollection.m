//
//  PagesCollection.m
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "PagesCollection.h"

@interface PagesCollection()

@property (strong, nonatomic) NSMutableArray *pagesArr;
@property (assign, nonatomic) NSInteger totalPagesFromAPI;
@end

@implementation PagesCollection


+ (instancetype)sharedManager{
    
    static PagesCollection *pagesCollection = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        pagesCollection = [[self alloc] init];
        
        
    });
    return pagesCollection;
}



-(instancetype)init{
    
    self=[super init];
    if (self) {
        
        self.lastPageLoaded=0;
        self.totalPagesFromAPI=0;
    }
    
    return self;
}

-(NSInteger)numberOfPagesLoaded{
    
    return self.pagesArr.count;
}

-(Page *)pageAtIndex:(NSInteger)index{
    
    if (index >= self.pagesArr.count || index < 0) return nil;
    
    return self.pagesArr[index];
}

-(BOOL)canRequestMorePagesFromAPI{
    
    if (self.pagesArr.count < self.totalPagesFromAPI) return YES;
    
    return NO;
}

-(void)addPage:(Page *)page{
    
    if (self.pagesArr==nil) self.pagesArr=[NSMutableArray array];
    
    self.totalPagesFromAPI=page.totalPages;
    
    BOOL found=NO;
    for (int i=0; i < self.pagesArr.count; i++) {
        
        Page *current=self.pagesArr[i];
        if (current.pageNumber==page.pageNumber){
            
            found=YES;
            [self.pagesArr replaceObjectAtIndex:i withObject:page];
            break;
        }
    }

    
    if (!found)
        [self.pagesArr addObject:page];
    
}

-(void)clearAllPhotosExceptForCurrentPage:(NSInteger)cPage{
    
    for (Page *page in self.pagesArr) {
        
        if (cPage != page.pageNumber){
            [page.photos removeAllObjects];
            page.photos = nil;
        }
    }
}

@end
