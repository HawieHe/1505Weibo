//
//  DiscoveryTableViewController.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "DiscoveryTableViewController.h"

@interface DiscoveryTableViewController ()

@end

@implementation DiscoveryTableViewController

// 1.

- (void)loadView
{
    
    [super loadView];
    NSLog(@"1");
}

// 2.

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"2");

}

// 3.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"3");

}

// 4.
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"4");

}

// 5.
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"5");

}

// 6
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



@end
