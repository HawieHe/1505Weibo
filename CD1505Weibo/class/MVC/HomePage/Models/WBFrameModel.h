//
//  WBFrameModel.h
//  CD1505Weibo
//
//  Created by HeHui on 16/1/5.
//  Copyright © 2016年 Hawie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StatusModel.h"

@interface WBFrameModel : NSObject

/** 通过StatusModel，提前计算出每个控件的frame*/
@property (nonatomic,strong) StatusModel *statusModel;


/** 第一块*/
/** 一、顶部背景图层*/
@property (nonatomic,assign) CGRect topBackgroundViewFrame;
/** 1.用户图像*/
@property (nonatomic, assign) CGRect userIconImageViewFrame;

/** 2.用户是否是验证用户图标*/
@property (nonatomic, assign) CGRect userVerifyImageViewFrame;

/** 3.用户名*/
@property (nonatomic, assign) CGRect userNameLabelFrame;

/** 4.用户vip等级图标*/
@property (nonatomic, assign) CGRect userVipLevelImageViewFrame;

/** 5.微博发布时间*/
@property (nonatomic, assign) CGRect wbCreateTimeLabelFrame;

/** 6.微博来源*/
@property (nonatomic, assign) CGRect wbSourceLabelFrame;


/** 第二块*/
/** 二、用户自己发布的微博内容背景图层*/
@property (nonatomic, assign) CGRect secondBackgroundViewFrame;

/** 1.微博文字内容*/
@property (nonatomic, assign) CGRect wbContentLableFrame;

/** 2.微博图片内容的背景图层*/
@property (nonatomic, assign) CGRect wbPicsBackgroundViewFrame;

/** 第三块*/
/** 三、用户转发微博内容的背景图层*/
@property (nonatomic, assign) CGRect rwBackgroundViewFrame;

/** 1.转发微博的文字内容*/
@property (nonatomic, assign) CGRect rwWBContentLableFrame;

/** 2.转发微博的图片的背景图层*/
@property (nonatomic, assign) CGRect rwWBPicsBackgroundViewFrame;


/** 第四块*/
/** 四、底部操作栏图层*/
@property (nonatomic, assign)CGRect bottomBackgroundViewFrame;

/** 1.转发按钮*/
@property (nonatomic, assign) CGRect repostButtonFrame;

/** 2.评论按钮*/
@property (nonatomic, assign) CGRect commentButtonFrame;

/** 3.点赞按钮*/
@property (nonatomic, assign) CGRect attitudeButtonFrame;

/** cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;


@end
