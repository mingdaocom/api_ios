//
//  MDTaskMentionedMessage.h
//  MingdaoV2
//
//  Created by WeeTom on 14-7-10.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"
#import "MDTask.h"

typedef enum {
    MDTaskMessageFileTypeText = 0,
    MDTaskMessageFileTypeImage = 1,
    MDTaskMessageFileTypeDoc = 2,
    MDTaskMessageFileTypeRar = 3
}MDTaskMessageFileType;

typedef enum {
    MDTaskMessageFileStatusUnStart = 0,
    MDTaskMessageFileStatusOnGoing = 1,
    MDTaskMessageFileStatusComplete = 2,
    MDTaskMessageFileStatusFail = 3
}MDTaskMessageFileStatus;

@interface MDTaskMentionedMessage : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *replyID;
@property (assign, nonatomic) int isFavourite;
@property (strong, nonatomic) MDUser *createUser;
@property (strong, nonatomic) MDUser *replyUser;
@property (strong, nonatomic) MDTask *task;

@property (strong, nonatomic) NSMutableArray *thumbnailPics;
@property (strong, nonatomic) NSMutableArray *originalPics;
@property (strong, nonatomic) NSMutableArray *picNames;
@property (assign, nonatomic) MDTaskMessageFileType fileType;
@property (strong, nonatomic) NSString *fileServer, *filename ,*originalDoc;
@property (assign, nonatomic) MDTaskMessageFileStatus fileStatus;
@property (assign, nonatomic) BOOL isDownloadAble;

- (MDTaskMentionedMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
