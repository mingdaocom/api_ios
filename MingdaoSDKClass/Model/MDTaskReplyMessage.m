//
//  MDTaskReplyMessage.m
//  MingdaoV2
//
//  Created by WeeTom on 14-7-10.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDTaskReplyMessage.h"

@implementation MDTaskReplyMessage
- (MDTaskMentionedMessage *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super initWithDictionary:aDic];
    if (self) {
        NSDictionary *originTopic = [aDic objectForKey:@"origin_topic"];
        if ([originTopic isKindOfClass:[NSDictionary class]]) {
            self.originTopic = [[MDTaskReplyMessage alloc] initWithDictionary:originTopic];
        }
    }
    return self;
}
@end
