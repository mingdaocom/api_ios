//
//  MDTaskMessage.m
//  MingdaoV2
//
//  Created by WeeTom on 14-7-9.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDTaskMessage.h"

@implementation MDTaskMessage
- (MDTaskMessage *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"topicID"];
        self.text = [aDic objectForKey:@"msg"];
        self.createTime = [aDic objectForKey:@"create_time"];
        self.replyID = [aDic objectForKey:@"replyID"];
        self.isFavourite = [[aDic objectForKey:@"is_favorite"] intValue];
        
        NSDictionary *creatorDic = [aDic objectForKey:@"create_user"];
        if ([creatorDic isKindOfClass:[NSDictionary class]]) {
            self.createUser = [[MDUser alloc] initWithDictionary:creatorDic];
        }
        
        NSDictionary *replierDic = [aDic objectForKey:@"reply_user"];
        if ([replierDic isKindOfClass:[NSDictionary class]]) {
            self.replyUser = [[MDUser alloc] initWithDictionary:replierDic];
        }
        
        MDTask *task = [[MDTask alloc] init];
        task.objectID = [aDic objectForKey:@"taskID"];
        task.objectName = [aDic objectForKey:@"taskName"];
        self.task = [task copy];
        
        self.type = [[aDic objectForKey:@"m_type"] intValue];
        self.fileType = [[aDic objectForKey:@"file_type"] intValue];
        
        NSDictionary *originTopic = [aDic objectForKey:@"origin_topic"];
        if ([originTopic isKindOfClass:[NSDictionary class]]) {
            self.replymentToReplyment = [[MDTaskMessage alloc] initWithDictionary:originTopic];
        }
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTaskMessage *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.text = [self.text copy];
    copyObject.createTime = [self.createTime copy];
    copyObject.replyID = [self.replyID copy];
    copyObject.isFavourite = self.isFavourite;
    copyObject.createUser = [self.createUser copy];
    copyObject.replyUser = [self.replyUser copy];
    copyObject.task = [self.task copy];
    copyObject.type = self.type;
    copyObject.fileType = self.fileType;
    copyObject.replymentToReplyment = [self.replymentToReplyment copy];
    return copyObject;
}
@end
