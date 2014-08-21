//
//  MDTaskMentionedMessage.h
//  MingdaoV2
//
//  Created by WeeTom on 14-7-10.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDTask.h"
#import "MDTaskReplyment.h"

@interface MDTaskMentionedMessage : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *replyID;
@property (assign, nonatomic) int isFavourite;
@property (strong, nonatomic) MDUser *createUser;
@property (strong, nonatomic) MDUser *replyUser;
@property (strong, nonatomic) MDTask *task;

@property (strong, nonatomic) NSArray *images, *files;

- (MDTaskMentionedMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
