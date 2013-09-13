//
//  MDTaskReplyment.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDTaskReplyment.h"

@implementation MDTaskReplyment
- (MDTaskReplyment *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.autoID = [aDic objectForKey:@"autoid"];
        self.objectID = [aDic objectForKey:@"guid"];
        self.text = [aDic objectForKey:@"text"];
        self.createDateString = [aDic objectForKey:@"create_time"];
        self.type = [[aDic objectForKey:@"type"] integerValue];
        NSDictionary *detailDic = [aDic objectForKey:@"detail"];
        if ([detailDic isKindOfClass:[detailDic class]]) {
            self.original_file = [detailDic objectForKey:@"original_file"];
            self.original_pic = [detailDic objectForKey:@"original_pic"];
            self.thumbnail_pic = [detailDic objectForKey:@"thumbnail_pic"];
        }
        self.source = [aDic objectForKey:@"source"];
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        NSDictionary *replyToDic = [aDic objectForKey:@"ref"];
        if ([replyToDic isKindOfClass:[NSDictionary class]] && replyToDic.allKeys.count > 0) {
            self.replyTo = [[MDUser alloc] initWithDictionary:[replyToDic objectForKey:@"user"]];
        }
    }
    return self;
}

- (NSString *)fileName
{
    NSArray *array = [self.original_file componentsSeparatedByString:@"/"];
    return [array lastObject];
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTaskReplyment *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.autoID = [self.autoID copy];
    copyObject.text = [self.text copy];
    copyObject.createDateString = [self.createDateString copy];
    copyObject.type = self.type;
    copyObject.original_file = [self.original_file copy];
    copyObject.original_pic = [self.original_pic copy];
    copyObject.thumbnail_pic = [self.thumbnail_pic copy];
    copyObject.source = [self.source copy];
    copyObject.creator = [self.creator copy];
    if (self.replyTo) {
        copyObject.replyTo = [self.replyTo copy];
    }
    return copyObject;
}
@end
