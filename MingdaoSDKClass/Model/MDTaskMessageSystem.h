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
    MDTaskEventTypeApply = 1
}MDTaskEventType;

@interface MDTaskMessageSystem : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (assign, nonatomic) BOOL isFavourite;
@property (assign, nonatomic) BOOL isInboxUnread;
@property (assign, nonatomic) BOOL isMessageUnread;
@property (assign, nonatomic) MDTaskEventType eventType;
@property (strong, nonatomic) NSString *eventContent;

- (MDTaskMessageSystem *)initWithDictionary:(NSDictionary *)aDic;
@end
