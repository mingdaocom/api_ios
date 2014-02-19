//
//  MDAuthPanel.m
//  MDAuthticationSDKDemo
//
//  Created by Wee Tom on 14-2-19.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAuthPanel.h"

@interface MDAuthPanel () <UIWebViewDelegate, UAModalPanelDelegate>
@property (strong, nonatomic) UIView *indicatorBaseView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation MDAuthPanel
- (MDAuthPanel *)initWithFrame:(CGRect)frame appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL state:(NSString *)state;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.appKey = appKey;
        self.appSecret = appSecret;
        self.redirectURL = redirectURL;
        self.state = state;
        
        self.delegate = self;
        
        self.margin = UIEdgeInsetsMake(28, 12, 10, 12);
        self.padding = UIEdgeInsetsMake(1, 1, 1, 1);
        self.webView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
        self.webView.delegate = self;
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.webView];
        
        self.indicatorBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.indicatorBaseView.center = self.webView.center;
        self.indicatorBaseView.hidden = YES;
        self.indicatorBaseView.backgroundColor = [UIColor lightGrayColor];
        self.indicatorBaseView.layer.cornerRadius = 5;
        self.indicatorBaseView.alpha = 0.5;
        self.indicatorBaseView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self.webView addSubview:self.indicatorBaseView];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicatorView.center = self.webView.center;
        self.indicatorView.hidesWhenStopped = YES;
        self.indicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self.webView addSubview:self.indicatorView];
    }
    return self;
}

- (void)show
{
    [super show];
    [self.webView loadRequest:[MDAuthenticator authorizeWithAppKey:self.appKey rediretURL:self.redirectURL state:self.state display:MDAuthorizeDisplayTypeMobile]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.indicatorBaseView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.indicatorBaseView.hidden = YES;
    [self.indicatorView stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasPrefix:self.redirectURL]) {
        NSString *code = nil;
        NSArray *quries = [request.URL.query componentsSeparatedByString:@"&"];
        if (quries.count > 0) {
            for (NSString *q in quries) {
                NSArray *parameterAndResult = [q componentsSeparatedByString:@"="];
                if (parameterAndResult.count == 2 && [parameterAndResult[0] isEqualToString:@"code"]) {
                    code = parameterAndResult[1];
                    self.indicatorBaseView.hidden = NO;
                    [self.indicatorView startAnimating];
                    
                    __weak __block typeof(self) weakSelf = self;
                    [[[MDAPIManager sharedManager] loginWithAppKey:self.appKey appSecret:self.appSecret code:code redirectURL:self.redirectURL handler:^(NSDictionary *dic, NSError *error){
                        weakSelf.indicatorBaseView.hidden = YES;
                        [weakSelf.indicatorView stopAnimating];
                        if (error) {
                            [weakSelf.authDelegate mingdaoAuthPanel:self
                                       didFinishAuthorizeWithResult:@{MDAuthErrorKey:@"MDAuthErrorAPIError"}];
                            return ;
                        }
                        
                        [weakSelf.authDelegate mingdaoAuthPanel:self
                                   didFinishAuthorizeWithResult:dic];
                    }] start];
                    return NO;
                }
            }
        }
    }
    return YES;
}

#pragma mark - UAModalDisplayPanelViewDelegate
// Optional: This is called when the close button is pressed
//   You can use it to perform validations
//   Return YES to close the panel, otherwise NO
//   Only used if delegate is set.
- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"shouldCloseModalPanel called with modalPanel: %@", modalPanel);
    [self.authDelegate mingdaoAuthPanel:self
           didFinishAuthorizeWithResult:@{MDAuthErrorKey:@"MDAuthErrorUserCancelled"}];
	return YES;
}
@end
