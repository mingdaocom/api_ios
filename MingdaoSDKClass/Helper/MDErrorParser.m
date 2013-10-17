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
            return @"您没有权限查看此群组";
        case 10005:
            return @"内部错误";
        case 10006:
            return @"您没有权限查看此任务";
        case 10007:
            return @"请求数据不存在";
        case 10008:
            return @"您没有权限查看此日程";
        case 10009:
            return @"无权对任务进行操作(权限仅给任务负责人或任务创建者)";
        case 10010:
            return @"无权对日程进行操作(权限仅给日程创建者)";
        case 10011:
            return @"无权对群组进行操作(权限仅给群组管理员或网络管理员)";
        case 10012:
            return @"无权对动态进行操作(权限仅给动态创建者或网络管理员)";
        case 10013:
            return @"无权查看动态相关内容";
        case 10014:
            return @"无权查看群组相关内容";
            
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
        case 10205:
            return @"有效域名邮箱，不能通过来宾邀请加入";
        case 10206:
            return @"无权限邀请来宾";
            
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

        case 10401:
            return @"扩展应用未安装";
            
        default:
            return @"未知错误";
    }
}

+ (NSError *)errorWithMDDic:(NSDictionary *)dic URLString:(NSString *)urlString
{
    if (dic) {
        NSInteger code = [[dic objectForKey:@"error_code"] integerValue];
        NSString *localizedDescription = [self errorStringWithErrorCode:[dic objectForKey:@"error_code"]];
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:localizedDescription forKey:@"NSLocalizedDescription"];
        [userInfo setObject:urlString forKey:@"NSErrorFailingURLStringKey"];
        
        NSError *error = [NSError errorWithDomain:MDAPIErrorDomain code:code userInfo:userInfo];
        return error;
    }

    return [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:@{@"NSLocalizedDescription":[MDErrorParser errorStringWithErrorCode:@"0"],@"NSErrorFailingURLStringKey":urlString}];
}

+ (NSError *)errorWithHttpErrorCode:(int)statusCode URLString:(NSString *)urlString
{
    if (statusCode == 404) {
        NSString *localizedDescription = nil;
        if (NSMaxRange([urlString rangeOfString:@"api.mingdao.com"]) < urlString.length) {
            localizedDescription = @"服务器错误";
        } else {
            localizedDescription = @"您使用的是私有部署的明道版本，此功能将在后续版本中提供";
        }
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:localizedDescription forKey:@"NSLocalizedDescription"];
        [userInfo setObject:urlString forKey:@"NSErrorFailingURLStringKey"];
        
        NSError *error = [NSError errorWithDomain:MDAPIErrorDomain code:statusCode userInfo:userInfo];
        return error;
    }
    
    return [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:@{@"NSLocalizedDescription":[MDErrorParser errorStringWithErrorCode:@"0"],@"NSErrorFailingURLStringKey":urlString}];
}
@end
