//
//  MDGroup.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDGroup.h"

@implementation MDGroup
- (MDGroup *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.objectName = [aDic objectForKey:@"name"];
        self.avatar = [aDic objectForKey:@"avstar"];
        self.isPublic = [[aDic objectForKey:@"is_public"] boolValue];
        self.status = [[aDic objectForKey:@"status"] integerValue];
        self.isJoined = [[aDic objectForKey:@"followed_status"] boolValue];
        self.userCount = [[aDic objectForKey:@"user_count"] integerValue];
        self.postCount = [[aDic objectForKey:@"post_count"] integerValue];
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        self.admins = [aDic objectForKey:@"admins"];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        MDGroup *aGroup = (MDGroup *)object;
        if ([[self.objectID lowercaseString] isEqualToString:[aGroup.objectID lowercaseString]]) {
            return YES;
        }
    }
    
    return NO;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDGroup *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    copyObject.avatar = [self.avatar copy];
    copyObject.isPublic = self.isPublic;
    copyObject.status = self.status;
    copyObject.isJoined = self.isJoined;
    copyObject.userCount = self.userCount;
    copyObject.postCount = self.postCount;
    copyObject.creator = [self.creator copy];
    copyObject.admins = [self.admins copy];
    return copyObject;
}
@end
