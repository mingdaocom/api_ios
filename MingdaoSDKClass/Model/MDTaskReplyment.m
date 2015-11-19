//
//  MDTaskReplyment.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDTaskReplyment.h"
#import "MDTask.h"

@implementation MDTaskReplymentDetail
- (MDTaskReplymentDetail *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.file_type = [aDic[@"file_type"] intValue];
        self.thumbnail_pic = aDic[@"thumbnail_pic"];
        self.middle_pic = aDic[@"middle_pic"];
        self.original_pic = aDic[@"original_pic"];
        
        self.original_filename = aDic[@"original_filename"];
        self.original_file = aDic[@"original_file"];
        self.allow_down = [aDic[@"allow_down"] boolValue];
        
        self.fileSize = [aDic[@"filesize"] unsignedLongLongValue];
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDTaskReplymentDetail *copyObject = object;
    copyObject.file_type = self.file_type;
    copyObject.thumbnail_pic = [self.thumbnail_pic copy];
    copyObject.middle_pic = [self.middle_pic copy];
    copyObject.original_pic = [self.original_pic copy];
    copyObject.original_file = [self.original_file copy];
    copyObject.original_filename = [self.original_filename copy];
    copyObject.allow_down = self.allow_down;
    copyObject.replyID = [self.replyID copy];
    copyObject.fileSize = self.fileSize;
    return copyObject;
}
@end

@implementation MDTaskReplyment
- (MDTaskReplyment *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.autoID = [aDic objectForKey:@"autoid"];
        self.objectID = [aDic objectForKey:@"guid"];
        self.text = [aDic objectForKey:@"text"];
        self.createDateString = [aDic objectForKey:@"create_time"];
        self.type = [[aDic objectForKey:@"type"] intValue];
        self.fileType = [[aDic objectForKey:@"file_type"] intValue];
        self.source = [aDic objectForKey:@"source"];
        self.creator = [[MDUser alloc] initWithDictionary:[aDic objectForKey:@"user"]];
        NSDictionary *replyToDic = [aDic objectForKey:@"ref"];
        if ([replyToDic isKindOfClass:[NSDictionary class]] && replyToDic.allKeys.count > 0) {
            self.replyTo = [[MDUser alloc] initWithDictionary:[replyToDic objectForKey:@"user"]];
        }
        
        NSArray *detailDics = aDic[@"details"];
        NSMutableArray *images = nil;
        NSMutableArray *files = nil;
        for (NSDictionary *dd in detailDics) {
            MDTaskReplymentDetail *detail = [[MDTaskReplymentDetail alloc] initWithDictionary:dd];
            detail.replyID = self.objectID;
            if (detail.file_type == MDAttachmentFileTypeImage) {
                if (!images) {
                    images = [NSMutableArray array];
                }
                [images addObject:detail];
            }
            if (detail.file_type == MDAttachmentFileTypeZip ||
                detail.file_type == MDAttachmentFileTypeFile) {
                if (!files) {
                    files = [NSMutableArray array];
                }
                [files addObject:detail];
            }
        }
        self.images = images;
        self.files = files;
    }
    return self;
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
    copyObject.images = self.images;
    copyObject.files = self.files;
    copyObject.source = [self.source copy];
    copyObject.creator = [self.creator copy];
    copyObject.fileType = self.fileType;
    if (self.replyTo) {
        copyObject.replyTo = [self.replyTo copy];
    }
    return copyObject;
}
@end
