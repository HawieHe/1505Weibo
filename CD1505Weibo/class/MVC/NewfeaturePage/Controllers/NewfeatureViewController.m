//
//  NewfeatureViewController.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/31.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "NewfeatureViewController.h"
#import "RootTabBarController.h"

#define IMG_NUMBER 4

@interface NewfeatureViewController ()

@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNewFeatureImgs];
    // Do any additional setup after loading the view.
}

/** 隐藏状态栏*/
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)createNewFeatureImgs
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * IMG_NUMBER, 0);
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    
    for (int i = 0; i < IMG_NUMBER; i++) {
        NSString *imgName = [NSString stringWithFormat:@"newfeature%02d",i+1];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(w * i, 0, w, h)];
        imgView.image = [UIImage imageNamed:imgName];
        imgView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imgView];
        
        if (i == IMG_NUMBER - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_button"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_button_highlighted"] forState:UIControlStateNormal];
            [imgView addSubview:btn];
            CGSize size = btn.currentBackgroundImage.size;
            
            btn.frame = CGRectMake(0, 0, size.width, size.height);
//            btn.center = CGPointMake(CGRectGetWidth(imgView.frame) * 0.5, CGRectGetHeight(imgView.frame) * 0.5 + 100);
            btn.center = (CGPoint){CGRectGetWidth(imgView.frame) * 0.5, CGRectGetHeight(imgView.frame) * 0.5 + 100};
            [btn addTarget:self action:@selector(showRoot) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

/** 显示主页面*/
- (void)showRoot
{
    
    
    RootTabBarController *root = [[RootTabBarController alloc] init];
    
    // 截屏
    UIView *shotView = [self.view snapshotViewAfterScreenUpdates:YES];
    self.view.window.rootViewController = root;
    
    // 将截屏添加到root.view上
    [root.view addSubview:shotView];
    
  
    
    // 用动画将截屏图片透明度变为0 最后移除
    [UIView animateWithDuration:1.f animations:^{
        shotView.transform = CGAffineTransformScale(shotView.transform, 1.2, 1.2);
        shotView.alpha = 0;
       
    } completion:^(BOOL finished) {
        [shotView removeFromSuperview];
    }];
    
  
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
