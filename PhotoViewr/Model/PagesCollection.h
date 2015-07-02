//
//  PagesCollection.h
//  PhotoViewr
//
//  Created by Alex on 02/07/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"



@interface PagesCollection : NSObject


+ (id)sharedManager;

-(NSInteger)numberOfPagesLoaded;
-(NSInteger)lastPageLoaded;
-(Page *)pageAtIndex:(NSInteger)index;
-(void)setLastPageLoaded:(NSInteger)lastPage;
-(void)clearAllPhotosExceptForCurrentPage:(NSInteger)cPage;
-(void)addPage:(Page *)page;
-(BOOL)canRequestMorePagesFromAPI;

@end
