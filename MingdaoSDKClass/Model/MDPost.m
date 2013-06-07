//
//  MDPost.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDPost.h"

@implementation MDPost
- (MDPost *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"guid"];
        self.autoID = [aDic objectForKey:@"id"];
        self.text = [aDic objectForKey:@"text"];
        NSArray *tagDics = [aDic objectForKey:@"tags"];
        NSMutableArray *tags = [NSMutableArray array];
        for (NSDictionary *tagDic in tagDics) {
            if ([tagDic isKindOfClass:[NSDictionary class]]) {
                MDTag *tag = [[MDTag alloc] initWithDictionary:tagDic];
                [tags addObject:tag];
            }
        }
        self.tags = tags;
        self.createTime = [aDic objectForKey:@"create_time"];
        self.source = [aDic objectForKey:@"source"];
        self.replyCount = [[aDic objectForKey:@"reply_count"] integerValue];
        self.likeCount = [[aDic objectForKey:@"like_count"] integerValue];
        self.isFavourited = [[aDic objectForKey:@"favorite"] boolValue];
        self.isLiked = [[aDic objectForKey:@"like"] boolValue];
        self.type = [[aDic objectForKey:@"type"] integerValue];
        self.shareType = [[aDic objectForKey:@"share_type"] integerValue];
        self.details = [aDic objectForKey:@"detail"];
        self.textAttribute = [aDic objectForKey:@"text_attribute"];
        NSMutableArray *groups = [NSMutableArray array];
        NSArray *groupDics = [aDic objectForKey:@"groups"];
        for (NSDictionary *groupDic in groupDics) {
            if ([groupDics isKindOfClass:[NSDictionary class]]) {
                MDGroup *group = [[MDGroup alloc] initWithDictionary:groupDic];
                [groups addObject:group];
            }
        }
        self.groups = groups;
        
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        
        NSDictionary *repostDic = [aDic objectForKey:@"repost"];
        if (repostDic) {
            self.repost = [[MDPost alloc] initWithDictionary:repostDic];
        }
    }
    return self;
}
@end
