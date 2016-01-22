//
//  NSURLRequest+MDURLRequestGenerator.h
//  MingdaoV2
//
//  Created by Wee Tom on 16/1/22.
//  Copyright © 2016年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSURLRequest (MDURLRequestGenerator)
+ (NSURLRequest *)postWithHost:(NSString *)host api:(NSString *)api parameters:(NSArray *)parameters;
+ (NSURLRequest *)getWithHost:(NSString *)host api:(NSString *)api parameters:(NSArray *)parameters;
@end
