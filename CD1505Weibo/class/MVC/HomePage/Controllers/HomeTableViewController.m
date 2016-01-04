//
//  HomeTableViewController.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIBarButtonItem+Util.h"
#import "TitleButton.h"
#import "DropControl.h"
#import "HomePage_API.h"
#import "AFHTTPSessionManager+Util.h"
#import "OAuthTool.h"
#import "OAuthViewController.h"
#import "StatusModel.h"

@interface HomeTableViewController ()

/** 下拉框*/
@property (nonatomic,strong) DropControl *dropControl;

@end

@implementation HomeTableViewController

- (DropControl *)dropControl
{
    if (_dropControl == nil) {
        
        NSArray *dataArr = @[@"床前明月光",
                             @"地上鞋两双",
                             @"举头望明月",
                             @"低头思故乡"];
        
        _dropControl = [[DropControl alloc] initWithInsideViewFrame:CGRectMake(100, 60, 180, 300) inView:self.tabBarController.view dataSource:dataArr];
        _dropControl.backgroundColor = [UIColor clearColor];
        
        __weak typeof(self) weakSelf = self;
        _dropControl.afhBlk = ^ {
          
            // 隐藏之后的回调代码
            TitleButton *btn = (TitleButton *)weakSelf.navigationItem.titleView;
            if (btn.selected) {
                btn.selected = NO;
            }
        };
        
        _dropControl.dsBlk = ^ (NSInteger index) {
            // 隐藏之后的回调代码
            TitleButton *btn = (TitleButton *)weakSelf.navigationItem.titleView;
            if (btn.selected) {
                btn.selected = NO;
            }

            NSLog(@"index = %ld",index);
        };
    }
    return _dropControl;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNaviBarItem];
    
    // 请求数据
    [self generateData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/** 构建导航栏 */
- (void)createNaviBarItem
{
 
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormaImageName:@"navigationbar_friendattention" highlightedImageName:@"navigationbar_friendattention_highlighted" target:self selector:@selector(leftBarButtonItemPressed)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormaImageName:@"navigationbar_icon_radar" highlightedImageName:@"navigationbar_icon_radar_highlighted" target:self selector:@selector(rightBarButtonItemPressed)];
    
    TitleButton *btn = [TitleButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"大王叫我来巡山" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(0, 0, 200, 30);
    btn.backgroundColor =[UIColor clearColor];
    
    self.navigationItem.titleView = btn;
    
    [btn addTarget:self action:@selector(titleBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - title按钮点击
- (void)titleBtnPressed:(TitleButton *)btn
{
    btn.selected = !btn.selected;
  
    
    if (btn.selected) {
        [self.dropControl show];
    
    }else {
        [self.dropControl dismiss];
    }
    
    
}

#pragma mark - 导航栏按钮点击
/** 导航栏左边按钮点击*/
- (void)leftBarButtonItemPressed
{
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%u",arc4random()%200];
}

/** 导航栏右边按钮点击*/
- (void)rightBarButtonItemPressed
{
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}



#pragma mark - 请求数据

- (void)generateData
{
    NSMutableDictionary *parmas = @{}.mutableCopy;
    // 获取存储下来的用户信息（授权token）
    OAuthModel *oaModel = [OAuthTool fetchOAuthModel];
    if (oaModel == nil) {
        // 需要重新登录
        self.view.window.rootViewController = [[OAuthViewController alloc] init];
    }else {
        parmas[@"access_token"] = oaModel.access_token;
        parmas[@"count"]=@1;
    }
    
    
    [AFHTTPSessionManager requestWithType:AFHTTPSessionManagerRequestTypeGET URLString:WB_API_HOME_TIMELINE parmaeters:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *statusArr = responseObject[@"statuses"];
        
        NSArray *arr = [StatusModel mj_objectArrayWithKeyValuesArray:statusArr];
       
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",[error localizedDescription]);
    }];
}

@end
