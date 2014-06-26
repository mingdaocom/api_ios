//
//  MDProject.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-5.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDProject.h"

@implementation MDProject
- (MDProject *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"guid"];
        self.objectName = [aDic objectForKey:@"title"];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDProject *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    
    return copyObject;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MDProject class]]) {
        MDProject *project = (MDProject *)object;
        return [self.objectID isEqualToString:project.objectID];
    }
    return NO;
}
@end

@implementation MDTaskFolder
- (MDTaskFolder *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.objectName = [aDic objectForKey:@"name"];
        
        self.createDateString = [aDic objectForKey:@"create_time"];
        self.deadLine = [aDic objectForKey:@"deadline"];
        
        self.unreadDiscussCount = [[aDic objectForKey:@"not_count"] intValue];
        self.taskInProgressCount = [[aDic objectForKey:@"un_completedCount"] intValue];
        self.taskCompletedCount = [[aDic objectForKey:@"completed_count"] intValue];
        
        self.colorType = [[aDic objectForKey:@"color"] intValue];
        
        self.creatorID = [aDic objectForKey:@"create_user"];
        MDUser *user = [[MDUser alloc] init];
        user.objectID = [aDic objectForKey:@"charge_user"];
        user.avatar = [aDic objectForKey:@"charge_avatar"];
        self.charger = user;
    }
    return self;
}

- (BOOL)isCompleted
{
    return self.taskInProgressCount == self.taskCompletedCount;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTaskFolder *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    
    copyObject.deadLine = [self.deadLine copy];
    copyObject.taskCompletedCount = self.taskCompletedCount;
    copyObject.taskInProgressCount = self.taskInProgressCount;
    
    copyObject.colorType = self.colorType;
    
    return copyObject;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MDTaskFolder class]]) {
        MDTaskFolder *folder = (MDTaskFolder *)object;
        return [self.objectID isEqualToString:folder.objectID];
    }
    return NO;
}
@end