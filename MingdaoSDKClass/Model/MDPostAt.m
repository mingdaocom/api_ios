//
//  MDPostAt.m
//  MingdaoV2
//
//  Created by Wee Tom on 13-10-18.
//  Copyright (c) 2013年 Mingdao. All rights reserved.
//

#import "MDPostAt.h"

@implementation MDPostAt

- (MDPost *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super initWithDictionary:aDic];
    if (self) {
        self.mentionedInPost = [[aDic objectForKey:@"mectioned_post"] boolValue];
        
        NSMutableArray *replyments = [NSMutableArray array];
        NSArray *replymentDics = [aDic objectForKey:@"replyments"];
        for (NSDictionary *replymentDic in replymentDics) {
            MDPostReplyment *replyment = [[MDPostReplyment alloc] initWithDictionary:replymentDic];
            [replyments addObject:replyment];
        }
        self.replyments = replyments;
    }
    return self;
}

@end
