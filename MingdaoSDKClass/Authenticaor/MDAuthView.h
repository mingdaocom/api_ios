//
//  MDAuthView.h
//  MDAuthticationSDKDemo
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDAuthenticator.h"

@class MDAuthView;

@protocol MDAuthViewDelegate <NSObject>
- (void)mingdaoAuthView:(MDAuthView *)view didFinishAuthorizeWithResult:(NSString *)token;
@end

@interface MDAuthView : UIView <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *redirectURL;
@property (strong, nonatomic) NSString *state; // optional
@property (weak, nonatomic) id<MDAuthViewDelegate> delegate;
- (void)showInView:(UIView *)view;
- (void)hide;
@end
