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
            return NSLocalizedString(@"缺少参数", @"缺少参数");
        case 10002:
            return NSLocalizedString(@"参数所带值错误", @"参数所带值错误");
        case 10003:
            return NSLocalizedString(@"非法操作", @"非法操作");
        case 10004:
            return NSLocalizedString(@"您没有权限查看此群组", @"您没有权限查看此群组");
        case 10005:
            return NSLocalizedString(@"内部错误", @"内部错误");
        case 10006:
            return NSLocalizedString(@"您没有权限查看此任务", @"您没有权限查看此任务");
        case 10007:
            return NSLocalizedString(@"请求数据不存在", @"请求数据不存在");
        case 10008:
            return NSLocalizedString(@"您没有权限查看此日程", @"您没有权限查看此日程");
        case 10009:
            return NSLocalizedString(@"无权对任务进行操作(权限仅给任务负责人或任务创建者)", @"无权对任务进行操作(权限仅给任务负责人或任务创建者)");
        case 10010:
            return NSLocalizedString(@"无权对日程进行操作(权限仅给日程创建者)", @"无权对日程进行操作(权限仅给日程创建者)");
        case 10011:
            return NSLocalizedString(@"无权对群组进行操作(权限仅给群组管理员或网络管理员)", @"无权对群组进行操作(权限仅给群组管理员或网络管理员)");
        case 10012:
            return NSLocalizedString(@"无权对动态进行操作(权限仅给动态创建者或网络管理员)", @"无权对动态进行操作(权限仅给动态创建者或网络管理员)");
        case 10013:
            return NSLocalizedString(@"无权查看动态相关内容", @"无权查看动态相关内容");
        case 10014:
            return NSLocalizedString(@"无权查看群组相关内容", @"无权查看群组相关内容");
        case 10017:
            return NSLocalizedString(@"项目名称已经存在", @"项目名称已经存在");
        case 10021:
            return NSLocalizedString(@"群组名称已存在", @"群组名称已存在");
            
        case 10101:
            return NSLocalizedString(@"请求令牌不存在", @"请求令牌不存在");
        case 10102:
            return NSLocalizedString(@"请求令牌签名不合法", @"请求令牌签名不合法");
        case 10103:
            return NSLocalizedString(@"用户账号不存在", @"用户账号不存在");
        case 10104:
            return NSLocalizedString(@"登录验证失败,密码错误", @"登录验证失败,密码错误");
        case 10105:
            return NSLocalizedString(@"用户访问令牌失效", @"用户访问令牌失效");
        case 10107:
            return NSLocalizedString(@"由于多次尝试失败,账号已被锁定,20分钟后解锁", @"由于多次尝试失败,账号已被锁定,20分钟后解锁");
        case 10108:
            return NSLocalizedString(@"登录状态已过期,请重新登录", @"登录状态已过期,请重新登录");
            
        case 10201:
            return NSLocalizedString(@"Email不合法", @"Email不合法");
        case 10202:
            return NSLocalizedString(@"Email已经注册", @"Email已经注册");
        case 10203:
            return NSLocalizedString(@"非本网络Email", @"非本网络Email");
        case 10204:
            return NSLocalizedString(@"非法邀请", @"非法邀请");
        case 10205:
            return NSLocalizedString(@"有效域名邮箱，不能通过来宾邀请加入", @"有效域名邮箱，不能通过来宾邀请加入");
        case 10206:
            return NSLocalizedString(@"无权限邀请来宾", @"无权限邀请来宾");
            
        case 10301:
            return NSLocalizedString(@"暂无应用的最新版本", @"暂无应用的最新版本");
        case 10302:
            return NSLocalizedString(@"仅限高级模式的管理员，针对企业应用", @"仅限高级模式的管理员，针对企业应用");
        case 10303:
            return NSLocalizedString(@"仅限高级模式的管理员调用", @"仅限高级模式的管理员调用");
        case 10304:
            return NSLocalizedString(@"仅限高级模式可调用", @"仅限高级模式可调用");
        case 10305:
            return NSLocalizedString(@"仅限应用创建者可调用", @"仅限应用创建者可调用");

        case 10401:
            return NSLocalizedString(@"扩展应用未安装", @"扩展应用未安装");
            
        default: {
            NSMutableString *string = [NSLocalizedString(@"操作失败", @"操作失败") mutableCopy];
            [string appendString:@", "];
            [string appendString:NSLocalizedString(@"错误代码", @"错误代码")];
            [string appendFormat:@":%ld", (long)errorCodeInt];
            return string;
        }
    }
}

+ (NSError *)errorWithMDDic:(NSDictionary *)dic URLString:(NSString *)urlString
{
    if (dic) {
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (!errorCode) {
            return nil;
        }
        NSInteger code = [errorCode integerValue];
        NSString *localizedDescription = [self errorStringWithErrorCode:[dic objectForKey:@"error_code"]];
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:localizedDescription forKey:NSLocalizedDescriptionKey];
        [userInfo setObject:urlString forKey:@"NSErrorFailingURLStringKey"];
        
        NSError *error = [NSError errorWithDomain:MDAPIErrorDomain code:code userInfo:userInfo];
        return error;
    }

    return [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:[MDErrorParser errorStringWithErrorCode:@"0"],@"NSErrorFailingURLStringKey":urlString}];
}

+ (NSError *)errorWithHttpErrorCode:(int)statusCode URLString:(NSString *)urlString
{
    if (statusCode == 404) {
        NSString *localizedDescription = nil;
        localizedDescription = NSLocalizedString(@"服务器错误", @"服务器错误");
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:localizedDescription forKey:NSLocalizedDescriptionKey];
        [userInfo setObject:urlString forKey:@"NSErrorFailingURLStringKey"];
        
        NSError *error = [NSError errorWithDomain:MDAPIErrorDomain code:statusCode userInfo:userInfo];
        return error;
    }
    
    return [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:[MDErrorParser errorStringWithErrorCode:@"0"],@"NSErrorFailingURLStringKey":urlString}];
}
@end
