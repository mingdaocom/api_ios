//
//  MDProject.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDCompany.h"

@implementation MDCompany
- (MDCompany *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.objectName = [aDic objectForKey:@"name"];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDCompany *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    return copyObject;
}
@end
