//
//  UIBarButtonItem+Util.h
//  CD1505Weibo
//
//  Created by HeHui on 15/12/30.
//  Copyright © 2015年 Hawie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Util)

/** 通过传入图片名称来创建barButtonItme*/
+ (UIBarButtonItem *)generateBarButtonItemWithNormaImageName:(NSString *)norImgName highlightedImageName:(NSString *)hlImgName;





@end
