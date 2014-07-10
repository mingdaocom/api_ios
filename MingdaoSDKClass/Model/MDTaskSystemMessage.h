//
//  MDTaskMessageSystem.h
//  MingdaoV2
//
//  Created by WeeTom on 14-7-9.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MDTaskEventTypePrivate = 0,
    MDTaskEventTypeEventApply = 1,
    MDTaskEventTypeTaskApply = 2
}MDTaskEventType;

@interface MDTaskSystemMessage : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (assign, nonatomic) BOOL isFavourite;
@property (assign, nonatomic) BOOL isInboxUnread;
@property (assign, nonatomic) BOOL isMessageUnread;
@property (assign, nonatomic) MDTaskEventType eventType;
@property (strong, nonatomic) NSString *eventContent;

@property (strong, nonatomic) NSString *taskID;
@property (strong, nonatomic) NSString *applyUserID;
@property (strong, nonatomic) NSString *applyText;

- (MDTaskSystemMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
