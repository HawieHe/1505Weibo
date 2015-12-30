//
//  DropControl.h
//  CD1505Weibo
//
//  Created by HeHui on 15/12/30.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AfterHideBlk)();

typedef void(^DidSelecteIndexBlk)(NSInteger index);

@interface DropControl : UIControl

/** 自身隐藏之后的回调*/
@property (nonatomic,copy) AfterHideBlk afhBlk;

/** 选中选项的回调*/
@property (nonatomic,copy) DidSelecteIndexBlk dsBlk;

/**
 * @parmas frame 里面下拉视图的frame
 * @parmas suView 当前control需要记载的父视图
 * @parmas dataArray 内部需要显示的数据数组
 */
- (id)initWithInsideViewFrame:(CGRect)frame inView:(UIView *)suView dataSource:(NSArray *)dataArray;

/** 显示*/
- (void)show;


/** 显示*/
- (void)dismiss;



@end
