//
//  MDMessage.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"

@interface MDMessageAll : NSObject
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) MDUser *creator;

- (MDMessageAll *)initWithDictionary:(NSDictionary *)aDic;
@end
