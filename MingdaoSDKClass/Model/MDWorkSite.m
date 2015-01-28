//
//  MDWorkSite.m
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDWorkSite.h"

@implementation MDWorkSite

- (MDWorkSite *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = aDic[@"id"];
        self.objectName = aDic[@"name"];
        self.userCount = [aDic[@"userCount"] integerValue];
    }
    return self;
}


- (id)copy
{
    id object = [[[self class] alloc] init];
    MDWorkSite *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    copyObject.userCount = self.userCount;
    return copyObject;
}

@end
