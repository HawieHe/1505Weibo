//
//  WBTabBarButton.h
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTabBarButton : UIButton

/** 是图片高度占整个按钮高度的比例  0 ~ 1 默认是0.6*/
@property (nonatomic, assign) CGFloat ratio;

/** */
@property (nonatomic, strong) UITabBarItem *tabBarItem;

@end
