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
#import "WBFrameModel.h"
#import "WBCell.h"



@interface HomeTableViewController ()

/** 遮罩图片*/
@property (nonatomic,strong) UIImageView *maskImgView;

/** 下拉框*/
@property (nonatomic,strong) DropControl *dropControl;

/** 微博数据源*/
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HomeTableViewController

- (UIImageView *)maskImgView
{
    if (_maskImgView == nil) {
        _maskImgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        NSMutableArray *imgs = @[].mutableCopy;
        for (int i = 0; i< 17; i++) {
            NSString *imgName = [NSString stringWithFormat:@"loading%02d",i+1];
            UIImage *img = [UIImage imageNamed:imgName];
            [imgs addObject:img];
            
        }
        _maskImgView.backgroundColor = [UIColor whiteColor];
        _maskImgView.contentMode = UIViewContentModeTop;
        _maskImgView.animationImages = imgs;
        _maskImgView.animationDuration = 2;
        [self.view addSubview:_maskImgView];
        
        [self.view bringSubviewToFront:_maskImgView];

    }
    
    return _maskImgView;
}

- (NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
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
        parmas[@"count"]=@10;
    }
    
//    MBProgressHUDManager *mgr = [[MBProgressHUDManager alloc] initWithView:self.view];
    
    [self.maskImgView startAnimating];
    
    
//    [mgr showIndeterminateWithMessage:@"asdfadsf"];
    
//    [mgr showNoticeMessage:@"aready exsits" duration:3.f complection:^{
//        
//    }];
//    
//    [mgr showDetailMessage:@"hello world" duration:3.f complection:^{
//        
//    }];
    
    
    
    /*

//    [SVProgressHUD showImage:[UIImage imageNamed:@"tabbar_compose_review"] status:@"loading..."];
    
    KVNProgressConfiguration *c = [KVNProgressConfiguration defaultConfiguration];
    c.circleStrokeForegroundColor = [UIColor redColor];
//    c.circleFillBackgroundColor = [UIColor magentaColor];
    c.circleStrokeBackgroundColor = [UIColor greenColor];
    
    c.backgroundTintColor = [UIColor lightGrayColor];
    
    c.backgroundType = KVNProgressBackgroundTypeSolid;
    
    [KVNProgress setConfiguration:c];
    [KVNProgress showWithStatus:@"loading..."];
   
    */
    
//    [KVNProgress showWithStatus:@"正在加载数据..."];
    
    [AFHTTPSessionManager requestWithType:AFHTTPSessionManagerRequestTypeGET URLString:WB_API_HOME_TIMELINE parmaeters:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
//        [KVNProgress dismiss];
//        [SVProgressHUD dismiss];
//        [self.maskImgView stopAnimating];
//        [self.maskImgView removeFromSuperview];
//        self.maskImgView = nil;
        NSArray *statusArr = responseObject[@"statuses"];
        NSArray *sModelArr = [StatusModel mj_objectArrayWithKeyValuesArray:statusArr];
        
        // 循环数据modle数组，每次循环创建一个FrameModel,将数据model传给FrameModel，让FrameModel计算出自己的每个属性
        for (StatusModel *sModel in sModelArr) {
            WBFrameModel *fModle = [[WBFrameModel alloc] init];
            fModle.statusModel = sModel;
            
            // 将计算完成的fModel都添加在数据源数组中
            [self.dataArray addObject:fModle];
            
        }
        
        
        // 刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
 
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [KVNProgress showErrorWithStatus:[error localizedDescription]];
        [SVProgressHUD showErrorWithStatus:@"错误"];
        NSLog(@"error = %@",[error localizedDescription]);
    }];
}

#pragma mark - UITableVeiwdelegate / DataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出frameModle
    WBFrameModel *fModel = self.dataArray[indexPath.row];
    
    return fModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"WBCellID";

    WBCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell =[[WBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    WBFrameModel *model = self.dataArray[indexPath.row];
    
    cell.frameModel = model;

    return cell;
}



@end
