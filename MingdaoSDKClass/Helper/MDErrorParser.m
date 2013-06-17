//
//  MDErrorParser.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-17.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDErrorParser.h"

@implementation MDErrorParser
+ (NSString *)errorStringWithErrorCode:(NSString *)errorCode
{
    NSInteger errorCodeInt = [errorCode integerValue];
    switch (errorCodeInt) {
        case 10001:
            return @"缺少参数";
        case 10002:
            return @"参数所带值错误";
        case 10003:
            return @"非法操作";
        case 10004:
            return @"请求未加入群组数据";
        case 10005:
            return @"内部错误";
        case 10006:
            return @"请求未加入任务数据";
        case 10007:
            return @"请求数据不存在";
        case 10008:
            return @"请求未加入日程数据";
        
        case 10101:
            return @"请求令牌不存在";
        case 10102:
            return @"请求令牌签名不合法";
        case 10103:
            return @"用户账号不存在";
        case 10104:
            return @"登录验证失败,密码错误";
        case 10105:
            return @"用户访问令牌失效";
            
        case 10201:
            return @"Email不合法";
        case 10202:
            return @"Email已经注册";
        case 10203:
            return @"非本网络Email";
        case 10204:
            return @"非法邀请";
            
        case 10301:
            return @"暂无应用的最新版本";
        case 10302:
            return @"仅限高级模式的管理员，针对企业应用";
        case 10303:
            return @"仅限高级模式的管理员调用";
        case 10304:
            return @"仅限高级模式可调用";
        case 10305:
            return @"仅限应用创建者可调用";

        default:
            return @"未知错误";
    }
}
@end
