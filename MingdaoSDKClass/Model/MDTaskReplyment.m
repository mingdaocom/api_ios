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
        self.type = [[aDic objectForKey:@"type"] intValue];
        NSDictionary *detailDic = [aDic objectForKey:@"detail"];
        if ([detailDic isKindOfClass:[NSDictionary class]]) {
            self.original_file = [detailDic objectForKey:@"original_file"];
            self.fileName = [detailDic objectForKey:@"original_filename"];
            self.isDownloadAble = [[detailDic objectForKey:@"allow_down"] boolValue];
            NSArray *picsDics = [detailDic objectForKey:@"pics"];
            if (picsDics.count > 0) {
                NSMutableArray *array1 = [NSMutableArray array];
                NSMutableArray *array2 = [NSMutableArray array];
                for (NSDictionary *picsDic in picsDics) {
                    [array1 addObject:[picsDic objectForKey:@"thumbnail_pic"]];
                    [array2 addObject:[picsDic objectForKey:@"original_pic"]];
                }
                self.thumbnailPics = array1;
                self.originalPics = array2;
            }
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
    copyObject.fileName = [self.fileName copy];
    copyObject.isDownloadAble = self.isDownloadAble;
    copyObject.originalPics = [self.originalPics copy];
    copyObject.thumbnailPics = [self.thumbnailPics copy];
    copyObject.source = [self.source copy];
    copyObject.creator = [self.creator copy];
    if (self.replyTo) {
        copyObject.replyTo = [self.replyTo copy];
    }
    return copyObject;
}
@end
