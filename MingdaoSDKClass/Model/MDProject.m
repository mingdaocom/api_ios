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
        
        self.deadLine = [aDic objectForKey:@"deadline"];
        self.completedDate = [aDic objectForKey:@"completeDate"];
        
        self.taskInProgressCount = [[aDic objectForKey:@"inprogressCount"] intValue];
        self.taskCompletedCount = [[aDic objectForKey:@"completedCount"] intValue];
        
        self.projectColor = [[aDic objectForKey:@"projectColor"] intValue];
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
    MDProject *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    
    copyObject.deadLine = [self.deadLine copy];
    copyObject.completedDate = [self.completedDate copy];
    copyObject.taskCompletedCount = self.taskCompletedCount;
    copyObject.taskInProgressCount = self.taskInProgressCount;
    
    copyObject.projectColor = self.projectColor;
    
    return copyObject;
}
@end
