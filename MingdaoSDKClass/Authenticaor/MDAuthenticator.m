//
//  MingdaoAuthenticator.m
//  Mingdao
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAuthenticator.h"

NSString *const MDAuthErrorKey = @"error";
NSString *const MDAuthAccessTokenKey = @"access_token";
NSString *const MDAuthRefreshTokenKey = @"refresh_token";
NSString *const MDAuthExpiresTimeKey = @"expires_in";

@implementation MDAuthenticator
+ (BOOL)canOpenMingdaoAppForAuth
{
    NSMutableString *ipadString = [NSMutableString stringWithString:@"mingdaoHD://"];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ipadString]]) {
        return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ipadString]];
    } else {
        NSMutableString *string = [NSMutableString stringWithString:@"mingdao://"];
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }
}

+ (BOOL)authorizeByMingdaoAppWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    NSMutableString *ipadString = [NSMutableString stringWithString:@"mingdaoHD://app.mingdao.com/authentication/?"];
    [ipadString appendFormat:@"appKey==%@&&appSecret==%@", appKey, appSecret];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ipadString]]) {
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ipadString]];
    } else {
        NSMutableString *string = [NSMutableString stringWithString:@"mingdaoT://app.mingdao.com/authentication/?"];
        [string appendFormat:@"appKey==%@&&appSecret==%@", appKey, appSecret];
        
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }
}

+ (NSDictionary *)mingdaoAppDidFinishAuthenticationWithURL:(NSURL *)url
{
    if ([url.scheme hasPrefix:@"mingdaoApp"]) {
        NSArray *queries = [url.query componentsSeparatedByString:@"&&"];
        if (queries.count > 0) {
            NSString *result = nil;
            for (NSString *p in queries) {
                if ([p hasPrefix:@"result"]) {
                    if ([[p componentsSeparatedByString:@"=="] count] >= 2) {
                        result = [p componentsSeparatedByString:@"=="][1];
                    }
                }
            }

            if (result) {
                NSString *resultString = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[resultString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                if (dic) {
                    return dic;
                }
            }
        }
    }
    return nil;
}

+ (NSURLRequest *)authorizeWithAppKey:(NSString *)appKey
                           rediretURL:(NSString *)urlString
                                state:(NSString *)state
                              display:(MDAuthorizeDisplayType)type
{
    NSMutableString *string = [NSMutableString stringWithString:[MDAPIManager sharedManager].serverAddress];
    [string appendString:@"/oauth2/authorize?"];
    [string appendFormat:@"app_key=%@&redirect_uri=%@", appKey, urlString];
    if (state) {
        [string appendFormat:@"state=%@", state];
    }
    if (type != 0) {
        switch (type) {
            case MDAuthorizeDisplayTypeDefault:
                [string appendString:@"&display=default"];
                break;
            case MDAuthorizeDisplayTypeMobile:
                [string appendString:@"&display=mobile"];
                break;
            case MDAuthorizeDisplayTypePopup:
                [string appendString:@"&display=popup"];
                break;
            default:
                [string appendString:@"&display=apponmingdao"];
                break;
        }
    }
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
}
@end
