//
//  WBBadgeButton.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/31.
//  Copyright © 2015年 Hawie. All rights reserved.
//
#import "UIImage+Util.h"

#import "WBBadgeButton.h"

@implementation WBBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置图片
        [self setBackgroundImage:[UIImage autoResizeWithImageName:@"main_badge"] forState:UIControlStateNormal];
        
        self.userInteractionEnabled = NO;
        
        // 设置字体相关
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
    }
    return self;
}


- (void)setBadgeValue:(NSString *)badgeValue
{
    
    
    if (badgeValue.integerValue == 0) {
        self.hidden = YES;
    }else {
        self.hidden = NO;
    }
    if (badgeValue.integerValue >99) {
        badgeValue = @"99+";
    }
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    CGRect rect = self.frame;
    CGSize imgSize = self.currentBackgroundImage.size;
    // 计算文字占用的大小
    CGSize wSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    CGFloat width = wSize.width;
    if (width > imgSize.width) {
        width += 10;
    }else {
        width = imgSize.width;
    }
    
    rect.size.width = width;
    
    rect.origin.x = self.superview.frame.size.width - width;
    
    self.frame = rect;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
