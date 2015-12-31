//
//  UIImage+Util.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/31.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

+ (UIImage *)autoResizeWithImageName:(NSString *)imgName
{
    // 1.创建一个图片
    UIImage *img = [UIImage imageNamed:imgName];
    // 2.让图片可以自动拉伸
    
    CGSize imgSize = img.size;
    
    img = [img stretchableImageWithLeftCapWidth:imgSize.width * 0.5 topCapHeight:imgSize.height * 0.5];
    
    return img;
}

@end
