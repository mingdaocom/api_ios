//
//  MDErrorParser.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-17.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDErrorParser.h"

#define MDErrorLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"ErrorMessage"]

@implementation MDErrorParser
+ (NSString *)errorStringWithErrorCode:(NSString *)errorCode
{
    return MDErrorLocalizedString(errorCode, nil);
}

+ (NSError *)errorWithMDDic:(NSDictionary *)dic URLString:(NSString *)urlString
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSString *errorCode = [dic objectForKey:@"error_code"];
        NSString *errorMessage = [dic objectForKey:@"error_msg"];
        if (!errorCode) {
            return nil;
        }
        NSString *localizedDescription = [self errorStringWithErrorCode:errorCode];
        if ([localizedDescription isEqualToString:errorCode]) {
            localizedDescription = errorMessage;
        }
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:localizedDescription forKey:NSLocalizedDescriptionKey];
        [userInfo setObject:urlString forKey:@"NSErrorFailingURLStringKey"];
        
        NSError *error = [NSError errorWithDomain:MDAPIErrorDomain code:[errorCode intValue] userInfo:userInfo];
        return error;
    }

    NSString *errorString = [MDErrorParser errorStringWithErrorCode:@"0"];
    return [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:errorString, @"NSErrorFailingURLStringKey":urlString}];
}
@end
