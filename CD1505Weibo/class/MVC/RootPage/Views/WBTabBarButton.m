//
//  WBTabBarButton.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "WBTabBarButton.h"
#import "WBBadgeButton.h"

@interface WBTabBarButton ()

/** 角标*/
@property (nonatomic, strong)WBBadgeButton *badgeButton;



@end

@implementation WBTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ratio = 0.6;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.badgeButton = [WBBadgeButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.badgeButton];
        
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
    _tabBarItem = tabBarItem;
    
    // 将自己添加成观察者，监听_tabBarItem的角标值(badgeValue)的改变
    [_tabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
    [self setTitle:tabBarItem.title forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
    [self setImage:tabBarItem.image forState:UIControlStateNormal];
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
}

- (void)dealloc
{
    [_tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
}

/** 监听的回调方法 一旦监听的对象的值发生改变就会调用这个方法*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.badgeButton.badgeValue = _tabBarItem.badgeValue;
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


/** 布局子视图*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 以图片的大小来确定按钮的大小
    CGSize size = self.badgeButton.currentBackgroundImage.size;
    self.badgeButton.frame = CGRectMake(CGRectGetWidth(self.frame) - size.width, 0, size.width, size.height);
    self.badgeButton.badgeValue = _tabBarItem.badgeValue ;
    
}


@end
