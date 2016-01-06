//
//  WBCell.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/5.
//  Copyright © 2016年 Hawie. All rights reserved.
//

#import "WBCell.h"
#import <UIImageView+WebCache.h>
#import "PicBackgroundView.h"

@interface WBCell ()

/** 第一块*/
/** 一、顶部背景图层*/
@property (nonatomic,strong) UIView *topBackgroundView;
/** 1.用户图像*/
@property (nonatomic, strong) UIImageView *userIconImageView;

/** 2.用户是否是验证用户图标*/
@property (nonatomic, strong) UIImageView *userVerifyImageView;

/** 3.用户名*/
@property (nonatomic, strong) UILabel *userNameLabel;

/** 4.用户vip等级图标*/
@property (nonatomic, strong) UIImageView *userVipLevelImageView;

/** 5.微博发布时间*/
@property (nonatomic, strong) UILabel *wbCreateTimeLabel;

/** 6.微博来源*/
@property (nonatomic, strong) UILabel *wbSourceLabel;


/** 第二块*/
/** 二、用户自己发布的微博内容背景图层*/
@property (nonatomic, strong) UIView *secondBackgroundView;

/** 1.微博文字内容*/
@property (nonatomic, strong) UILabel *wbContentLable;

/** 2.微博图片内容的背景图层*/
@property (nonatomic, strong) PicBackgroundView *wbPicsBackgroundView;

/** 第三块*/
/** 三、用户转发微博内容的背景图层*/
@property (nonatomic, strong) UIView *rwBackgroundView;

/** 1.转发微博的文字内容*/
@property (nonatomic, strong) UILabel *rwWBContentLable;

/** 2.转发微博的图片的背景图层*/
@property (nonatomic, strong) PicBackgroundView *rwWBPicsBackgroundView;


/** 第四块*/
/** 四、底部操作栏图层*/
@property (nonatomic, strong)UIView *bottomBackgroundView;

/** 1.转发按钮*/
@property (nonatomic, strong) UIButton *repostButton;

/** 2.评论按钮*/
@property (nonatomic, strong) UIButton *commentButton;

/** 3.点赞按钮*/
@property (nonatomic, strong) UIButton *attitudeButton;


@end


@implementation WBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化所有的子控件，并设置一次性的属性
        [self generateSubViews];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/** 初始化所有的子控件*/
- (void)generateSubViews
{
    /** 一、顶部背景图层*/
    self.topBackgroundView = [[UIView alloc] init];
    [self.contentView addSubview:self.topBackgroundView];
    
    /** 1.用户图像*/
    self.userIconImageView = [[UIImageView alloc] init];
    [self.topBackgroundView addSubview:self.userIconImageView];
    self.userIconImageView.layer.masksToBounds = YES;
    
    /** 2.用户是否是验证用户图标*/
    self.userVerifyImageView = [[UIImageView alloc] init];
    [self.topBackgroundView addSubview:self.userVerifyImageView];
    
    /** 3.用户名*/
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.font = WB_FONT_USERNAME;
    [self.topBackgroundView addSubview:self.userNameLabel];
    
    /** 4.用户vip等级图标*/
    self.userVipLevelImageView = [[UIImageView alloc] init];
    [self.topBackgroundView addSubview:self.userVipLevelImageView];
    
    /** 5.微博发布时间*/
    self.wbCreateTimeLabel = [[UILabel alloc] init];
    self.wbCreateTimeLabel.font = WB_FONT_TIME;
    [self.topBackgroundView addSubview:self.wbCreateTimeLabel];
    
    /** 6.微博来源*/
    self.wbSourceLabel = [[UILabel alloc] init];
    self.wbSourceLabel.font = WB_FONT_TIME;
    [self.topBackgroundView addSubview:self.wbSourceLabel];
    
/*============ 我是快乐的分割======================*/
    

    /** 二、用户自己发布的微博内容背景图层*/
    self.secondBackgroundView = [[UIView alloc] init];
    [self.contentView addSubview:self.secondBackgroundView];
    
    
    /** 1.微博文字内容*/
    self.wbContentLable = [[UILabel alloc] init];
    self.wbContentLable.font = WB_FONT_USERNAME;
    self.wbContentLable.numberOfLines = 0;
    [self.secondBackgroundView addSubview:self.wbContentLable];

    
    /** 2.微博图片内容的背景图层*/
    self.wbPicsBackgroundView =[[PicBackgroundView alloc] init];
    [self.secondBackgroundView addSubview:self.wbPicsBackgroundView];

    
/*============ 我是快乐的分割======================*/
    
    /** 第三块*/
    /** 三、用户转发微博内容的背景图层*/
    self.rwBackgroundView = [[UIView alloc] init];
    [self.contentView addSubview:self.rwBackgroundView];
    self.rwBackgroundView.backgroundColor = [UIColor lightGrayColor];

    /** 1.转发微博的文字内容*/
    self.rwWBContentLable = [[UILabel alloc] init];
    self.rwWBContentLable.font = WB_FONT_USERNAME;
    self.rwWBContentLable.numberOfLines = 0;
    [self.rwBackgroundView addSubview:self.rwWBContentLable];

    
    /** 2.转发微博的图片的背景图层*/
    self.rwWBPicsBackgroundView =[[PicBackgroundView alloc] init];
    [self.rwBackgroundView addSubview:self.rwWBPicsBackgroundView];
    
/*============ 我是快乐的分割======================*/
    
    /** 四、底部操作栏图层*/
    self.bottomBackgroundView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomBackgroundView];
    
    /** 1.转发按钮*/
    self.repostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomBackgroundView addSubview:self.repostButton];
    
    /** 2.评论按钮*/
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomBackgroundView addSubview:self.repostButton];
    
    /** 3.点赞按钮*/
    self.attitudeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomBackgroundView addSubview:self.repostButton];

}




- (void)setFrameModel:(WBFrameModel *)frameModel
{
    StatusModel *statusModel = frameModel.statusModel;
    /** 第一块*/
    self.topBackgroundView.frame = frameModel.topBackgroundViewFrame;
    /** 1.用户图像*/
    NSURL *userIconUrl = [NSURL URLWithString:statusModel.user.profile_image_url] ;
    
    [self.userIconImageView sd_setImageWithURL:userIconUrl placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    self.userIconImageView.frame = frameModel.userIconImageViewFrame;
  
    
    /** 2.用户是否是验证用户图标*/
    BOOL isVerified = statusModel.user.verified;
    NSString *userVerifiedImgName = nil;
    if (isVerified) {
        if (statusModel.user.verified_type > 1) {
            userVerifiedImgName = @"avatar_enterprise_vip";
        }else {
            userVerifiedImgName = @"avatar_vip";
        }
    }else {
        
    }
    self.userVerifyImageView.image = [UIImage imageNamed:userVerifiedImgName];
    self.userVerifyImageView.frame = frameModel.userVerifyImageViewFrame;

    /** 3.用户名*/
    self.userNameLabel.text = statusModel.user.name;
    self.userNameLabel.frame = frameModel.userNameLabelFrame;
    
    
    /** 4.用户vip等级图标*/
    NSInteger vipLevel = statusModel.user.mbrank;
    NSString *vipImgName = [NSString stringWithFormat:@"common_icon_membership_level%ld",vipLevel];
    self.userVipLevelImageView.image = [UIImage imageNamed:vipImgName];
    self.userVipLevelImageView.frame = frameModel.userVipLevelImageViewFrame;
    
    
    /** 5.微博发布时间*/
    self.wbCreateTimeLabel.text = statusModel.ct;
    
    CGRect ctFrame = frameModel.wbCreateTimeLabelFrame;
    
    CGSize ctSize = [statusModel.ct sizeWithAttributes:@{NSFontAttributeName:WB_FONT_TIME}];
    ctFrame.size.width = ctSize.width;
    
    self.wbCreateTimeLabel.frame = ctFrame;
    
    
    /** 6.微博来源*/
    self.wbSourceLabel.text = statusModel.source;
    
    CGRect sRect = frameModel.wbSourceLabelFrame;
    
    sRect.origin.x = CGRectGetMaxX(self.wbCreateTimeLabel.frame) + WB_SPACING_SMALL;
    
    self.wbSourceLabel.frame = sRect;
    
    
    /** 第二块*/
    /** 二、用户自己发布的微博内容背景图层*/
    self.secondBackgroundView.frame = frameModel.secondBackgroundViewFrame;
    
    /** 1.微博文字内容*/
    self.wbContentLable.text = statusModel.text;
    self.wbContentLable.frame = frameModel.wbContentLableFrame;
    self.wbContentLable.backgroundColor = [UIColor orangeColor];
    

    /** 2.微博图片内容的背景图层*/
    [self.wbPicsBackgroundView showPicsWithArray:statusModel.pic_urls];
    self.wbPicsBackgroundView.frame = frameModel.wbPicsBackgroundViewFrame;
    
    
    /** 第三块*/
    /** 三、用户转发微博内容的背景图层*/
    self.rwBackgroundView.frame = frameModel.rwBackgroundViewFrame;
    /** 1.转发微博的文字内容*/
    self.rwWBContentLable.text = statusModel.retweeted_status.text;
    self.rwWBContentLable.frame = frameModel.rwWBContentLableFrame;
    
    /** 2.转发微博的图片的背景图层*/
    [self.rwWBPicsBackgroundView showPicsWithArray:statusModel.retweeted_status.pic_urls];
    self.rwWBPicsBackgroundView.frame = frameModel.rwWBPicsBackgroundViewFrame;

    
    
    /** 第四块*/
    /** 四、底部操作栏图层*/
   
    self.bottomBackgroundView.frame = frameModel.bottomBackgroundViewFrame;
    self.bottomBackgroundView.backgroundColor = [UIColor greenColor];
    
    /** 1.转发按钮*/
    self.repostButton.frame = frameModel.repostButtonFrame;
    
    
    /** 2.评论按钮*/
    self.commentButton.frame = frameModel.commentButtonFrame;
    
    /** 3.点赞按钮*/
    self.attitudeButton.frame = frameModel.attitudeButtonFrame;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.userIconImageView.layer.cornerRadius = CGRectGetWidth(self.userIconImageView.frame) * 0.5;
}




@end
