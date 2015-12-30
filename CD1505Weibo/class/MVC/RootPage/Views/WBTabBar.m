//
//  WBTabBar.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarButton.h"

@interface WBTabBar ()

/** 按钮数组*/
@property (nonatomic,strong) NSMutableArray *buttonArray;

/** 当前选中按钮*/
@property (nonatomic, strong) WBTabBarButton *selecteBtn;

/** 中间加号按钮*/
@property (nonatomic, strong) UIButton *plusBtn;

@end



@implementation WBTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建一个按钮 设置一次性的属性
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:plusBtn];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        self.plusBtn = plusBtn;
        [plusBtn addTarget:self action:@selector(plusBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = @[].mutableCopy;
    }
    return _buttonArray;
}



- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    // 获取到 标题 title， 图片 image
    
//    NSLog(@"tabBarItem.title = %@",tabBarItem.title);
    
    // 每进来一次，创建一个button
    WBTabBarButton *button = [WBTabBarButton buttonWithType:UIButtonTypeCustom];
    button.tabBarItem = tabBarItem;
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    
    // 存储在全局按钮数组里面
    [self.buttonArray addObject:button];
    
    // 当第一次调用这个方法，就让第一个按钮处于选中状态
    if (self.buttonArray.count == 1) {
        
        [self buttonPressed:button];
 
    }
    
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 20, 10);
//    button.titleEdgeInsets = UIEdgeInsetsMake(35, -10, 5, 10);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 布局子视图
    // 循环按钮数组，做相应的布局
    
    CGFloat btnW = CGRectGetWidth(self.frame)/(CGFloat)(self.buttonArray.count + 1);
    CGFloat plusW = self.plusBtn.currentBackgroundImage.size.width;
    CGFloat plusH = self.plusBtn.currentBackgroundImage.size.height;
    
    self.plusBtn.frame = CGRectMake(0, 0, plusW, plusH);
    self.plusBtn.center = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5);
    
    
    for (int i = 0; i < self.buttonArray.count; i++) {

        WBTabBarButton *btn = self.buttonArray[i];
        CGFloat bX = btnW * i;
        if (i > 1) {
            bX += btnW;
        }
        CGFloat bY = 0;
        CGFloat bW = btnW;
        CGFloat bH = CGRectGetHeight(self.frame);
        
       
        btn.frame = CGRectMake(bX, bY, bW, bH);
    }
    
}

#pragma mark - 按钮点击 

- (void)buttonPressed:(WBTabBarButton *)btn
{
   // 1. 循环
//    for (WBTabBarButton *button in self.buttonArray) {
//        button.selected = NO;
//    }
//    btn.selected = YES;
    
    // 2. 记录
    _selecteBtn.selected = NO;
    btn.selected = YES;
    _selecteBtn = btn;
    
    NSInteger index = [self.buttonArray indexOfObject:btn];
    
    // 响应代理的方法
//    if ([_delegate respondsToSelector:@selector(passIndex:)]) {
//        [_delegate passIndex:index];
//    }
    if (_passIndex) {
        _passIndex(index);
    }
}

/** 加号按钮点击*/
- (void)plusBtnPressed
{
    if (_plBlock) {
        _plBlock();
    }
}




@end
