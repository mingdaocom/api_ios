//
//  MDMessage.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "MDMessage.h"

@implementation MDMessageDetail
- (MDMessageDetail *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.thumbnail_pic = [aDic objectForKey:@"thumbnail_pic"];
        self.middle_pic = [aDic objectForKey:@"middle_pic"];
        self.original_pic = [aDic objectForKey:@"original_pic"];
        self.original_filename = [aDic objectForKey:@"original_filename"];
        self.original_file = [aDic objectForKey:@"original_file"];
    }
    return self;
}
@end

@implementation MDMessage
- (MDMessage *)initWithDictionary:(NSDictionary *)aDic
{
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.text = [aDic objectForKey:@"text"];
        self.iHaveRead = [[aDic objectForKey:@"status"] boolValue];
        self.heHasRead = [[aDic objectForKey:@"status2"] boolValue];
        self.createTime = [aDic objectForKey:@"create_time"];
        self.createUserID = [aDic objectForKey:@"create_user"];
        self.type = [[aDic objectForKey:@"message_type"] intValue];
        self.eventType = [[aDic objectForKey:@"event_type"] intValue];
        
        if (self.eventType == MDMessageEventTypeCalendarConfirm) {
            NSString *eventContent = [aDic objectForKey:@"event_content"];
            NSArray *arr = [NSArray arrayWithArray:[eventContent componentsSeparatedByString:@"|"]];
            self.calendarID = arr[0];
            self.calendarName = arr[1];
        }
        
        NSMutableArray *details = [NSMutableArray array];
        NSArray *detailDics = [aDic objectForKey:@"detail"];
        for (NSDictionary *detailDic in detailDics) {
            MDMessageDetail *detail = [[MDMessageDetail alloc] initWithDictionary:detailDic];
            [details addObject:detail];
        }
        self.details = details;
    }
    return self;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDMessage *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.text = [self.text copy];
    copyObject.iHaveRead = self.iHaveRead;
    copyObject.heHasRead = self.heHasRead;
    copyObject.createTime = [self.createTime copy];
    copyObject.createUserID = [self.createUserID copy];
    copyObject.type = self.type;
    copyObject.eventType = self.eventType;
    copyObject.calendarID = [self.calendarID copy];
    copyObject.calendarName = [self.calendarName copy];
    return copyObject;
}
@end
