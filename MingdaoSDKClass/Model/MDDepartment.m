//
//  MDDepartment.m
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDDepartment.h"

@implementation MDDepartment

- (MDDepartment *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [NSString stringWithFormat:@"%@",aDic[@"departmentID"]];
        self.objectName = aDic[@"departmentName"];
        self.membersCount = [aDic[@"userCount"] integerValue];
        self.mappingGroupName = aDic[@"groupName"];
        self.mappingGroupID = aDic[@"mappingGroupID"];
        self.comment = aDic[@"comment"];
        self.allCount = [aDic[@"allCount"] integerValue];
    }
    return self;
}


- (id)copy
{
    id object = [[[self class] alloc] init];
    MDDepartment *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    copyObject.membersCount = self.membersCount;
    copyObject.mappingGroupName = [self.mappingGroupName copy];
    copyObject.mappingGroupID = [self.mappingGroupID copy];
    copyObject.comment = [self.comment copy];
    copyObject.allCount = self.allCount;
    return copyObject;
}


@end
