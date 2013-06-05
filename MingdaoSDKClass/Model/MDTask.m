//
//  MDTask.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-5.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDTask.h"

@implementation MDTask
- (MDTask *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"guid"];
        self.objectName = [aDic objectForKey:@"title"];
        self.des = [aDic objectForKey:@"des"];
        self.expiredDateString = [aDic objectForKey:@"expire_date"];
        self.finishedDateString = [aDic objectForKey:@"finished_date"];
        self.replyCount = [[aDic objectForKey:@"reply_count"] integerValue];
        self.createdDateString = [aDic objectForKey:@"create_time"];
        self.creatorID = [aDic objectForKey:@"create_userid"];
        self.project = [[MDProject alloc] initWithDictionary:[aDic objectForKey:@"project"]];
        self.charger = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        
        NSMutableArray *memebers = [NSMutableArray array];
        NSDictionary *userDics = [aDic objectForKey:@"joined"];
        for (NSDictionary *userDic in userDics) {
            if ([userDic isKindOfClass:[NSDictionary class]]) {
                MDUser *aUser = [[MDUser alloc] initWithDictionary:userDic];
                [memebers addObject:aUser];
            }
        }
        self.members = memebers;
    }
    return self;
}
@end
