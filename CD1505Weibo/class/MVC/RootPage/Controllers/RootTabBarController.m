//
//  RootTabBarController.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//  这是我的git

#import "RootTabBarController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoveryTableViewController.h"
#import "PersonalTableViewController.h"
#import "WBTabBar.h"
#import <PopMenu.h>


@interface RootTabBarController () <WBTabBarDelegate>

/** 自定义TabBar*/
@property (nonatomic, strong) WBTabBar *wbTabBar;

// @a assing @t strong  @y copy @w weak

/** 弹出界面*/
@property (nonatomic, strong) PopMenu *popMenu;

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    

    // 添加自定义TabBar
    [self addCustomTabBar];
    
    // 添加viewControllers
    
    
    [self addViewControlers];

}

- (PopMenu *)popMenu
{
    if (_popMenu == nil) {
        
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titleArr = @[@"文字",@"相册",@"微博",@"签到",@"点评",@"更多"];
        NSArray *imgNameArr = @[@"tabbar_compose_idea",
                                @"tabbar_compose_photo",
                                @"tabbar_compose_weibo",
                                @"tabbar_compose_lbs",
                                @"tabbar_compose_review",
                                @"tabbar_compose_more"];
        for (int i = 0; i < titleArr.count; i++) {
            MenuItem *item = [[MenuItem alloc] initWithTitle:titleArr[i] iconName:imgNameArr[i] glowColor:[UIColor magentaColor]];
            [items addObject:item];
        }
        
        _popMenu = [[PopMenu alloc] initWithFrame:[UIScreen mainScreen].bounds items:items];
        
        _popMenu.didSelectedItemCompletion = ^ (MenuItem * item) {
            
            NSLog(@"点击了%@",item.title);
        };
    }
    return _popMenu;
}




- (void)addCustomTabBar
{
    // 隐藏系统自带的TabBar
//    self.tabBar.hidden = YES;
    self.wbTabBar = [[WBTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
//    self.wbTabBar.delegate = self;
    __weak typeof(self) weakSelf = self;
    self.wbTabBar.passIndex = ^(NSInteger index) {
        weakSelf.selectedIndex = index;
    };
    self.wbTabBar.plBlock = ^ {
       // 显示弹出界面
        [weakSelf.popMenu showMenuAtView:weakSelf.view];
    };
    
    
    [self.tabBar addSubview:self.wbTabBar];
    self.wbTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    
    
    
}

/** 添加视图控制器*/
- (void)addViewControlers
{

    
    NSArray *vcNameArray = @[@"HomeTableViewController",
                             @"MessageTableViewController",
                             @"DiscoveryTableViewController",
                             @"PersonalTableViewController"];
    NSArray *vcTitleArray = @[@"首页",@"消息",@"发现",@"我"];
    
    //普通状态图片
    NSArray *norImageArray = @[@"tabbar_home",
                             @"tabbar_message_center",
                             @"tabbar_discover",
                             @"tabbar_profile"];
    //高亮状态图片
//    NSArray *hlImageArray = @[@"tabbar_home_highlighted",
//                               @"tabbar_message_center_highlighted",
//                               @"tabbar_discover_highlighted",
//                               @"tabbar_profile_highlighted"];
    //选中状态图片
    NSArray *selImageArray = @[@"tabbar_home_selected",
                              @"tabbar_message_center_selected",
                              @"tabbar_discover_selected",
                              @"tabbar_profile_selected"];
    
    
    for (NSString *vcName in vcNameArray) {
        Class vcClass = NSClassFromString(vcName);
        NSInteger index = [vcNameArray indexOfObject:vcName];
        UITableViewController *vc = [[vcClass alloc] init];
        vc.title = vcTitleArray[index];
        
        
        
        [vc.tabBarItem setImage:[[UIImage imageNamed:norImageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selImageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        // 修改文字颜色
        NSDictionary *norAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        
        NSDictionary *selAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor orangeColor]};

        [vc.tabBarItem setTitleTextAttributes:norAttribute forState:UIControlStateNormal];
        
        [vc.tabBarItem setTitleTextAttributes:selAttribute forState:UIControlStateSelected];

        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:navc];
        
        self.wbTabBar.tabBarItem = vc.tabBarItem;
        
        
        // 当所有的系统自带tabbaritem都已经加载完了，再去删除
        if (index == vcTitleArray.count - 1) {
            for (UIView *view in self.tabBar.subviews) {
//                NSLog(@"view = %@",view);

                Class uitabBarButton = NSClassFromString(@"UITabBarButton");
                if ([view isKindOfClass:[uitabBarButton class]]) {
                    [view removeFromSuperview];
                }
  
            }

        }
    }
    
}


#pragma mark - WBTabBarDelegate 

- (void)passIndex:(NSInteger)index
{
    self.selectedIndex = index;
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
