//
//  AFHTTPSessionManager+Util.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/31.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "AFHTTPSessionManager+Util.h"

@implementation AFHTTPSessionManager (Util)


+ (void)requestWithType:(AFHTTPSessionManagerRequestType)type URLString:(NSString *)urlStr parmaeters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;

    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", nil];
    if (type == AFHTTPSessionManagerRequestTypeGET) {
        [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * ta, id res) {
            success(ta,res);
        } failure:^(NSURLSessionDataTask * ta, NSError * err) {
            failure(ta,err);
        }];
        
        
    }else if (type == AFHTTPSessionManagerRequestTypePOST) {
        [manager POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * ta, id res) {
            success(ta,res);

        } failure:^(NSURLSessionDataTask * ta, NSError * err) {
            failure(ta,err);

        }];

    }
}


@end
