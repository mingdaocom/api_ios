//
//  MDAuthPanel.h
//  MDAuthticationSDKDemo
//
//  Created by Wee Tom on 14-2-19.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "UAModalPanel.h"
#import "MDAuthenticator.h"

@class MDAuthPanel;

@protocol MDAuthPanelDelegate <NSObject>
- (void)mingdaoAuthPanel:(MDAuthPanel *)panel didFinishAuthorizeWithResult:(NSDictionary *)result;
@end

@interface MDAuthPanel : UAModalPanel
- (MDAuthPanel *)initWithFrame:(CGRect)frame appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL state:(NSString *)state;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *redirectURL;
@property (strong, nonatomic) NSString *state; // optional
@property (weak, nonatomic) id<MDAuthPanelDelegate> authDelegate;
@end
