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
        self.middlePic = aDic[@"middle_pic"];
        self.originalPic = aDic[@"original_pic"];
        self.originalDoc = aDic[@"original_file"];
        self.thumbnailPic = aDic[@"thumbnail_pic"];
        self.fileName = aDic[@"original_filename"];
        self.isDownloadAble = [aDic[@"allow_down"] boolValue];
        self.fileType = [aDic[@"file_type"] intValue];
        self.fileSize = [aDic[@"filesize"] unsignedLongLongValue];
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
    copyObject.fileType = self.fileType;
    copyObject.replyID = [self.replyID copy];
    copyObject.fileSize = self.fileSize;
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
        NSMutableArray *images = nil;
        NSMutableArray *files = nil;
        for (NSDictionary *detailDic in detailDics) {
            MDPostReplymentDetail *detail = [[MDPostReplymentDetail alloc] initWithDictionary:detailDic];
            detail.replyID = self.objectID;
            if (detail.fileType == MDAttachmentFileTypeImage) {
                if (!images) {
                    images = [NSMutableArray array];
                }
                [images addObject:detail];
            }
            if (detail.fileType == MDAttachmentFileTypeFile ||
                detail.fileType == MDAttachmentFileTypeZip) {
                if (!files) {
                    files = [NSMutableArray array];
                }
                [files addObject:detail];
            }
        }
        self.images = images;
        self.files = files;
        
        if (self.images.count > 0) {
            self.type = MDPostReplymentTypeImage;
        } else if (self.files.count > 0) {
            self.type = MDPostReplymentTypeDocument;
        } else {
            self.type = MDPostReplymentTypeText;
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
    copyObject.source = [self.source copy];
    copyObject.images = [self.images copy];
    copyObject.files = [self.files copy];
    return copyObject;
}
@end
