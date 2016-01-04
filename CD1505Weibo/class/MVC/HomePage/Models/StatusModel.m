//
//  StatusModel.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "StatusModel.h"

#import "PicUrlsModel.h"

@implementation StatusModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ct":@"created_at"};
}


/** 告诉pic_urls里面应该去装PicUrlsModel的对象*/

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls":@"PicUrlsModel"};
}


@end





