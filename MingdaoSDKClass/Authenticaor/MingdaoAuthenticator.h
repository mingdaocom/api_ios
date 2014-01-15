//
//  MingdaoAuthenticator.h
//  SDKDemo
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDAPIManager.h"

typedef enum {
    MDAuthorizeDisplayTypeDefault = 0,	//默认的授权页面，适用于web浏览器。
    MDAuthorizeDisplayTypeMobile,      //移动终端的授权页面，适用于支持html5的手机。
    MDAuthorizeDisplayTypePopup,       //弹窗类型的授权页，适用于web浏览器小窗口。
    MDAuthorizeDisplayTypeApponmingdao //默认的站内应用授权页，授权后不返回access_token，只刷新站内应用父框架。
} MDAuthorizeDisplayType;

@interface MingdaoAuthenticator : NSObject
+ (BOOL)openMingdaoAppWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret rediretURL:(NSString *)urlString;
+ (NSString *)mingdaoAppDidFinishAuthenticationWithResutlt:(NSURL *)result;

+ (NSURLRequest *)authorizeWithAppKey:(NSString *)appKey
                           rediretURL:(NSString *)urlString
                                state:(NSString *)state
                              display:(MDAuthorizeDisplayType)type;
@end
