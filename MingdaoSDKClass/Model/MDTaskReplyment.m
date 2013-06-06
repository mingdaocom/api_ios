//
//  MDTaskReplyment.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDTaskReplyment.h"

@implementation MDTaskReplyment
- (MDTaskReplyment *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"guid"];
        self.text = [aDic objectForKey:@"text"];
        self.createDateString = [aDic objectForKey:@"create_time"];
        self.type = [[aDic objectForKey:@"type"] integerValue];
        NSDictionary *detailDic = [aDic objectForKey:@"detail"];
        if ([detailDic isKindOfClass:[detailDic class]]) {
            self.original_file = [aDic objectForKey:@"original_file"];
            self.original_pic = [aDic objectForKey:@"original_pic"];
            self.thumbnail_pic = [aDic objectForKey:@"thumbnail_pic"];
        }
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        NSDictionary *replyToDic = [aDic objectForKey:@"ref"];
        if ([replyToDic isKindOfClass:[NSDictionary class]]) {
            self.replyTo = [[MDUser alloc] initWithDictionary:[replyToDic objectForKey:@"user"]];
        }
    }
    return self;
}
@end
