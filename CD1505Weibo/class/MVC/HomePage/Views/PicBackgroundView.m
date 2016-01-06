//
//  PicBackgroundView.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "PicBackgroundView.h"
#import "PicUrlsModel.h"
#import <UIImageView+WebCache.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface PicBackgroundView ()

@property (nonatomic, strong) MJPhotoBrowser *pbrowser;

@property (nonatomic, strong) NSMutableArray *picsArray;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation PicBackgroundView



+ (CGFloat)heightWithNum:(NSInteger)num
{
    CGFloat height = 0;
    
    if (num == 1) {
        CGFloat picW = (SCREEN_WIDTH - 2 * WB_SPACING_NORMAL) * 0.5;
        height = picW + WB_SPACING_NORMAL;
    }else if (num > 1) {
        CGFloat picW = (SCREEN_WIDTH - 4 *WB_SPACING_NORMAL)/3.0;
        CGFloat spaceNum =0;
        if (num%3 == 0) {
            spaceNum = num/3;
        }else {
            spaceNum = (num/3 + 1);
        }
        height = (picW + WB_SPACING_NORMAL) * spaceNum;
    }
    return height ;
}

- (void)showPicsWithArray:(NSArray *)arr
{
    
    self.dataArray = [arr copy];
    for (UIView *v  in self.subviews) {
        [v removeFromSuperview];
    }
    self.pbrowser = nil;
    if (self.picsArray.count > 0) {
        [self.picsArray removeAllObjects];
    }
    
    self.picsArray = nil;
    
    self.picsArray = @[].mutableCopy;
    
    if (arr.count) {
        
        if (arr.count == 1) {
            PicUrlsModel *model = arr[0];
            CGFloat picW = (SCREEN_WIDTH - 2 * WB_SPACING_NORMAL) * 0.5;
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(WB_SPACING_NORMAL, 0, picW, picW)];
            [self addSubview:img];
            [img sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic]];
        }else{
            CGFloat picW = (SCREEN_WIDTH - 4 *WB_SPACING_NORMAL)/3.0;
            
            if (arr.count == 4) {
                
                
                
            }else {
                
                for (int i =0; i<arr.count; i++) {
                    PicUrlsModel *model = arr[i];
                    UIImageView *imgView = [[UIImageView alloc] init];
                    [self addSubview:imgView];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic]];
                    CGFloat imgX = (picW + WB_SPACING_NORMAL) * (i%3)+ WB_SPACING_NORMAL;
                    CGFloat imgY = (picW + WB_SPACING_NORMAL) * (i/3);
                    imgView.frame = CGRectMake(imgX, imgY, picW, picW);
                    imgView.userInteractionEnabled = YES;
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLarge:)];
                
                    [imgView addGestureRecognizer:tap];
                    
                    [self.picsArray addObject:imgView];
            
                 
                }
            }
        }
        
    }
}


- (void)showLarge:(UITapGestureRecognizer *)tap;
{
    
    NSMutableArray *pbArr = @[].mutableCopy;
    for (int i = 0; i<self.picsArray.count; i++) {
        PicUrlsModel *model = self.dataArray[i];
        
        UIImageView *imgView = self.picsArray[i];
        
        // 创建一个大图的对象
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置大图的链接地址
        photo.url = [NSURL URLWithString:model.large_pic];
        // 指定一个来源的imageView
        photo.srcImageView = imgView;
        
        [pbArr addObject:photo];
    }
   
    
    // 创建一个图片浏览器
    MJPhotoBrowser *pbrowser = [[MJPhotoBrowser alloc] init];
    pbrowser.photos = pbArr;
    
    UIImageView *imgView = (UIImageView *)tap.view;
    NSInteger index = [self.picsArray indexOfObject:imgView];
    pbrowser.currentPhotoIndex = index;
    [pbrowser show];
}



// 1     2    3    4     5     6   7    8     9
// w*0+space * 0  w*1  w*2   w*0   w*1  w*2 w*0   w*1  w*2
// w*0  w*0  w*0   w*1   w*1  w*1  w*2  w *2  w*2

@end
