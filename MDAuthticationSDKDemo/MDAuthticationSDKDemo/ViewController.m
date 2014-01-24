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
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation ViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MDAPIManagerNewTokenSetNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newTokenSet:) name:MDAPIManagerNewTokenSetNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button2Pressed:(UIButton *)sender {
    [self authorizeByMingdaoMobilePage];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    // 尝试使用明道App认证
    [self authorizeByMingdaoApp];
}

- (void)authorizeByMingdaoApp
{
    if (![MDAuthenticator authorizeByMingdaoAppWithAppKey:AppKey appSecret:AppSecret]) {
        [self authorizeByMingdaoMobilePage];
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

- (void)mingdaoAuthView:(MDAuthView *)view didFinishAuthorizeWithResult:(NSString *)token
{
    [view removeFromSuperview];
    if (token) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Succeed!" message:[NSString stringWithFormat:@"token = %@", token] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
        [alertView show];
        [MDAPIManager sharedManager].accessToken = token;
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)newTokenSet:(NSNotification *)notification
{
    self.tokenLabel.text = notification.object;
    
    [self.indicator startAnimating];
    __weak __block typeof(self) weakSelf = self;
    
    [[[MDAPIManager sharedManager] loadCurrentUserDetailWithHandler:^(MDUser *user, NSError *error){
        [weakSelf.indicator stopAnimating];
        if (error) {
            weakSelf.nameLabel.text = error.userInfo[NSLocalizedDescriptionKey];
            return ;
        }
        weakSelf.nameLabel.text = user.objectName;
        weakSelf.titleLabel.text = user.job;
        weakSelf.birthLabel.text = user.birth;
    }] start];
}
@end
