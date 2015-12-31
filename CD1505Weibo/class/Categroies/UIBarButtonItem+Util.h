//
//  UIBarButtonItem+Util.h
//  CD1505Weibo
//
//  Created by HeHui on 15/12/30.
//  Copyright © 2015年 Hawie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Util)

/** 通过传入图片名称来创建barButtonItme 并添加响应者和方法*/
+ (UIBarButtonItem *)generateBarButtonItemWithNormaImageName:(NSString *)norImgName highlightedImageName:(NSString *)hlImgName target:(id)target selector:(SEL)sel;





@end
