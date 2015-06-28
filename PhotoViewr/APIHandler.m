//
//  APIHandler.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "APIHandler.h"

#define FLICKR_API_URL @"https://api.flickr.com/services/rest/?"
#define FLICKR_API_RESPONSE_FORMAT @"format=json"

#define FLICKR_API_KEY @"e597df67c34b04f512690cdaa6b0ce1a"
#define FLICKR_API_METHOD_GET_PHOTOS @"method=flickr.photos.search"
#define FLICKR_API_PARAM_KEY @"api_key="
#define FLICKR_API_PARAM_TAGS @"tags="
#define FLICKR_API_VALUES_TAGS @"Party"
#define FLICKR_API_PARAM_PRIVACY_FILTER @"privacy_filter="
#define FLICKR_API_VALUES_PRIVACY_FILTER @"1"

@implementation APIHandler


+(NSString *)flickrPhotoListURL{

    //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e597df67c34b04f512690cdaa6b0ce1a&tags=Party&privacy_filter=1&page=3&format=json&nojsoncallback=1
    NSString *url=[NSString stringWithFormat:@"%@%@%@%@%@%@",
                   FLICKR_API_URL,
                   FLICKR_API_PARAM_KEY,
                   FLICKR_API_KEY,
                   FLICKR_API_PARAM_TAGS,
                   FLICKR_API_VALUES_TAGS,
                   FLICKR_API_RESPONSE_FORMAT];
    
    
    return url;
}

+(NSString *)photoURL:(Photo *)photo isThumbnail:(BOOL)isThumb{

    //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    NSString *host=@"staticflickr.com";
    NSString *fType=@".jpg";
    NSString *pSize=@"o";
    
    // When thumb=true, then smaller image for gallery screen
    // else photo detail screen
    if (isThumb)
        pSize=@"q";
    
    NSString *url=[NSString stringWithFormat:@"farm%@.%@/%@/%@_%@_%@%@",
                   photo.pFarm,
                   host,
                   photo.pServer,
                   photo.id_,
                   photo.pSecret,
                   pSize,
                   fType];
    
    
    return url;
}


@end
