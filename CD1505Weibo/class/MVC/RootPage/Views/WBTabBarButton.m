//
//  WBTabBarButton.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "WBTabBarButton.h"

@implementation WBTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ratio = 0.6;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}


- (void)setRatio:(CGFloat)ratio
{
    if (ratio <0 || ratio >1) {
        NSException *expre = [NSException exceptionWithName:@"异常提示" reason:@"参数范围不在0~1之间" userInfo:nil];
        
        @throw  expre;
    }else {
        _ratio = ratio;
 
    }
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    [self setTitle:tabBarItem.title forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
    [self setImage:tabBarItem.image forState:UIControlStateNormal];
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
}


/** 生成按钮内部图片的位置（frame）contentRect 就是按钮自身的Frame */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = CGRectGetWidth(contentRect);
    CGFloat imgH = CGRectGetHeight(contentRect) * _ratio;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

/** 生成按钮内部titleLabel的位置（frame）*/
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetHeight(contentRect) * _ratio;
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleH = CGRectGetHeight(contentRect) * (1- _ratio);
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/** 拦截高亮状态响应，让它什么也不干*/
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
