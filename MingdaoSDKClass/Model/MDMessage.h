//
//  MDMessage.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MDMessageTypePrivate = 0,
    MDMessageTypeTask = 1,
    MDMessageTypeDoc = 2,
    MDMessageTypeCategory = 3,
    MDMessageTypeCalendar = 4,
    MDMessageTypeSystem = 5
} MDMessageType;

typedef enum {
    MDMessageEventTypePrivate = 0,
    MDMessageEventTypeCalendarConfirm = 1,
    MDMessageEventTypeTaskApply = 2
} MDMessageEventType;

@interface MDMessageDetail : NSObject
@property (strong, nonatomic) NSString *thumbnail_pic, *middle_pic, *original_pic, *original_filename, *original_file;
@end

@interface MDMessage : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *createUserID;
@property (assign, nonatomic) BOOL iHaveRead, heHasRead;
@property (assign, nonatomic) MDMessageType type;
@property (assign, nonatomic) MDMessageEventType eventType;
@property (strong, nonatomic) NSString *calendarID;
@property (strong, nonatomic) NSString *calendarName;
@property (strong, nonatomic) NSArray *details;

- (MDMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
