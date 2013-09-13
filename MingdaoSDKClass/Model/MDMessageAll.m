//
//  MDMessage.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDMessageAll.h"

@implementation MDMessageAll
- (MDMessageAll *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        self.text = [aDic objectForKey:@"text"];
        self.createTime = [aDic objectForKey:@"create_time"];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDMessageAll *copyObject = object;
    copyObject.creator = [self.creator copy];
    copyObject.text = [self.text copy];
    copyObject.createTime = [self.createTime copy];
    return copyObject;
}
@end
