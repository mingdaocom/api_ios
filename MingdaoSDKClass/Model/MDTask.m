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
        self.objectID = [aDic objectForKey:@"id"];
        self.objectName = [aDic objectForKey:@"title"];
        self.des = [aDic objectForKey:@"des"];
        
        self.createdDateString = [aDic objectForKey:@"create_time"];
        self.expiredDateString = [aDic objectForKey:@"expire_date"];
        self.finishedDateString = [aDic objectForKey:@"finished_date"];
        
        self.charger = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"charge_user"]];
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"create_user"]];
        
        self.subTaskCount = [[aDic objectForKey:@"sub_count"] intValue];
        
        self.replyCount = [[aDic objectForKey:@"reply_count"] intValue];
        self.unreadDiscussCount = [[aDic objectForKey:@"unread_count"] intValue];
        
        self.colorType = [[aDic objectForKey:@"color"] intValue];
        
        self.isLocked = [[aDic objectForKey:@"is_lock"] boolValue];
        self.isNoticed = [[aDic objectForKey:@"is_notice"] boolValue];
        self.isContainMe = [[aDic objectForKey:@"isContainMe"] boolValue];
        
        self.currentUserType = [[aDic objectForKey:@"currentUserType"] intValue] + 1;
        
        if ([[aDic objectForKey:@"parent_task"] isKindOfClass:[NSDictionary class]]) {
            self.parentTask = [[MDTask alloc] initWithDictionary:[aDic objectForKey:@"parent_task"]];
        }
        
        if ([[aDic objectForKey:@"folder"] isKindOfClass:[NSDictionary class]]) {
            self.folder = [[MDTaskFolder alloc] initWithDictionary:[aDic objectForKey:@"folder"]];
        }
        
        NSMutableArray *memebers = [NSMutableArray array];
        NSDictionary *userDics = [aDic objectForKey:@"members"];
        for (NSDictionary *userDic in userDics) {
            if ([userDic isKindOfClass:[NSDictionary class]]) {
                MDUser *aUser = [[MDUser alloc] initWithDictionary:userDic];
                if ([aUser isEqual:self.charger]) {
                    continue;
                }
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
    
    copyObject.replyCount = self.replyCount;
    copyObject.unreadDiscussCount = self.unreadDiscussCount;
    copyObject.subTaskCount = self.subTaskCount;

    copyObject.creator = [self.creator copy];
    copyObject.charger = [self.charger copy];

    copyObject.folder = [self.folder copy];
    
    copyObject.members = [self.members copy];
    
    copyObject.colorType = self.colorType;
    
    if (self.subTasks.count > 0) {
        copyObject.subTasks = [self.subTasks copy];
    }
    return copyObject;
}
@end
