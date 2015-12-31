//
//  UIBarButtonItem+Util.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/30.
//  Copyright © 2015年 Hawie. All rights reserved.
//

#import "UIBarButtonItem+Util.h"

@implementation UIBarButtonItem (Util)

+ (UIBarButtonItem *)generateBarButtonItemWithNormaImageName:(NSString *)norImgName highlightedImageName:(NSString *)hlImgName target:(id)target selector:(SEL)sel
{
    // 1.创建一个按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:norImgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hlImgName] forState:UIControlStateHighlighted];
    CGSize size = btn.currentImage.size;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    // 2. 创建barButtonItem 返回
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
    
}



@end
