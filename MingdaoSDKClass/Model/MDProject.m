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
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDProject *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    return copyObject;
}
@end
