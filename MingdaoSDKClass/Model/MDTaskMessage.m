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
        self.inboxID = [aDic objectForKey:@"inboxID"];
        self.messageType = [[aDic objectForKey:@"m_type"] intValue];
        
        switch (self.messageType) {
            case MDTaskMessageTypeAtMe:
                self.mentionedMessage = [[MDTaskMentionedMessage alloc] initWithDictionary:aDic];
                break;
            case MDTaskMessageTypeReplayMe:
                self.replayMessage = [[MDTaskReplyMessage alloc] initWithDictionary:aDic];
                break;
            case MDTaskMessageTypeSystem:
                self.systemMessage = [[MDTaskSystemMessage alloc] initWithDictionary:aDic];
                break;
            default:
                break;
        }
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTaskMessage *copyObject = object;
    copyObject.inboxID = [self.inboxID copy];
    copyObject.messageType = self.messageType;
    copyObject.mentionedMessage = [self.mentionedMessage copy];
    copyObject.replayMessage = [self.replayMessage copy];
    copyObject.systemMessage = [self.systemMessage copy];
    return copyObject;
}
@end
