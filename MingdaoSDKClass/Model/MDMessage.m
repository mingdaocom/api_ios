//
//  MDMessage.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDMessage.h"

@implementation MDMessage
- (MDMessage *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.text = [aDic objectForKey:@"text"];
        self.iHaveRead = [[aDic objectForKey:@"status"] boolValue];
        self.heHasRead = [[aDic objectForKey:@"status2"] boolValue];
        self.createTime = [aDic objectForKey:@"create_time"];
        self.createUserID = [aDic objectForKey:@"create_user"];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDMessage *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.text = [self.text copy];
    copyObject.iHaveRead = self.iHaveRead;
    copyObject.heHasRead = self.heHasRead;
    copyObject.createTime = [self.createTime copy];
    copyObject.createUserID = [self.createUserID copy];
    return copyObject;
}
@end
