//
//  MDErrorParser.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-17.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MDAPIErrorDomain @"MDAPIErrorDomain"

@interface MDErrorParser : NSObject
+ (NSString *)errorStringWithErrorCode:(NSString *)errorCode;
+ (NSError *)errorWithMDDic:(NSDictionary *)dic URLString:(NSString *)urlString;
+ (NSError *)errorWithHttpErrorCode:(int)statusCode URLString:(NSString *)urlString;
@end
