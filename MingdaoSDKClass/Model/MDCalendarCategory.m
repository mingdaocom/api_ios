//
//  MDCalendarCategory.m
//  MingdaoV2
//
//  Created by yyp on 14/12/11.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDCalendarCategory.h"

@implementation MDCalendarCategory

- (MDCalendarCategory *)initWithDictionary:(NSDictionary *)aDic
{
    if (!aDic || ![aDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.catID = aDic[@"catID"];
        self.catName = aDic[@"catName"];
        self.displayOrder = [aDic[@"displayOrder"] intValue];
        self.color = [aDic[@"color"] intValue];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDCalendarCategory *copyObject = object;
    copyObject.catID = [self.catID copy];
    copyObject.catName = [self.catName copy];
    copyObject.displayOrder = self.displayOrder;
    copyObject.color = self.color;
    return copyObject;
}


@end
