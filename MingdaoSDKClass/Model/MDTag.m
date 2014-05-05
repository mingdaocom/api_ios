//
//  MDTag.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-7.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDTag.h"

@implementation MDTag
- (MDTag *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.objectID = [dic objectForKey:@"guid"];
        if (!self.objectID) {
            self.objectID = [dic objectForKey:@"id"];
        }
        self.objectName = [dic objectForKey:@"name"];
        NSDictionary *countDic = [dic objectForKey:@"count"];
        if ([countDic isKindOfClass:[NSDictionary class]]) {
            self.postCount = [[countDic objectForKey:@"post"] intValue];
            self.imageCount = [[countDic objectForKey:@"img"] intValue];
            self.documentCount = [[countDic objectForKey:@"doc"] intValue];
            self.faqCount = [[countDic objectForKey:@"faq"] intValue];
            self.voteCount = [[countDic objectForKey:@"vote"] intValue];
        }
        self.totalPageSize = [[dic objectForKey:@"totalPageSize"] intValue];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTag *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    copyObject.postCount = self.postCount;
    copyObject.imageCount = self.imageCount;
    copyObject.documentCount = self.documentCount;
    copyObject.faqCount = self.faqCount;
    copyObject.voteCount = self.voteCount;
    copyObject.totalPageSize = self.totalPageSize;
    return copyObject;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MDTag class]]) {
        MDTag *aTag = object;
        return [aTag.objectName isEqualToString:self.objectName];
    }
    return NO;
}
@end
