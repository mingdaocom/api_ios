//
//  MingdaoAuthenticator.m
//  SDKDemo
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MingdaoAuthenticator.h"

@implementation MingdaoAuthenticator
+ (BOOL)openMingdaoAppWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret rediretURL:(NSString *)urlString
{
    NSMutableString *string = [NSMutableString stringWithString:@"mingdao://app.mingdao.com/authentication/?"];
    [string appendFormat:@"appKey==%@&&appSecret==%@&&redirectURL==%@", appKey, appSecret, [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

+ (NSString *)mingdaoAppDidFinishAuthenticationWithResutlt:(NSURL *)url
{
    if ([url.scheme hasPrefix:@"mingdaoApp"]) {
        NSArray *queries = [url.query componentsSeparatedByString:@"&&"];
        if (queries.count == 2) {
            NSString *code = [queries[0] componentsSeparatedByString:@"=="][1];
            NSString *redirectURL = [[queries[1] componentsSeparatedByString:@"=="][1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSLog(@"code = %@\nredirectURL = %@", code, redirectURL);
            
            if (code) {
                return code;
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
                [string appendString:@"default"];
                break;
            case MDAuthorizeDisplayTypeMobile:
                [string appendString:@"mobile"];
                break;
            case MDAuthorizeDisplayTypePopup:
                [string appendString:@"popup"];
                break;
            default:
                [string appendString:@"apponmingdao"];
                break;
        }
    }
    return [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
}
@end
