//
//  MDTaskReplyment.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"
#import "MDPost.h"

@class MDTask;

@interface MDTaskReplymentDetail : NSObject
@property (strong, nonatomic) NSString *thumbnail_pic, *middle_pic, *original_pic, *original_filename;
@property (strong, nonatomic) NSString *original_file;
@property (assign, nonatomic) BOOL allow_down;
@property (assign, nonatomic) long long fileSize;
@property (assign, nonatomic) MDAttachmentFileType file_type;

@property (strong, nonatomic) NSString *replyID;
- (MDTaskReplymentDetail *)initWithDictionary:(NSDictionary *)aDic;
@end

@interface MDTaskReplyment : NSObject
@property (strong, nonatomic) NSString *objectID, *autoID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createDateString, *source;
@property (assign, nonatomic) int type;

@property (strong, nonatomic) NSArray *images, *files;

@property (strong, nonatomic) MDTask *task;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) MDUser *replyTo;
@property (assign, nonatomic) MDAttachmentFileType fileType;

- (MDTaskReplyment *)initWithDictionary:(NSDictionary *)aDic;
@end
