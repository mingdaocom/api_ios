//
//  MDUser.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDUser.h"

@implementation MDUser
- (MDUser *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.objectName = [aDic objectForKey:@"name"];
        self.avatar = [aDic objectForKey:@"avstar"];
        self.avatar100 = [aDic objectForKey:@"avstar100"];
        self.email = [aDic objectForKey:@"email"];
        self.grade = [aDic objectForKey:@"grade"];
        self.mark = [aDic objectForKey:@"mark"];
        self.birth = [aDic objectForKey:@"birth"];
        self.gender = [[aDic objectForKey:@"gender"] integerValue];
        self.company = [aDic objectForKey:@"company"];
        self.department = [aDic objectForKey:@"department"];
        self.job = [aDic objectForKey:@"job"];
        self.mobilePhoneNumber = [aDic objectForKey:@"mobile_phone"];
        self.workPhoneNumber = [aDic objectForKey:@"work_phone"];
        self.isFollowed = [[aDic objectForKey:@"followed_status"] boolValue];
        self.licence = [[aDic objectForKey:@"license"] integerValue];
        self.status = [[aDic objectForKey:@"status"] integerValue];
        self.jobs = [aDic objectForKey:@"jobs"];
        self.educations = [aDic objectForKey:@"educations"];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        MDUser *aUser = (MDUser *)object;
        if ([self.objectID isEqualToString:aUser.objectID]) {
            return YES;
        }
    }
    
    return NO;
}
@end
