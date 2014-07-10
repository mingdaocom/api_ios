//
//  MDTaskMessageSystem.m
//  MingdaoV2
//
//  Created by WeeTom on 14-7-9.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDTaskSystemMessage.h"

@implementation MDTaskSystemMessage
- (MDTaskSystemMessage *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.createTime = [aDic objectForKey:@"create_time"];
        self.isFavourite = [[aDic objectForKey:@"is_favorite"] boolValue];
        self.isInboxUnread = [[aDic objectForKey:@"status"] boolValue];
        
        NSDictionary *msgDic = [aDic objectForKey:@"message"];
        if ([msgDic isKindOfClass:[NSDictionary class]]) {
            self.text = [msgDic objectForKey:@"msg"];
            self.isMessageUnread = [[msgDic objectForKey:@"status"] boolValue];
            self.eventType = [[msgDic objectForKey:@"event_type"] intValue];
            
            if (self.eventType == MDTaskEventTypeTaskApply) {
                self.eventContent = [msgDic objectForKey:@"event_content"];
                NSArray *arr = [NSArray arrayWithArray:[self.eventContent componentsSeparatedByString:@"|"]];
                self.taskID = arr[0];
                self.applyUserID = arr[1];
            }
        }
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTaskSystemMessage *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.text = [self.text copy];
    copyObject.createTime = [self.createTime copy];
    copyObject.isFavourite = self.isFavourite;
    copyObject.isInboxUnread = self.isInboxUnread;
    copyObject.isMessageUnread = self.isMessageUnread;
    copyObject.eventType = self.eventType;
    copyObject.eventContent = [self.eventContent copy];
    copyObject.taskID = [self.taskID copy];
    copyObject.applyUserID = [self.applyUserID copy];
    return copyObject;
}

@end
