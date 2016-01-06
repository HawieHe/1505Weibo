//
//  StatusModel.h
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import <MJExtension.h>

@interface StatusModel : BaseModel

/** 发布时间*/
//@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *ct;


/** 微博ID*/
@property (nonatomic, copy) NSString *idstr;

/** 微博文字内容*/
@property (nonatomic, copy) NSString *text;

/** 来源*/
@property (nonatomic, copy) NSString *source;

/** 微博图片内容的数组*/
@property (nonatomic, strong) NSArray *pic_urls;

/** 微博发布的用户*/
@property (nonatomic, strong) UserModel *user;


/** 转发数*/
@property (nonatomic, assign) long long reposts_count;

/** 评论数*/
@property (nonatomic, assign) long long comments_count;

/** 点赞数*/
@property (nonatomic, assign) long long attitudes_count;

/** 转发的微博*/
@property (nonatomic, strong) StatusModel *retweeted_status;


@end
