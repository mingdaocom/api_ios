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
        if ([self.objectID isEqualToString:aGroup.objectID]) {
            return YES;
        }
    }
    
    return NO;
}
@end
