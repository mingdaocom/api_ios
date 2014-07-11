//
//  MDTaskReplyMessage.h
//  MingdaoV2
//
//  Created by WeeTom on 14-7-10.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDTaskMentionedMessage.h"

@interface MDTaskReplyMessage : MDTaskMentionedMessage
@property (strong, nonatomic) MDTaskReplyMessage *originTopic;
@end
