//
//  NewfeatureTool.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "NewfeatureTool.h"
#import "NewfeatureViewController.h"
#import "RootTabBarController.h"
#import "AppDelegate.h"

@implementation NewfeatureTool

+ (void)choseRootViewController
{
    // 获取当前的版本号
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDict[@"CFBundleShortVersionString"];
    
    // 获取存储下来的版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefaults objectForKey:@"LastVersion"];
    
    AppDelegate *appDelegate =  [UIApplication sharedApplication].delegate;
    
    UIViewController *vc;
    // 用当前版本号和存储下来的版本号对比
    if ([currentVersion compare:lastVersion]==NSOrderedDescending) {
        // 有新版本,将存储下来的版本号替换成最新版本
        [userDefaults setObject:currentVersion forKey:@"LastVersion"];
        [userDefaults synchronize];
        
        // 加载引导页
        NewfeatureViewController *nfVc = [[NewfeatureViewController alloc] init];
        vc = nfVc;
        
    }else {
        // 加载主页
        RootTabBarController *rootVc = [[RootTabBarController alloc] init];
        vc = rootVc;
    }
    
    appDelegate.window.rootViewController = vc;

}

@end
