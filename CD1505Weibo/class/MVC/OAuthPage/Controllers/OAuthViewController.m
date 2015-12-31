//
//  OAuthViewController.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/31.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "OAuthViewController.h"
#import "WB-OAuthInfo.h"
#import "AFHTTPSessionManager+Util.h"


@interface OAuthViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self generateWebPage];
    // Do any additional setup after loading the view.
}

- (void)generateWebPage
{
//    NSString *htmlStr = @"<!DOCTYPE html> <html><p> 你妹</p> </br> <div> 成都四百八十寺，多少楼台雾霾中 </div>  </html>";
    
//    [self.webView loadHTMLString:htmlStr baseURL:nil];
    
    // 创建请求授权的request
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",WB_API_AUTHORIZE,WB_APPKEY,WB_REDIRECTURI]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate 

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"url = %@",request.URL.absoluteString);
    
    NSString *urlStr = request.URL.absoluteString;
    
    if ([urlStr containsString:@"code="] && [urlStr containsString:WB_REDIRECTURI]) {
        NSArray *arr = [urlStr componentsSeparatedByString:@"code="];
        NSString *code = arr.lastObject;
        
        // 就需要去获取第二把钥匙了。
        
        [self getAccesstokenWithCode:code];
        
        // 如果是获取到授权code的页面，就不需要加载出来了。
        return NO;
    }
    
    return YES;
}

/** 获取accesstoken*/
- (void)getAccesstokenWithCode:(NSString *)code
{
    // 生成请求参数
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"client_id"]= WB_APPKEY;
    params[@"client_secret"] = WB_SECRET;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = WB_REDIRECTURI;
    
    [AFHTTPSessionManager requestWithType:AFHTTPSessionManagerRequestTypePOST URLString:WB_API_GETACCESSTOKEN parmaeters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"respoobj = %@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"erro  =%@",[error localizedDescription]);
    }];
    
//    [[AFHTTPRequestOperationManager manager] POST:WB_API_GETACCESSTOKEN parameters:params success:^ (AFHTTPRequestOperation * op, id res) {
//        NSLog(@"xxxxx");
//    } failure:^ (AFHTTPRequestOperation * op, NSError * error) {
//        NSLog(@"erro  =%@",[error localizedDescription]);
//
//    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
