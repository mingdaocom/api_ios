//
//  NSMutableArray+MDURLRequestParamsGenerator.h
//  MingdaoV2
//
//  Created by Wee Tom on 16/1/22.
//  Copyright © 2016年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MDURLRequestParamsGenerator)
- (BOOL)addParamWithObject:(nullable id)anObject forKey:(nullable NSString *)key;
- (BOOL)addParamWithObject:(nullable id)anObject forKey:(nullable NSString *)key fileName:(nullable NSString *)fileName;
@end
