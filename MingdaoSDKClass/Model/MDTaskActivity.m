//
//  MDTaskActivity.m
//  MingdaoV2
//
//  Created by yyp on 15/6/19.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDTaskActivity.h"

@implementation MDTaskActivity

- (MDTaskActivity *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.userID = aDic[@"userid"];
        self.userName = aDic[@"name"];
        self.avatar = aDic[@"avatar"];
        self.actType = [aDic[@"actType"] integerValue];
        self.msg = aDic[@"msg"];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTaskActivity *copyObject = object;
    copyObject.userID = [self.userID copy];
    copyObject.userName = [self.userName copy];
    copyObject.avatar = [self.avatar copy];
    copyObject.actType = self.actType;
    copyObject.msg = self.msg;
    return copyObject;
}



@end
