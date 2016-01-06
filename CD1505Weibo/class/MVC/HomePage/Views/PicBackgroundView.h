//
//  PicBackgroundView.h
//  CD1505Weibo
//
//  Created by HeHui on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicBackgroundView : UIView


// 传入一个数字，让它自己计算出自己需要的高度
+ (CGFloat)heightWithNum:(NSInteger)num;


// 传入一个picurlsModel的数组，根据这个数组自己去排列内部的图片
- (void)showPicsWithArray:(NSArray *)arr;


@end
