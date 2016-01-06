//
//  PicUrlsModel.h
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "BaseModel.h"

@interface PicUrlsModel : BaseModel

/** 图片缩略图链接*/
@property (nonatomic, copy) NSString *thumbnail_pic;

/** 图片大图链接*/
@property (nonatomic, copy) NSString *large_pic;

@end
