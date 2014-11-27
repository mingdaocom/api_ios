//
//  MDTaskFolderStage.m
//  MingdaoV2
//
//  Created by Wee Tom on 14/11/26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDTaskFolderStage.h"

@implementation MDTaskFolderStage
- (MDTaskFolderStage *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.objectID = dic[@"stageID"];
        self.objectName = dic[@"stageName"];
        self.number = [dic[@"stageNo"] intValue];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        MDTaskFolderStage *stage = object;
        return [stage.objectID isEqualToString:self.objectID];
    }
    return NO;
}

- (id)copy
{
    MDTaskFolderStage *stage = [[MDTaskFolderStage alloc] init];
    stage.objectID = [self.objectID copy];
    stage.objectName = [self.objectName copy];
    stage.number = self.number;
    return stage;
}
@end
