//
//  APIHandler.h
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "Response.h"

@interface APIHandler : NSObject

+ (id)sharedManager;
+(NSString *)flickrPhotoListURLForPage:(NSInteger)pag;
+(NSString *)photoURL:(Photo *)photo isThumbnail:(BOOL)isThumb;

-(void)getFlickrPhotoListWithPageNumber:(NSInteger)pageN Completion:(void(^)(Response *response))completion;
@end