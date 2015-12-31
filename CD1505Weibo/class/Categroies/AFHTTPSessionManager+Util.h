//
//  AFHTTPSessionManager+Util.h
//  CD1505Weibo
//
//  Created by HeHui on 15/12/31.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSInteger,AFHTTPSessionManagerRequestType) {
    AFHTTPSessionManagerRequestTypeGET,
    AFHTTPSessionManagerRequestTypePOST
};

@interface AFHTTPSessionManager (Util)


+ (void)requestWithType:(AFHTTPSessionManagerRequestType)type
              URLString:(NSString *)urlStr
             parmaeters:(id) parameters
                success:(void(^)(NSURLSessionDataTask *task, id responseObject)) success
                failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;



@end
