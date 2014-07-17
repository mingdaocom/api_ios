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
        self.task = [task copy];
        
        self.fileType = [[aDic objectForKey:@"file_type"] intValue];
        self.picNames = [NSMutableArray array];
        NSDictionary *fileDic = [aDic objectForKey:@"file"];
        if ([fileDic isKindOfClass:[NSDictionary class]]) {
            if ([fileDic allKeys].count > 0) {
                self.fileServer = [fileDic objectForKey:@"server"];
                self.fileStatus = [[fileDic objectForKey:@"status"] intValue];
                switch (self.fileType) {
                    case MDTaskMessageFileTypeText:
                        break;
                    case MDTaskMessageFileTypeImage:{
                        self.thumbnailPics = [NSMutableArray array];
                        self.originalPics = [NSMutableArray array];
                        NSString *thumbnailFileName = [fileDic objectForKey:@"thumbnail_name"];
                        NSString *thumbnailFilePath = [fileDic objectForKey:@"thumbnail_path"];
                        NSArray *thumbnailFiles = [thumbnailFileName componentsSeparatedByString:@"|"];
                        for (NSString *thumbnailFile in thumbnailFiles) {
                            NSString *file = [NSString stringWithFormat:@"%@%@%@",self.fileServer,thumbnailFilePath,thumbnailFile];
                            [self.thumbnailPics addObject:file];
                        }
                        
                        NSString *originalFileName = [fileDic objectForKey:@"filename_original"];
                        NSString *originalFilePath = [fileDic objectForKey:@"filepath_original"];
                        NSArray *originalFiles = [originalFileName componentsSeparatedByString:@"|"];
                        for (NSString *originalFile in originalFiles) {
                            NSString *file = [NSString stringWithFormat:@"%@%@%@",self.fileServer,originalFilePath,originalFile];
                            [self.originalPics addObject:file];
                        }
                        
                        NSArray *originalFileNames = [[fileDic objectForKey:@"original_filename"] componentsSeparatedByString:@"|"];
                        [self.picNames addObjectsFromArray:originalFileNames];
                    }
                        break;
                    case MDTaskMessageFileTypeDoc:
                    case MDTaskMessageFileTypeRar:{
                        NSString *originalFileName = [fileDic objectForKey:@"filename_original"];
                        NSString *originalFilePath = [fileDic objectForKey:@"filepath_original"];
                        
                        NSString *file = [NSString stringWithFormat:@"%@%@%@",self.fileServer,originalFilePath,originalFileName];
                        
                        self.originalDoc = file;
                        self.filename = [fileDic objectForKey:@"original_filename"];
                        self.isDownloadAble = [[fileDic objectForKey:@"allow_down"] boolValue];
                    }
                        break;
                    default:
                        break;
                }
            }
        }
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
    copyObject.thumbnailPics = [self.thumbnailPics copy];
    copyObject.originalPics = [self.originalPics copy];
    copyObject.picNames = [self.picNames copy];
    copyObject.filename = [self.filename copy];
    copyObject.originalDoc = [self.originalDoc copy];
    copyObject.fileStatus = self.fileStatus;
    copyObject.fileServer = [self.fileServer copy];
    copyObject.isDownloadAble = self.isDownloadAble;
    copyObject.fileType = self.fileType;
    return copyObject;
}
@end
