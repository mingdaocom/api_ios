//
//  NSMutableArray+MDURLRequestParamsGenerator.m
//  MingdaoV2
//
//  Created by Wee Tom on 16/1/22.
//  Copyright © 2016年 Mingdao. All rights reserved.
//

#import "NSMutableArray+MDURLRequestParamsGenerator.h"

@implementation NSMutableArray (MDURLRequestParamsGenerator)
- (BOOL)addParamWithObject:(nullable id)anObject forKey:(nullable NSString *)key
{
    if (anObject && key) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        [mDic setObject:anObject forKey:@"object"];
        [mDic setObject:key forKey:@"key"];
        [self addObject:mDic];
        return YES;
    }
    return NO;
}

- (BOOL)addParamWithObject:(nullable id)anObject forKey:(nullable NSString *)key fileName:(nullable NSString *)fileName
{
    if (anObject && key && fileName) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        [mDic setObject:anObject forKey:@"object"];
        [mDic setObject:key forKey:@"key"];
        [mDic setObject:fileName forKey:@"fileName"];
        [self addObject:mDic];
        return YES;
    }
    return NO;
}
@end
