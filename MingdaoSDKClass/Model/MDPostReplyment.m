//
//  MDPostReplyment.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDPostReplyment.h"

@implementation MDPostReplyment
- (MDPostReplyment *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"guid"];
        self.text = [aDic objectForKey:@"text"];
        self.createTime = [aDic objectForKey:@"create_time"];
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        NSDictionary *replyToDic = [aDic objectForKey:@"ref"];
        if (replyToDic && replyToDic.allKeys.count > 0) {
            self.replyTo = [[MDPostReplyment alloc] initWithDictionary:[replyToDic objectForKey:@"replyment"]];
        }
    }
    return self;
}
@end
