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
        self.replyCount = [[aDic objectForKey:@"reply_count"] intValue];
        self.unreadCount = [[aDic objectForKey:@"unread_count"] intValue];
        self.createdDateString = [aDic objectForKey:@"create_time"];
        self.creatorID = [aDic objectForKey:@"create_userid"];
        self.project = [[MDProject alloc] initWithDictionary:[aDic objectForKey:@"project"]];
        if (!self.project.objectID) {
            self.project = nil;
        }
        self.charger = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        self.subTaskCount = [[aDic objectForKey:@"sub_count"] intValue];
        
        NSMutableArray *memebers = [NSMutableArray array];
        NSDictionary *userDics = [aDic objectForKey:@"joined"];
        for (NSDictionary *userDic in userDics) {
            if ([userDic isKindOfClass:[NSDictionary class]]) {
                MDUser *aUser = [[MDUser alloc] initWithDictionary:userDic];
                [memebers addObject:aUser];
            }
        }
        self.members = memebers;
        
        NSMutableArray *subTasks = [NSMutableArray array];
        NSDictionary *taskDics = [aDic objectForKey:@"c_task"];
        for (NSDictionary *taskDic in taskDics) {
            if ([taskDic isKindOfClass:[NSDictionary class]]) {
                MDTask *aTask = [[MDTask alloc] initWithDictionary:taskDic];
                [subTasks addObject:aTask];
            }
        }
        self.subTasks = subTasks;
    }
    return self;
}

- (BOOL)finished
{
    return (self.finishedDateString && self.finishedDateString.length > 0);
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        MDTask *aUser = (MDTask *)object;
        if ([[self.objectID lowercaseString] isEqualToString:[aUser.objectID lowercaseString]]) {
            return YES;
        }
    }
    
    return NO;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTask *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    copyObject.des = [self.des copy];
    copyObject.createdDateString = [self.createdDateString copy];
    copyObject.expiredDateString = [self.expiredDateString copy];
    copyObject.finishedDateString = [self.finishedDateString copy];
    copyObject.creatorID = [self.creatorID copy];
    copyObject.replyCount = self.replyCount;
    copyObject.unreadCount = self.unreadCount;
    copyObject.subTaskCount = self.subTaskCount;
    copyObject.charger = [self.charger copy];
    copyObject.project = [self.project copy];
    copyObject.members = [self.members copy];
    copyObject.colorType = self.colorType;
    if (self.subTasks.count > 0) {
        copyObject.subTasks = [self.subTasks copy];
    }
    return copyObject;
}
@end
