//
//  DropControl.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/30.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "DropControl.h"

typedef NS_ENUM(NSInteger, HideType) {
    HideTypeFromSelf,       //点击自己消失
    HideTypeFromTableView, //点击tableview消失

};

static CGFloat cellHeight = 25;

static NSString *dropCellID = @"DropCellID";

@interface DropControl() <UITableViewDelegate,UITableViewDataSource>

/** DropControl的父视图*/
@property (nonatomic,weak) UIView *suView;

@property (nonatomic,strong) UIImageView *dropImgView;

@property (nonatomic,assign) CGRect imgFrame;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end


@implementation DropControl


- (id)initWithInsideViewFrame:(CGRect)frame inView:(UIView *)suView dataSource:(NSArray *)dataArray
{
    
    
    self = [super init];
    if (self) {
        // 设置自身的大小和位置
        self.frame = [UIScreen mainScreen].bounds;
        // 将父视图存储下来
        self.suView = suView;
        // 将传入的内部的imgFrame记录下来
        self.imgFrame = frame;
        
        // 存储传入的数据
        self.dataArray = [dataArray copy];
        
        // 给自己添加一个点击事件
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
        
        // 初始化子视图
        self.dropImgView = [[UIImageView alloc] init];
        [self addSubview:self.dropImgView];
        UIImage *img = [UIImage imageNamed:@"popover_background"];
        
        img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:10];
        
        self.dropImgView.image = img ;
        
        CGRect tableRect = frame;
        tableRect.origin.x = 5;
        tableRect.origin.y = 10;
        tableRect.size.width -= 10;
        tableRect.size.height -= 15;
        self.dropImgView.userInteractionEnabled = YES;
        self.tableView = [[UITableView alloc] initWithFrame: tableRect style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.dropImgView addSubview:self.tableView];
        
        // 估算有多少个元素的tableview高度
        CGFloat tbHeight = self.dataArray.count * cellHeight;
        
        // 如果估算的高度大于 限制的最大高度，
        if (tbHeight > self.imgFrame.size.height - 15) {
            tbHeight = self.imgFrame.size.height - 15;
        }
        CGRect tbRect = self.tableView.frame;
        tbRect.size.height = tbHeight;
        self.tableView.frame = tbRect;
        
        CGRect imgRect = self.imgFrame;
        imgRect.size.height = tbHeight + 20;
        self.imgFrame = imgRect;
    }
    
    return self;
    
}




- (void)show{
    [self.suView addSubview:self];
    
    // 用一个中间变量记录下img的frame,
    CGRect rect = self.imgFrame;
    // 将变量rect的高度变为0
    rect.size.height = 0;
    // x,y ,w ,h=0
    // 设置dorpImgView的frame,此时它的高度为0,所以显示的不全
    self.dropImgView.frame = rect;
    
    
    // 用动画，改变dropImgView的高度

    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.dropImgView.frame = self.imgFrame;

    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    

}


- (void)dismiss
{
    [self removeFromSuperview];
}


- (void)hide
{
    [self hideWithType:HideTypeFromSelf withIndexPath:-1];
}

- (void)hideWithType:(HideType)type withIndexPath:(NSInteger)index {
    CGRect rect = self.imgFrame;
    rect.size.height = 0;
    self.userInteractionEnabled = NO;

    [UIView animateWithDuration:0.5f animations:^{
        self.dropImgView.frame = rect;
        
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;

        [self dismiss];
        
        switch (type) {
            case HideTypeFromSelf:
            {
                if (_afhBlk) {
                    _afhBlk();
                }
            }
                break;
            case HideTypeFromTableView:
            {
                if (_dsBlk) {
                    _dsBlk(index);
                }
//                if (_afhBlk) {
//                    _afhBlk();
//                }
            }
                
            default:
                break;
        }
        
    }];
    
}


#pragma mark - UITableViewDelegate/DataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dropCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dropCellID];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor =[UIColor clearColor];

    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self hideWithType:HideTypeFromTableView withIndexPath:indexPath.row];
    
 }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
