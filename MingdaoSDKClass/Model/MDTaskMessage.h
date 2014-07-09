//
//  MDTaskMessage.h
//  MingdaoV2
//
//  Created by WeeTom on 14-7-9.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MDTaskMessageTypeSystem = 0,
    MDTaskMessageTypeReplayMe = 1,
    MDTaskMessageTypeAtMe = 2
}MDTaskMessageType;

typedef enum {
    MDTaskMessageFileTypeText = 0,
    MDTaskMessageFileTypeImage = 1,
    MDTaskMessageFileTypeDoc = 2,
    MDTaskMessageFileTypeRar = 3
}MDTaskMessageFileType;

@interface MDTaskMessage : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *replyID;
@property (assign, nonatomic) int isFavourite;
@property (strong, nonatomic) MDUser *createUser;
@property (strong, nonatomic) MDUser *replyUser;
@property (strong, nonatomic) MDTask *task;
@property (assign, nonatomic) MDTaskMessageType type;
@property (assign, nonatomic) MDTaskMessageFileType fileType;
@property (strong, nonatomic) MDTaskMessage *replymentToReplyment;

- (MDTaskMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
