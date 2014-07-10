//
//  MDTaskMessage.h
//  MingdaoV2
//
//  Created by WeeTom on 14-7-9.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MDTaskMentionedMessage.h"
#import "MDTaskReplyMessage.h"
#import "MDTaskSystemMessage.h"

typedef enum {
    MDTaskMessageTypeSystem = 1,
    MDTaskMessageTypeReplayMe = 2,
    MDTaskMessageTypeAtMe = 3
}MDTaskMessageType;

@interface MDTaskMessage : NSObject
@property (strong, nonatomic) NSString *inboxID;
@property (assign, nonatomic) int messageType;
@property (strong, nonatomic) MDTaskMentionedMessage *mentionedMessage;
@property (strong, nonatomic) MDTaskReplyMessage *replayMessage;
@property (strong, nonatomic) MDTaskSystemMessage *systemMessage;

- (MDTaskMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
