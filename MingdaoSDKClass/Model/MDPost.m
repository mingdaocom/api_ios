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
        self.voteCount = [[dic objectForKey:@"value"] intValue];
        self.selected = [[dic objectForKey:@"selected"] boolValue];
        self.originalPic = [dic objectForKey:@"original_pic"];
        self.thumbnailPic = [dic objectForKey:@"thumbnail_pic"];
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

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDVoteOption *copyObject = object;
    copyObject.objectName = [self.objectName copy];
    copyObject.voteCount = self.voteCount;
    copyObject.selected = self.selected;
    copyObject.originalPic = [self.originalPic copy];
    copyObject.thumbnailPic = [self.thumbnailPic copy];
    copyObject.members = [self.members copy];
    return copyObject;
}
@end

@implementation MDPostDetail
- (MDPostDetail *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.isAnonymous = [[dic objectForKey:@"Anonymous"] boolValue];
        self.maxChoiceCount = [[dic objectForKey:@"AvailableNumber"] intValue];
        self.deadLineString = [dic objectForKey:@"Deadline"];
        self.isInCenter = [[dic objectForKey:@"is_center"] boolValue];
        self.linkDes = [dic objectForKey:@"link_des"];
        self.linkTitle = [dic objectForKey:@"link_title"];
        self.linkURL = [dic objectForKey:@"link_url"];
        
        self.thumbnailPic = [dic objectForKey:@"thumbnail_pic"];
        self.middlePic = [dic objectForKey:@"middle_pic"];
        self.originalPic = [dic objectForKey:@"original_pic"];
        if (self.middlePic && [self.middlePic hasSuffix:@"gif"]) {
            self.middlePic = self.thumbnailPic;
        }
        
        self.originalDoc = [dic objectForKey:@"original_file"];
        self.fileName = [dic objectForKey:@"original_filename"];
        
        self.videoUrl = [dic objectForKey:@"video_url"];
        
        self.isVisble = [[dic objectForKey:@"Visble"] boolValue];
        self.isDownloadable = [[dic objectForKey:@"allow_down"] boolValue];
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

- (BOOL)voted
{
    for (MDVoteOption *o in self.voteOptions) {
        if (o.selected) {
            return YES;
        }
    }
    return NO;
}

- (int)totalVoteCount
{
    int totalVoteCount = 0;
    for (MDVoteOption *o in self.voteOptions) {
        totalVoteCount += o.voteCount;
    }
    return totalVoteCount;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDPostDetail *copyObject = object;
    copyObject.isAnonymous = self.isAnonymous;
    copyObject.maxChoiceCount = self.maxChoiceCount;
    copyObject.deadLineString = [self.deadLineString copy];
    copyObject.isInCenter = self.isInCenter;
    copyObject.linkDes = [self.linkDes copy];
    copyObject.linkTitle = [self.linkTitle copy];
    copyObject.middlePic = [self.middlePic copy];
    copyObject.originalPic = [self.originalPic copy];
    copyObject.originalDoc = [self.originalDoc copy];
    copyObject.thumbnailPic = [self.thumbnailPic copy];
    copyObject.fileName = [self.fileName copy];
    copyObject.isVisble = self.isVisble;
    copyObject.isDownloadable = self.isDownloadable;
    NSMutableArray *voteOptions = [NSMutableArray array];
    for (MDVoteOption *d in self.voteOptions) {
        MDVoteOption *dd = [d copy];
        [voteOptions addObject:dd];
    }
    copyObject.voteOptions = voteOptions;
    return copyObject;
}
@end

@implementation MDPost
- (MDPost *)initWithDictionary:(NSDictionary *)aDic
{
    if (aDic.allKeys.count == 0) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"guid"];
        self.autoID = [aDic objectForKey:@"id"];
        self.text = [aDic objectForKey:@"text"];
        if (!self.text)
            self.text = @"";
        
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
        self.replyCount = [[aDic objectForKey:@"reply_count"] intValue];
        self.likeCount = [[aDic objectForKey:@"like_count"] intValue];
        self.repostCount = [[aDic objectForKey:@"reshared_count"] intValue];
        self.isFavourited = [[aDic objectForKey:@"favorite"] boolValue];
        self.isLiked = [[aDic objectForKey:@"like"] boolValue];
        self.type = [[aDic objectForKey:@"type"] intValue];
        self.shareType = [[aDic objectForKey:@"share_type"] intValue];
        self.details = [aDic objectForKey:@"detail"];
        self.textAttribute = [aDic objectForKey:@"text_attribute"];
        self.isAnswerred = [[aDic objectForKey:@"have_bestanswer"] boolValue];
        self.mark = [[aDic objectForKey:@"mark"] intValue];
        NSMutableArray *groups = [NSMutableArray array];
        NSArray *groupDics = [aDic objectForKey:@"groups"];
        for (NSDictionary *groupDic in groupDics) {
            if ([groupDic isKindOfClass:[NSDictionary class]]) {
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

- (MDPostDetail *)firstDetail
{
    if (self.details.count > 0) {
        return [self.details objectAtIndex:0];
    }
    return nil;
}

- (BOOL)isEqual:(id)object
{
    MDPost *aPost = object;
    if ([aPost isKindOfClass:[MDPost class]]) {
        if (self.autoID.length != 0 && aPost.autoID.length != 0 && [aPost.autoID isEqualToString:self.autoID]) {
            return YES;
        }
        if (self.objectID.length != 0 && aPost.objectID.length != 0 && [aPost.objectID isEqualToString:self.objectID]) {
            return YES;
        }
    }
    return NO;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDPost *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.autoID = [self.autoID copy];
    copyObject.text = [self.text copy];
    copyObject.tags = [self.tags copy];
    copyObject.createTime = [self.createTime copy];
    copyObject.creator = [self.creator copy];
    copyObject.source = [self.source copy];
    copyObject.replyCount = self.replyCount;
    copyObject.likeCount = self.likeCount;
    copyObject.repostCount = self.repostCount;
    copyObject.isFavourited = self.isFavourited;
    copyObject.type = self.type;
    copyObject.shareType = self.shareType;
    NSMutableArray *details = [NSMutableArray array];
    for (MDPostDetail *d in self.details) {
        MDPostDetail *dd = [d copy];
        [details addObject:dd];
    }
    copyObject.details = details;
    copyObject.textAttribute = [self.textAttribute copy];
    copyObject.groups = [self.groups copy];
    copyObject.isAnswerred = self.isAnswerred;
    copyObject.mark = self.mark;
    if (self.repost) {
        copyObject.repost = [self.repost copy];
    }
    return copyObject;
}

@end
