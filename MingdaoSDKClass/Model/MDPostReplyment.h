//
//  MDPostReplyment.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDPost.h"

enum {
    MDPostReplymentTypeText = 0,
    MDPostReplymentTypeImage = 2,
    MDPostReplymentTypeDocument = 3
};
typedef int MDPostReplymentType;

@interface MDPostReplymentDetail : NSObject
@property (strong, nonatomic) NSString *middlePic, *originalPic, *fileName, *thumbnailPic, *originalDoc;
@property (assign, nonatomic) MDAttachmentFileType fileType;
@property (assign, nonatomic) BOOL isDownloadAble;

@property (strong, nonatomic) NSString *replyID;
- (MDPostReplymentDetail *)initWithDictionary:(NSDictionary *)aDic;
@end

@interface MDPostReplyment : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime, *source;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) MDPostReplyment *replymentToReplyment;
@property (strong, nonatomic) MDPost *replymentToPost;
@property (assign, nonatomic) MDPostReplymentType type;

@property (strong, nonatomic) NSArray *details; // to be removed, replaced by below

@property (strong, nonatomic) NSArray *images, *files;


- (MDPostReplyment *)initWithDictionary:(NSDictionary *)aDic;
@end
