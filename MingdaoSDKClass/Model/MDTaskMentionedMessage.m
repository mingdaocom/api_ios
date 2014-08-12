//
//  MDTaskMentionedMessage.m
//  MingdaoV2
//
//  Created by WeeTom on 14-7-10.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDTaskMentionedMessage.h"

@implementation MDTaskMentionedMessage
- (MDTaskMentionedMessage *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"topicID"];
        self.text = [aDic objectForKey:@"msg"];
        self.createTime = [aDic objectForKey:@"create_time"];
        self.replyID = [aDic objectForKey:@"replyID"];
        self.isFavourite = [[aDic objectForKey:@"is_favorite"] intValue];
        
        NSDictionary *creatorDic = [aDic objectForKey:@"create_user"];
        if ([creatorDic isKindOfClass:[NSDictionary class]]) {
            self.createUser = [[MDUser alloc] initWithDictionary:creatorDic];
        }
        
        NSDictionary *replierDic = [aDic objectForKey:@"reply_user"];
        if ([replierDic isKindOfClass:[NSDictionary class]]) {
            self.replyUser = [[MDUser alloc] initWithDictionary:replierDic];
        }
        
        MDTask *task = [[MDTask alloc] init];
        task.objectID = [aDic objectForKey:@"taskID"];
        task.objectName = [aDic objectForKey:@"taskName"];
        self.task = task;
        
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
    MDTaskMentionedMessage *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.text = [self.text copy];
    copyObject.createTime = [self.createTime copy];
    copyObject.replyID = [self.replyID copy];
    copyObject.isFavourite = self.isFavourite;
    copyObject.createUser = [self.createUser copy];
    copyObject.replyUser = [self.replyUser copy];
    copyObject.task = [self.task copy];
    copyObject.files = [self.files copy];
    copyObject.images = [self.images copy];
    return copyObject;
}
@end
