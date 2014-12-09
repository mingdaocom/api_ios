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
@end
