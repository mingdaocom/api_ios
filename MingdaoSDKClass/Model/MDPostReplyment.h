//
//  MDPostReplyment.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"

@interface MDPostReplyment : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) MDPostReplyment *replyTo;
- (MDPostReplyment *)initWithDictionary:(NSDictionary *)aDic;
@end
