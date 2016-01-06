//
//  PicUrlsModel.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "PicUrlsModel.h"

@implementation PicUrlsModel


- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = thumbnail_pic;
    
    // 将大图片的地址链接存储下来
    NSString *largePic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
    _large_pic = largePic;
    
}

@end
