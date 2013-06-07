//
//  MDPost.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDPost.h"

@implementation MDVoteOption
- (MDVoteOption *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.objectName = [dic objectForKey:@"name"];
        self.voteCount = [[dic objectForKey:@"value"] integerValue];
        NSMutableArray *members = [NSMutableArray array];
        NSArray *memberDics = [dic objectForKey:@"members"];
        for (NSDictionary *memberDic in memberDics) {
            if ([memberDic isKindOfClass:[NSDictionary class]]) {
                MDUser *member = [[MDUser alloc] initWithDictionary:memberDic];
                [members addObject:member];
            }
        }
        self.members = members;
    }
    return self;
}
@end

@implementation MDPostDetail
- (MDPostDetail *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.isAnonymous = ![[dic objectForKey:@"Anonymous"] boolValue];
        self.maxChoiceCount = [[dic objectForKey:@"AvailableNumber"] integerValue];
        self.deadLineString = [dic objectForKey:@"Deadline"];
        self.isInCenter = [[dic objectForKey:@"is_center"] boolValue];
        self.linkDes = [dic objectForKey:@"link_des"];
        self.linkTitle = [dic objectForKey:@"link_title"];
        self.linkURL = [dic objectForKey:@"link_url"];
        self.middlePic = [dic objectForKey:@"middle_pic"];
        self.originalPic = [dic objectForKey:@"original_pic"];
        self.originalDoc = [dic objectForKey:@"original_file"];
        self.thumbnailPic = [dic objectForKey:@"thumbnail_pic"];
        self.isVisble = [[dic objectForKey:@"Visble"] boolValue];
        NSArray *voteOptionDics = [dic objectForKey:@"options"];
        if (voteOptionDics && voteOptionDics.count > 0) {
            NSMutableArray *options = [NSMutableArray array];
            for (NSDictionary *voteOptionDic in voteOptionDics) {
                if ([voteOptionDic isKindOfClass:[NSDictionary class]]) {
                    MDVoteOption *option = [[MDVoteOption alloc] initWithDictionary:voteOptionDic];
                    [options addObject:option];
                }
            }
            self.voteOptions = options;
        }
    }
    return self;
}
@end

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
        
        NSArray *detailDics = [aDic objectForKey:@"details"];
        if (detailDics && detailDics.count > 0) {
            NSMutableArray *details = [NSMutableArray array];
            for (NSDictionary *detailDic in detailDics) {
                if ([detailDic isKindOfClass:[NSDictionary class]]) {
                    MDPostDetail *detail = [[MDPostDetail alloc] initWithDictionary:detailDic];
                    [details addObject:detail];
                }
            }
            self.details = details;
        }
    }
    return self;
}
@end
