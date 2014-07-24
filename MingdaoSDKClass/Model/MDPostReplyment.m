//
//  MDPostReplyment.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDPostReplyment.h"
#import "MDPost.h"

@implementation MDPostReplymentDetail
- (MDPostReplymentDetail *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.middlePic = [aDic objectForKey:@"middle_pic"];
        self.originalPic = [aDic objectForKey:@"original_pic"];
        self.originalDoc = [aDic objectForKey:@"original_file"];
        self.thumbnailPic = [aDic objectForKey:@"thumbnail_pic"];
        self.fileName = [aDic objectForKey:@"original_filename"];
        self.isDownloadAble = [[aDic objectForKey:@"allow_down"] boolValue];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDPostReplymentDetail *copyObject = object;
    copyObject.middlePic = [self.middlePic copy];
    copyObject.originalPic = [self.originalPic copy];
    copyObject.originalDoc = [self.originalDoc copy];
    copyObject.thumbnailPic = [self.thumbnailPic copy];
    copyObject.fileName = [self.fileName copy];
    copyObject.isDownloadAble = self.isDownloadAble;
    return copyObject;
}
@end

@implementation MDPostReplyment
- (MDPostReplyment *)initWithDictionary:(NSDictionary *)aDic
{
    if (aDic.allKeys.count == 0) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"guid"];
        self.text = [aDic objectForKey:@"text"];
        self.createTime = [aDic objectForKey:@"create_time"];
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        NSDictionary *replyToDic = [aDic objectForKey:@"ref"];
        if (replyToDic && replyToDic.allKeys.count > 0) {
            self.replymentToReplyment = [[MDPostReplyment alloc] initWithDictionary:[replyToDic objectForKey:@"replyment"]];
            self.replymentToPost = [[MDPost alloc] initWithDictionary:[replyToDic objectForKey:@"post"]];
        }

        NSArray *detailDics = [aDic objectForKey:@"details"];
        NSMutableArray *details = [NSMutableArray arrayWithCapacity:detailDics.count];
        for (NSDictionary *detailDic in detailDics) {
            MDPostReplymentDetail *detail = [[MDPostReplymentDetail alloc] initWithDictionary:detailDic];
            [details addObject:detail];
        }
        self.details = details;
        if (self.details.count == 0) {
            self.type = MDPostReplymentTypeText;
        } else if (self.details.count > 1) {
            self.type = MDPostReplymentTypeImage;
        } else {
            MDPostReplymentDetail *detail = [self.details objectAtIndex:0];
            if (detail.originalDoc) {
                self.type = MDPostReplymentTypeDocument;
            } else {
                self.type = MDPostReplymentTypeImage;
            }
        }
        self.source = [aDic objectForKey:@"source"];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDPostReplyment*copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.text = [self.text copy];
    copyObject.createTime = [self.createTime copy];
    copyObject.creator = [self.creator copy];
    if (self.replymentToPost) {
        copyObject.replymentToPost = [self.replymentToPost copy];
    }
    
    if (self.replymentToReplyment) {
        copyObject.replymentToReplyment = [self.replymentToReplyment copy];
    }
    copyObject.details = [self.details copy];
    copyObject.source = [self.source copy];
    return copyObject;
}
@end
