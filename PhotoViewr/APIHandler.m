//
//  APIHandler.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "APIHandler.h"
#import "Page.h"
#import <AFNetworking/AFNetworking.h>



#define FLICKR_API_URL @"https://api.flickr.com/services/rest/?"
#define FLICKR_API_RESPONSE_FORMAT @"format=json&nojsoncallback=1"

#define FLICKR_API_KEY @"4afd2e23e842a6f04cb7a25ee57f2581"
#define FLICKR_API_METHOD_GET_PHOTOS @"method=flickr.photos.search"
#define FLICKR_API_PARAM_KEY @"api_key="
#define FLICKR_API_PARAM_PAGE @"page="
#define FLICKR_API_PARAM_TAGS @"tags="
#define FLICKR_API_VALUES_TAGS @"Party"
#define FLICKR_API_PARAM_ITEMS_PER_PAGE @"&per_page="
#define FLICKR_API_VALUES_NUM_ITEMS_PER_PAGE @"96"
#define FLICKR_API_PARAM_PRIVACY_FILTER @"privacy_filter="
#define FLICKR_API_VALUES_PRIVACY_FILTER @"1"

#define FLICKR_IMAGE_URL_START @"http://farm"
#define FLICKR_IMAGE_HOST @"staticflickr.com"
#define FILE_TYPE @".jpg"
#define IMAGE_SIZE_THUMB_TYPE @"q"
#define IMAGE_SIZE_FULL_TYPE @"b"

#define TIMEOUT_VALUE 10.0


@interface APIHandler()

@property (copy)void (^completionBlock)(Response *response);

@end


@implementation APIHandler



#pragma mark Static functions and methods

+ (id)sharedManager{
    
    static APIHandler *apiHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        apiHandler = [[self alloc] init];
        
        
    });
    return apiHandler;
}

+(NSString *)flickrPhotoListURLForPage:(NSInteger)page{
    
    NSString *url=[NSString stringWithFormat:@"%@%@&%@%@&%@%@&%@%@&%@%d&%@%@&%@",
                   FLICKR_API_URL,
                   FLICKR_API_METHOD_GET_PHOTOS,
                   FLICKR_API_PARAM_KEY,
                   FLICKR_API_KEY,
                   FLICKR_API_PARAM_TAGS,
                   FLICKR_API_VALUES_TAGS,
                   FLICKR_API_PARAM_PRIVACY_FILTER,
                   FLICKR_API_VALUES_PRIVACY_FILTER,
                   FLICKR_API_PARAM_PAGE,
                   (uint32_t)page,
                   FLICKR_API_PARAM_ITEMS_PER_PAGE,
                   FLICKR_API_VALUES_NUM_ITEMS_PER_PAGE,
                   FLICKR_API_RESPONSE_FORMAT];
    
    
    return url;
}

+(NSString *)photoURL:(Photo *)photo isThumbnail:(BOOL)isThumb{
    
    NSString *host=FLICKR_IMAGE_HOST;
    NSString *fType=FILE_TYPE;
    NSString *pSize=IMAGE_SIZE_FULL_TYPE;
    
    
    // When thumb=true, then smaller image for gallery screen
    // else photo detail screen
    if (isThumb)
        pSize=IMAGE_SIZE_THUMB_TYPE;
    
    NSString *url=[NSString stringWithFormat:@"%@%@.%@/%@/%@_%@_%@%@",
                   FLICKR_IMAGE_URL_START,
                   photo.farm,
                   host,
                   photo.server,
                   photo.id_,
                   photo.secret,
                   pSize,
                   fType];
    
    return url;
}




#pragma mark Instance

- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

-(void)getFlickrPhotoListWithPageNumber:(NSInteger)pageN Completion:(void(^)(Response *response))completion{
    
    self.completionBlock=completion;
    
    
    Response *responseReturn=[Response new];
    responseReturn.errorOccured=NO;
    
    
    NSString *url=[APIHandler flickrPhotoListURLForPage:pageN];
    
    // Instantiate connection
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:10.0];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        if (responseObject[@"message"] != nil){
            
            responseReturn.error=responseObject[@"message"];
            responseReturn.errorOccured=YES;
        }
        else{
            
            NSDictionary *jPhotos=responseObject[@"photos"];
            if (jPhotos == nil)
                responseReturn.error=NSLocalizedString(@"no_response_from_server", nil);
            
            else{
                responseReturn.object=[[Page alloc] initWithJSON:jPhotos];
                if (responseReturn.object==nil)
                    responseReturn.error=NSLocalizedString(@"unexpected_error_while_processing_data", nil);
                
                else{
                    Page *page=(Page *)responseReturn.object;
                    if (page.photos.count == 0)
                        responseReturn.error=NSLocalizedString(@"no_photos_found", nil);
                }
            }
        }
        
        
        self.completionBlock(responseReturn);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        responseReturn.error=[error localizedDescription];
        responseReturn.errorOccured=YES;
        
        self.completionBlock(responseReturn);
    }];
}




@end