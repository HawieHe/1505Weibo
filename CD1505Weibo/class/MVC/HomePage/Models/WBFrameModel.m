//
//  WBFrameModel.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/5.
//  Copyright © 2016年 Hawie. All rights reserved.
//

#import "WBFrameModel.h"
#import "PicBackgroundView.h"

CGFloat const vWH = 15;

@implementation WBFrameModel

- (void)setStatusModel:(StatusModel *)statusModel
{
    _statusModel = statusModel;
    UserModel *userModel = statusModel.user;
    
    /** 第一块*/
    /** 一、顶部背景图层*/
    CGFloat topBGX = 0;
    CGFloat topBGY = 0;
    CGFloat topBGW = SCREEN_WIDTH;
    CGFloat topBGH = 0; // 暂时设为0;
    
    
    
    /** 1.用户图像*/
    CGFloat userIconX = WB_SPACING_NORMAL;
    CGFloat userIconY = WB_SPACING_NORMAL;
    CGFloat userIconWH = 50;
    self.userIconImageViewFrame = CGRectMake(userIconX, userIconY, userIconWH, userIconWH);
   
    
    /** 2.用户是否是验证用户图标*/
    
    CGFloat userVerifyWH = vWH;
    CGFloat userVerifyXY =  userIconWH - userVerifyWH;
    CGFloat userVerifyX = userVerifyXY + userIconX;
    CGFloat userVerifyY = userVerifyXY + userIconY;

    if(userModel.verified) {
        
    }else {
        userVerifyWH = 0;
    }
    self.userVerifyImageViewFrame = CGRectMake(userVerifyX, userVerifyY, userVerifyWH, userVerifyWH);
    

    
    /** 3.用户名*/
    CGFloat userNameX = CGRectGetMaxX(self.userIconImageViewFrame) + WB_SPACING_NORMAL;
    CGFloat userNameY = userIconY;
    
    CGSize userNameSize = [userModel.name sizeWithAttributes:@{NSFontAttributeName:WB_FONT_USERNAME}];
    
    self.userNameLabelFrame = (CGRect) {{userNameX,userIconY},userNameSize};
    
    
    /** 4.用户vip等级图标*/
    CGFloat userVipX = CGRectGetMaxX(self.userNameLabelFrame) + WB_SPACING_SMALL;
    CGFloat userVipY = userNameY;
    CGFloat userVipWH = vWH;
    if (userModel.mbrank > 0) {
        
    }else {
        userVipWH = 0;
    }
    self.userVipLevelImageViewFrame = CGRectMake(userVipX, userVipY, userVipWH, userVipWH);
    
    
    /** 5.微博发布时间*/
    CGFloat wbCTimeX = userNameX;
    CGFloat wbCTimeY = CGRectGetMaxY(self.userNameLabelFrame) + WB_SPACING_SMALL;
    CGSize wbCTimeSize = [statusModel.ct sizeWithAttributes:@{NSFontAttributeName:WB_FONT_TIME}];
    self.wbCreateTimeLabelFrame = (CGRect){{wbCTimeX,wbCTimeY},wbCTimeSize};

    
    /** 6.微博来源*/
    CGFloat wbSourceX = CGRectGetMaxX(self.wbCreateTimeLabelFrame) + WB_SPACING_SMALL;
    CGFloat wbSourceY = wbCTimeY;
    CGSize wbSourceSize = [statusModel.source sizeWithAttributes:@{NSFontAttributeName:WB_FONT_TIME}];
    self.wbSourceLabelFrame = (CGRect){{wbSourceX,wbSourceY},wbSourceSize};
    
    CGFloat topMaxH = MAX(CGRectGetMaxY(self.userIconImageViewFrame), CGRectGetMaxY(self.wbCreateTimeLabelFrame));
    topBGH = topMaxH + WB_SPACING_NORMAL;
    
    self.topBackgroundViewFrame = CGRectMake(topBGX, topBGY, topBGW, topBGH);
    
    
    /** 第二块*/
    /** 二、用户自己发布的微博内容背景图层*/
    CGFloat secondBGX = topBGX;
    CGFloat secondBGY = CGRectGetMaxY(self.topBackgroundViewFrame);
    CGFloat secondBGW = topBGW;
    CGFloat secondBGH = 0;
    
    /** 1.微博文字内容*/
    CGFloat wbContentX = userIconX;
    CGFloat wbContentY = 0;

    CGSize wbContentSize = [statusModel.text boundingRectWithSize:CGSizeMake(secondBGW - 2*wbContentX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WB_FONT_USERNAME} context:nil].size;
    
    self.wbContentLableFrame = (CGRect){{wbContentX,wbContentY},wbContentSize};
    
    /** 2.微博图片内容的背景图层*/
    CGFloat wbPicBgX = 0;
    CGFloat wbPicBgY = CGRectGetMaxY(self.wbContentLableFrame);
    if (statusModel.pic_urls.count != 0) {
        wbPicBgY = CGRectGetMaxY(self.wbContentLableFrame) + WB_SPACING_NORMAL;
    }
    
    CGFloat wbPicBgW = secondBGW;
    CGFloat wbPicBgH = [PicBackgroundView heightWithNum:statusModel.pic_urls.count];
    
    self.wbPicsBackgroundViewFrame = CGRectMake(wbPicBgX, wbPicBgY, wbPicBgW, wbPicBgH);
    
    
    secondBGH = CGRectGetMaxY(self.wbPicsBackgroundViewFrame);
    
    self.secondBackgroundViewFrame = CGRectMake(secondBGX, secondBGY, secondBGW, secondBGH);
    

    /** 第三块*/
    /** 三、用户转发微博内容的背景图层*/
    CGFloat rwBGX = secondBGX;
    CGFloat rwBGY = CGRectGetMaxY(self.secondBackgroundViewFrame) + WB_SPACING_SMALL;
    CGFloat rwBGW = secondBGW;
    CGFloat rwBGH = 0;
    
    
    /** 1.转发微博的文字内容*/
    CGFloat rwContentX = wbContentX;
    CGFloat rwContentY = 0;
    if (statusModel.retweeted_status) {
        rwContentY = WB_SPACING_SMALL;
    }
    CGSize rwContentSize = [statusModel.retweeted_status.text boundingRectWithSize:CGSizeMake(rwBGW - 2 * rwContentX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WB_FONT_USERNAME} context:nil].size;
    self.rwWBContentLableFrame = CGRectMake(rwContentX, rwContentY, rwContentSize.width, rwContentSize.height);
    
    /** 2.转发微博的图片的背景图层*/
    CGFloat rwPicBGX = wbPicBgX;
    CGFloat rwPicBGY = CGRectGetMaxY(self.rwWBContentLableFrame);
    if (statusModel.retweeted_status.pic_urls.count != 0) {
        rwPicBGY = CGRectGetMaxY(self.rwWBContentLableFrame) + WB_SPACING_SMALL;
    }
    CGFloat rwPicBGW = rwBGW;
    
    CGFloat rwPicBGH = [PicBackgroundView heightWithNum:statusModel.retweeted_status.pic_urls.count];
    
    self.rwWBPicsBackgroundViewFrame = CGRectMake(rwPicBGX, rwPicBGY, rwPicBGW, rwPicBGH);
    
    rwBGH = CGRectGetMaxY(self.rwWBPicsBackgroundViewFrame) ;
    self.rwBackgroundViewFrame = CGRectMake(rwBGX, rwBGY, rwBGW, rwBGH);
    
    /** 第四块*/
    /** 四、底部操作栏图层*/
    CGFloat bottomX = 0;
    CGFloat bottomY = CGRectGetMaxY(self.rwBackgroundViewFrame) + WB_SPACING_SMALL;
    CGFloat bottomW = topBGW;
    CGFloat bottomH = 40;
    self.bottomBackgroundViewFrame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    
    CGFloat buttonW = CGRectGetWidth(self.bottomBackgroundViewFrame)/3.0;
    /** 1.转发按钮*/
    self.repostButtonFrame = CGRectMake(0, 0, buttonW, bottomH);

    
    /** 2.评论按钮*/
    self.commentButtonFrame = CGRectMake(buttonW, 0, buttonW, bottomH);
    
    /** 3.点赞按钮*/
    self.attitudeButtonFrame = CGRectMake(buttonW * 2, 0, buttonW, bottomH);
    
    // 计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.bottomBackgroundViewFrame) + WB_SPACING_SMALL;;
    
}

@end
