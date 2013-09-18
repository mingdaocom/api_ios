//
//  MDMessage.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageTypePrivate = 0,
    MessageTypeTask = 1,
    MessageTypeDoc = 2,
    MessageTypeCategory = 3,
    MessageTypeCalendar = 4,
    MessageTypeSystem = 5
} MessageType;

@interface MDMessage : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *createUserID;
@property (assign, nonatomic) BOOL iHaveRead, heHasRead;
@property (assign, nonatomic) MessageType type;

- (MDMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
