//
//  MDProject.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDOrgnization.h"

@implementation MDOrgnization
- (MDOrgnization *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.objectName = [aDic objectForKey:@"name"];
        self.nameEn = [aDic objectForKey:@"nameEn"];
        self.logo = [aDic objectForKey:@"logo"];
        self.type = [[aDic objectForKey:@"license_type"] intValue];
        self.expireDays = [aDic objectForKey:@"expireDays"];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDOrgnization *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    copyObject.nameEn = [self.nameEn copy];
    copyObject.logo = [self.logo copy];
    copyObject.type = self.type;
    copyObject.expireDays = [self.expireDays copy];
    return copyObject;
}
@end
