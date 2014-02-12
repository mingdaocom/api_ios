//
//  MingdaoAuthenticator.h
//  Mingdao
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDAPIManager.h"

extern NSString *const MDAuthErrorKey;
extern NSString *const MDAuthAccessTokenKey;
extern NSString *const MDAuthRefreshTokenKey;
extern NSString *const MDAuthExpiresTimeKeyl;

typedef enum {
    MDAuthorizeDisplayTypeDefault = 0,	//默认的授权页面，适用于web浏览器。
    MDAuthorizeDisplayTypeMobile,      //移动终端的授权页面，适用于支持html5的手机。
    MDAuthorizeDisplayTypePopup,       //弹窗类型的授权页，适用于web浏览器小窗口。
    MDAuthorizeDisplayTypeApponmingdao //默认的站内应用授权页，授权后不返回access_token，只刷新站内应用父框架。
} MDAuthorizeDisplayType;

@interface MDAuthenticator : NSObject
/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 获取明道App安装情况
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
+ (BOOL)canOpenMingdaoAppForAuth;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 通过调用明道App来获取认证信息
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
+ (BOOL)authorizeByMingdaoAppWithAppKey:(NSString *)appKey
                              appSecret:(NSString *)appSecret;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 通过解析明道App返回的URL来获取认证信息
 格式:
 @{
    @"access_token":@"A",
    @"expire_in":@"B",
    @"refresh_token":@"C"
 }
 如果url并非明道验证返回链接则返回nil
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
+ (NSDictionary *)mingdaoAppDidFinishAuthenticationWithURL:(NSURL *)result;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 通过Mobile来认证的链接,使用方法参考 @MDAuthView
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
+ (NSURLRequest *)authorizeWithAppKey:(NSString *)appKey
                           rediretURL:(NSString *)urlString
                                state:(NSString *)state
                              display:(MDAuthorizeDisplayType)type;
@end
