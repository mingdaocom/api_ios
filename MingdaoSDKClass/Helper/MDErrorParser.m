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
    NSString *errorString = [NSString stringWithFormat:@"%d", [errorCode intValue]];
    return MDErrorLocalizedString(errorString, nil);
}

+ (NSError *)errorWithMDDic:(NSDictionary *)dic URLString:(NSString *)urlString
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        BOOL success = [dic[@"success"] boolValue];
        if (success) {
            return nil;
        }
        else { // if not success, the API MUST return error_code AND error_msg
            NSNumber *errorCode = [dic objectForKey:@"error_code"];
            NSString *errorMessage = [dic objectForKey:@"error_msg"];
            if (!errorCode || !errorMessage) {
                return [self mysteryError:urlString];
            }
            
            NSString *localizedDescription = [self errorStringWithErrorCode:[errorCode stringValue]];
            if ([localizedDescription isEqualToString:[errorCode stringValue]]) {
                if (errorMessage) {
                    localizedDescription = errorMessage;
                }
            }
            
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setObject:localizedDescription forKey:NSLocalizedDescriptionKey];
            [userInfo setObject:urlString forKey:@"NSErrorFailingURLStringKey"];
            
            NSError *error = [NSError errorWithDomain:MDAPIErrorDomain code:[errorCode intValue] userInfo:userInfo];
            return error;
        }
    }

    return [self mysteryError:urlString];
}

+ (NSError *)mysteryError:(NSString *)urlString
{
    NSString *errorString = [MDErrorParser errorStringWithErrorCode:@"0"];
    return [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:errorString, @"NSErrorFailingURLStringKey":urlString}];
}
@end
