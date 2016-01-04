//
//  OAuthModel.h
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthModel : NSObject <NSCoding>

@property (nonatomic,copy) NSString *access_token;

@property (nonatomic,copy) NSString *expires_in;

@property (nonatomic,copy) NSString *remind_in;

@property (nonatomic,copy) NSString *uid;

/** 过期时间点*/
@property (nonatomic,copy) NSDate *expiresDate;



@end
