//
//  APIHandler.h
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface APIHandler : NSObject

+(NSString *)flickrPhotoListURL;
+(NSString *)photoURL:(Photo *)photo isThumbnail:(BOOL)isThumb;

@end
