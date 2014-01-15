//
//  MDAuthView.m
//  MDAuthticationSDKDemo
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAuthView.h"
#import <QuartzCore/QuartzCore.h>

@interface MDAuthView ()
@property (strong, nonatomic) UIView *indicatorBaseView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation MDAuthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 44)];
        self.webView.delegate = self;
        [self addSubview:self.webView];
        
        self.indicatorBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.indicatorBaseView.center = self.webView.center;
        self.indicatorBaseView.hidden = YES;
        self.indicatorBaseView.backgroundColor = [UIColor lightGrayColor];
        self.indicatorBaseView.layer.cornerRadius = 5;
        self.indicatorBaseView.alpha = 0.5;
        [self.webView addSubview:self.indicatorBaseView];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicatorView.center = self.webView.center;
        self.indicatorView.hidesWhenStopped = YES;
        [self.webView addSubview:self.indicatorView];
        
        UIView *actionBar = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 44, frame.size.width, 44)];
        actionBar.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:actionBar];
            UIButton *cB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        [cB setTitle:@"退出" forState:UIControlStateNormal];
        [cB addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [actionBar addSubview:cB];
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished){
        
    }];
}

- (void)hide
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished){
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)start
{
    [self.webView loadRequest:[MingdaoAuthenticator authorizeWithAppKey:self.appKey rediretURL:self.redirectURL state:self.state display:MDAuthorizeDisplayTypeMobile]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request);
    if ([request.URL.absoluteString hasPrefix:self.redirectURL]) {
        NSString *code = nil;
        NSArray *quries = [request.URL.query componentsSeparatedByString:@"&"];
        if (quries.count > 0) {
            for (NSString *q in quries) {
                NSArray *parameterAndResult = [q componentsSeparatedByString:@"="];
                if (parameterAndResult.count == 2 && [parameterAndResult[0] isEqualToString:@"code"]) {
                    code = parameterAndResult[1];
                    NSLog(@"code == %@", code);
                    self.indicatorBaseView.hidden = NO;
                    [self.indicatorView startAnimating];
                    [[[MDAPIManager sharedManager] loginWithAppKey:self.appKey appSecret:self.appSecret code:code redirectURL:self.redirectURL handler:^(BOOL succeed, NSError *error){
                        self.indicatorBaseView.hidden = YES;
                        [self.indicatorView stopAnimating];
                        if (error || !succeed) {
                            return ;
                        }
                        NSLog(@"%@", [MDAPIManager sharedManager].accessToken);
                        [self.delegate mingdaoAuthView:self didFinishAuthorizeWithResult:[MDAPIManager sharedManager].accessToken];
                    }] start];
                    return NO;
                }
            }
        }
    }
    return YES;
}

@end
