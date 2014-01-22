//
//  ViewController.m
//  MDAuthticationSDKDemo
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "ViewController.h"
#import "MDAuthenticator.h"
#import "MDAuthView.h"

#warning keys
#define AppKey @"A2714D1F5AD3D87F8D93DBC7FDA1098"
#define AppSecret @"DF468BA6954E334BD7A9A6BD964A12C0"
#define RedirectURL @"http://www.baidu.com"

@interface ViewController () <MDAuthViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button2Pressed:(UIButton *)sender {
    [self authorizeByMingdaoMobilePage];
}

- (void)mingdaoAuthView:(MDAuthView *)view didFinishAuthorizeWithResult:(NSString *)token
{
    [view removeFromSuperview];
    if (token) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Succeed!" message:[NSString stringWithFormat:@"token = %@", token] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)authorizeByMingdaoMobilePage
{
    MDAuthView *view = [[MDAuthView alloc] initWithFrame:self.view.bounds];
    view.appKey = AppKey;
    view.appSecret = AppSecret;
    view.redirectURL = RedirectURL;
    view.delegate = self;
    [view showInView:self.view];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    // 尝试使用明道App认证
    if (![MDAuthenticator authorizeByMingdaoAppWithAppKey:AppKey appSecret:AppSecret]) {
        // 未安装明道app，通过网页认证
        [self authorizeByMingdaoMobilePage];
    }
}
@end
