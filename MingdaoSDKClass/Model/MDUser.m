//
//  MDUser.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDUser.h"
#import "MDOrgnization.h"

@implementation MDUser
- (MDUser *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.user_id = aDic[@"user_id"];
        self.full_name = aDic[@"full_name"];
        self.account_id = aDic[@"account_id"];
        self.project_id = aDic[@"project_id"];
        self.avatar = aDic[@"avatar"];
        self.email = aDic[@"email"];
        self.grade = aDic[@"grade"];
        self.mark = aDic[@"mark"];
        self.birth = aDic[@"birth"];
        self.company = aDic[@"company"];
        self.department = aDic[@"department"];
        self.job = aDic[@"job"];
        self.city = aDic[@"city"];
        self.job_number = aDic[@"job_number"];
        self.workSite = aDic[@"work_site"];
        self.mobile_phone = aDic[@"mobile_phone"];
        self.work_phone = aDic[@"work_phone"];
        self.create_time = aDic[@"create_time"];
        self.egroup = [aDic[@"egroup"] boolValue];
        self.license = [aDic[@"license"] intValue];
        self.status = [aDic[@"status"] intValue];
        self.unit_name = aDic[@"unit_name"];
        self.jobs = [aDic objectForKey:@"jobs"];
        self.educations = [aDic objectForKey:@"educations"];
    }
    return self;
}
@end
