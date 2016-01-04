//
//  UserModel.h
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

/** 用户ID*/
@property (nonatomic, copy) NSString *idstr;

/** 用户名称*/
@property (nonatomic, copy) NSString *name;

/** 用户图像*/
@property (nonatomic, copy) NSString *profile_image_url;
/** 是否是认证用户*/
@property (nonatomic, assign) BOOL verified;

/** 认证类型*/
@property (nonatomic, assign) NSInteger verified_type;

/** vip等级*/
@property (nonatomic, assign) NSInteger mbrank;

/** vip类型*/
@property (nonatomic, assign) NSInteger mbtype;


@end
