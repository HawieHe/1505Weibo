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
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/** 构建导航栏 */
- (void)createNaviBarItem
{
 
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormaImageName:@"navigationbar_friendattention" highlightedImageName:@"navigationbar_friendattention_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormaImageName:@"navigationbar_icon_radar" highlightedImageName:@"navigationbar_icon_radar_highlighted"];
    
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




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
