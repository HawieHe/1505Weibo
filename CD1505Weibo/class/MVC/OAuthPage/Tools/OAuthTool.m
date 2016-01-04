//
//  OAuthTool.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "OAuthTool.h"

#define ArchivePath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"OAuth.data"]

@implementation OAuthTool

+ (BOOL)saveOAuthInfoWithModel:(OAuthModel *)model
{
    // 生成归档存储的路径

    
    // app/xxxx/documents
    
    // 归档存到文件里面
   return  [NSKeyedArchiver archiveRootObject:model toFile:ArchivePath];
}


+ (OAuthModel *)fetchOAuthModel
{
    // 假如已经过过期，返回nil。或抛出异常
    NSDate *nowDate = [NSDate date];
    
    OAuthModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:ArchivePath];
    
    if ([model.expiresDate compare:nowDate]==NSOrderedDescending) {
        return model;
    }else {
        return nil;
    }
    
}



@end
