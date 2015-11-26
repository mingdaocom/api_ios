//
//  MDAPIManager+Calendar.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Calendar.h"

@implementation MDAPIManager (Calendar)
#pragma mark - 日程中心
- (nullable MDURLConnection *)subscribeCalendar:(nonnull MDAPINSStringHandler)handler
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/todo?u_key=%@&rssCal=1&format=json"
                        , self.serverAddress
                        , self.accessToken];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSString *urlString = [[dic objectForKey:@"calendar_url"] mutableCopy];
        handler(urlString, nil);
    }];
    return connection;
}

- (nullable MDURLConnection *)createEventWithEventName:(nonnull NSString *)name
                                       startDateString:(nonnull NSString *)sDateString
                                         endDateString:(nonnull NSString *)eDateString
                                            remindType:(nullable NSNumber *)remindType
                                            remindTime:(nullable NSNumber *)remindTime
                                            categoryID:(nullable NSString *)categoryID
                                              isAllDay:(BOOL)isAllday
                                               address:(nullable NSString *)address
                                           description:(nullable NSString *)des
                                             isPrivate:(BOOL)isPrivate
                                       visibleGroupIDs:(nullable NSArray *)visibleGroupIDs
                                               userIDs:(nullable NSArray *)uIDs
                                                emails:(nullable NSArray *)emails
                                               isRecur:(BOOL)isRecur
                                             frequency:(nullable NSNumber *)frequency
                                              interval:(nonnull NSNumber *)interval
                                              weekDays:(nullable NSString *)weekDays
                                            recurCount:(nullable NSNumber *)recurCount
                                             untilDate:(nullable NSString *)untilDate
                                               handler:(nonnull MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/create"];
    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"c_name", @"object":name}];
    [parameters addObject:@{@"key":@"c_stime", @"object":sDateString}];
    [parameters addObject:@{@"key":@"c_etime", @"object":eDateString}];
    [parameters addObject:@{@"key":@"c_remindType", @"object":remindType}];
    [parameters addObject:@{@"key":@"c_remindTime", @"object":remindTime}];
    [parameters addObject:@{@"key":@"c_categoryID", @"object":categoryID}];
    [parameters addObject:@{@"key":@"c_allday", @"object":isAllday?@1:@0}];
    [parameters addObject:@{@"key":@"c_private", @"object":isPrivate?@0:@1}];
    if (isPrivate) {
        NSString *groupIDsString = [visibleGroupIDs componentsJoinedByString:@","];
        if (groupIDsString) {
            [parameters addObject:@{@"key":@"g_ids", @"object":groupIDsString}];
        }
    }
    if (address && address.length > 0)
        [parameters addObject:@{@"key":@"c_address", @"object":address}];
    if (des && des.length > 0)
        [parameters addObject:@{@"key":@"c_des", @"object":des}];
    if (uIDs && uIDs.count > 0)
        [parameters addObject:@{@"key":@"c_mids", @"object":[uIDs componentsJoinedByString:@","]}];
    if (emails && emails.count > 0)
        [parameters addObject:@{@"key":@"c_memails", @"object":[emails componentsJoinedByString:@","]}];
    if (isRecur) {
        [parameters addObject:@{@"key":@"is_recur", @"object":@1}];
        [parameters addObject:@{@"key":@"frequency", @"object":@([frequency longValue])}];
        [parameters addObject:@{@"key":@"interval", @"object":@([interval longValue])}];
        if ([frequency longValue] == 2) {
            NSString *finalWeekDays = [weekDays stringByReplacingOccurrencesOfString:@"0" withString:@"7"];
            [parameters addObject:@{@"key":@"week_day", @"object":finalWeekDays}];
        }
        if (recurCount > 0) {
            [parameters addObject:@{@"key":@"recur_count", @"object":@([recurCount longValue])}];
        }
        if (untilDate && untilDate.length > 0) {
            [parameters addObject:@{@"key":@"until_date", @"object":untilDate}];
        }
    }
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self postWithParameters:parameters withRequest:req];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSString *eventID = [dic objectForKey:@"calendar"];
        handler(eventID, nil);
    }];
    return connection;
}

- (nullable MDURLConnection *)saveEventWithEventID:(nonnull NSString *)eID
                                              name:(nonnull NSString *)name
                                   startDateString:(nonnull NSString *)sDateString
                                     endDateString:(nonnull NSString *)eDateString
                                        remindType:(nullable NSNumber *)remindType
                                        remindTime:(nullable NSNumber *)remindTime
                                        categoryID:(nullable NSString *)categoryID
                                          isAllDay:(BOOL)isAllday
                                           address:(nullable NSString *)address
                                       description:(nullable NSString *)des
                                         isPrivate:(BOOL)isPrivate
                                           isRecur:(BOOL)isRecur
                                         frequency:(nonnull NSNumber *)frequency
                                          interval:(nullable NSNumber *)interval
                                          weekDays:(nullable NSString *)weekDays
                                        recurCount:(nullable NSNumber *)recurCount
                                         untilDate:(nullable NSString *)untilDate
                                           handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/edit"];
    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"c_id", @"object":eID}];
    [parameters addObject:@{@"key":@"c_name", @"object":name}];
    [parameters addObject:@{@"key":@"c_stime", @"object":sDateString}];
    [parameters addObject:@{@"key":@"c_etime", @"object":eDateString}];
    [parameters addObject:@{@"key":@"c_remindType", @"object":@([remindType longValue])}];
    [parameters addObject:@{@"key":@"c_remindTime", @"object":@([remindTime longValue])}];
    [parameters addObject:@{@"key":@"c_categoryID", @"object":categoryID}];
    [parameters addObject:@{@"key":@"c_allday", @"object":isAllday?@1:@0}];
    [parameters addObject:@{@"key":@"c_private", @"object":isPrivate?@0:@1}];
    
    if (address && address.length > 0)
        [parameters addObject:@{@"key":@"c_address", @"object":address}];
    if (des && des.length > 0)
        [parameters addObject:@{@"key":@"c_des", @"object":des}];
    if (isRecur) {
        [parameters addObject:@{@"key":@"is_recur", @"object":@1}];
        [parameters addObject:@{@"key":@"frequency", @"object":@([frequency longValue])}];
        [parameters addObject:@{@"key":@"interval", @"object":@([interval longValue])}];
        if ([frequency longValue]== 2) {
            NSString *finalWeekDays = [weekDays stringByReplacingOccurrencesOfString:@"0" withString:@"7"];
            [parameters addObject:@{@"key":@"week_day", @"object":finalWeekDays}];
        }
        if (recurCount > 0) {
            [parameters addObject:@{@"key":@"recur_count", @"object":@([recurCount longValue])}];
        }
        if (untilDate && untilDate.length > 0) {
            [parameters addObject:@{@"key":@"until_date", @"object":untilDate}];
        }
    }
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self postWithParameters:parameters withRequest:req];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)addUsersWithUserIDs:(nullable NSArray *)uIDs
                                           emails:(nullable NSArray *)emails
                                        toEventID:(nonnull NSString *)eID
                                          handler:(nonnull MDAPIBoolHandler)handler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/add_member?u_key=%@&c_id=%@&c_mids=%@&c_memails=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , eID
                        , uIDs.count > 0 ? [uIDs componentsJoinedByString:@","] : @""
                        , emails.count > 0 ? [emails componentsJoinedByString:@","] : @""
                        ];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)deleteUserWithUserIDs:(nullable NSArray *)uIDs
                                             emails:(nullable NSArray *)emails
                                        fromEventID:(nonnull NSString *)eID
                                            handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/delete_member?u_key=%@&c_id=%@&c_mids=%@&c_memails=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , eID
                        , uIDs.count > 0 ? [uIDs componentsJoinedByString:@","] : @""
                        , emails.count > 0 ? [emails componentsJoinedByString:@","] : @""
                        ];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)reinviteUserWithUserIDs:(nullable NSArray *)uIDs
                                               emails:(nullable NSArray *)emails
                                            toEventID:(nonnull NSString *)eID
                                              handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/reinvite_member?u_key=%@&c_id=%@&c_mids=%@&c_memails=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , eID
                        , uIDs.count > 0 ? [uIDs componentsJoinedByString:@","] : @""
                        , emails.count > 0 ? [emails componentsJoinedByString:@","] : @""
                        ];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/todo?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (userIDs) {
        [urlString appendFormat:@"&u_ids=%@", [userIDs componentsJoinedByString:@","]];
    }
    [urlString appendFormat:@"&isWorkCalendar=%ld",[isWorkCalendar longValue]];
    [urlString appendFormat:@"&isPrivateCalendar=%ld",[isPrivateCalendar longValue]];
    [urlString appendFormat:@"&isTaskCalendar=%ld",[isTaskCalendar longValue]];
    if (categorys) {
        [urlString appendFormat:@"&categorys=%@",categorys];
    }

    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                             forDay:(nullable NSString *)yearMonthAndDay
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/day?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (yearMonthAndDay) {
        [urlString appendFormat:@"&date=%@", yearMonthAndDay];
    }
    if (userIDs) {
        [urlString appendFormat:@"&u_ids=%@", [userIDs componentsJoinedByString:@","]];
    }
    [urlString appendFormat:@"&isWorkCalendar=%ld",[isWorkCalendar longValue]];
    [urlString appendFormat:@"&isPrivateCalendar=%ld",[isPrivateCalendar longValue]];
    [urlString appendFormat:@"&isTaskCalendar=%ld",[isTaskCalendar longValue]];
    if (categorys.length > 0) {
        [urlString appendFormat:@"&categorys=%@",categorys];
    }

    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            if (![aDic isKindOfClass:[NSDictionary class]])
                continue;
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                            forWeek:(nullable NSNumber *)week
                                               year:(nullable NSNumber *)year
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/week?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (year) {
        [urlString appendFormat:@"&year=%ld", [year longValue]];
    }
    if (week) {
        [urlString appendFormat:@"&year=%ld", [year longValue]];
    }
    if (userIDs) {
        [urlString appendFormat:@"&u_ids=%@", [userIDs componentsJoinedByString:@","]];
    }
    [urlString appendFormat:@"&isWorkCalendar=%ld",[isWorkCalendar longValue]];
    [urlString appendFormat:@"&isPrivateCalendar=%ld",[isPrivateCalendar longValue]];
    [urlString appendFormat:@"&isTaskCalendar=%ld",[isTaskCalendar longValue]];
    if (categorys) {
        [urlString appendFormat:@"&categorys=%@",categorys];
    }
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            if (![aDic isKindOfClass:[NSDictionary class]])
                continue;
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                           forMonth:(nullable NSString *)yearAndMonth
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/month?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (yearAndMonth) {
        [urlString appendFormat:@"&date=%@", yearAndMonth];
    }
    if (userIDs) {
        [urlString appendFormat:@"&u_ids=%@", [userIDs componentsJoinedByString:@","]];
    }
    [urlString appendFormat:@"&isWorkCalendar=%ld", [isWorkCalendar longValue]];
    [urlString appendFormat:@"&isPrivateCalendar=%ld", [isPrivateCalendar longValue]];
    [urlString appendFormat:@"&isTaskCalendar=%ld", [isTaskCalendar longValue]];
    if (categorys.length > 0) {
        [urlString appendFormat:@"&categorys=%@",categorys];
    }

    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            if (![aDic isKindOfClass:[NSDictionary class]])
                continue;
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadUnconfirmedEventsWithPageSize:(nullable NSNumber *)pageSize
                                                           page:(nullable NSNumber *)page
                                                        handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/invitedCalendars?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (page) {
        [urlString appendFormat:@"&pageindex=%d", [page intValue]];
    }
    [urlString appendFormat:@"&pagesize=%d", [pageSize intValue]];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            if (![aDic isKindOfClass:[NSDictionary class]])
                continue;
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadUpComingEventsForChatCardWithKeywors:(nullable NSString *)keywords
                                                               handler:(nonnull MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/calendar/getChatCalendars.aspx?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords) {
        [urlString appendFormat:@"&keywords=%@", keywords];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            if (![aDic isKindOfClass:[NSDictionary class]])
                continue;
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadEventWithObjectID:(nonnull NSString *)objectID
                                            handler:(nonnull MDAPIObjectHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/detail?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSDictionary *aDic = [dic objectForKey:@"calendar"];
        MDEvent *returnEvent = [[MDEvent alloc] initWithDictionary:aDic];
        handler(returnEvent, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)deleteEventWithObjectID:(nonnull NSString *)objectID
                                              handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/destroy?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)exitEventWithObjectID:(nonnull NSString *)objectID
                                            handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/exit?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)acceptEventWithObjectID:(nonnull NSString *)objectID
                                              handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/join?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)rejectEventWithObjectID:(nonnull NSString *)objectID
                                              handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/deny?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)loadCurrentUserEventCategory:(nonnull MDAPINSArrayHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/getUserAllCalCategories?u_key=%@&format=json"
                        , self.serverAddress
                        , self.accessToken];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnCalendars = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"categorys"]) {
            if (![aDic isKindOfClass:[NSDictionary class]])
                continue;
            MDCalendarCategory *calendar = [[MDCalendarCategory alloc]initWithDictionary:aDic];
            [returnCalendars addObject:calendar];
        }
        
        handler(returnCalendars, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)addCurrentUserEventCategoryWithCatName:(nonnull NSString *)catName
                                                               color:(nonnull NSNumber *)color
                                                             handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@/calendar/addUserCalCategory?u_key=%@&format=json"
                                  , self.serverAddress
                                  , self.accessToken];
    [urlString appendFormat:@"&catName=%@", catName];
    [urlString appendFormat:@"&color=%ld", [color longValue]];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
    

}

- (nullable MDURLConnection *)editCurrentUserEventCategoryWithCatName:(nonnull NSString *)catName
                                                                catID:(nonnull NSString *)catID
                                                                color:(nonnull NSNumber *)color
                                                              handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@/calendar/upUserCalCategory?u_key=%@&format=json"
                                  , self.serverAddress
                                  , self.accessToken];
    [urlString appendFormat:@"&catName=%@", catName];
    [urlString appendFormat:@"&catID=%@",catID];
    [urlString appendFormat:@"&color=%ld", [color longValue]];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)deleteCurrentUserEventCategoryWithCatID:(nonnull NSString *)catID
                                                              handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@/calendar/delUserCalCategory?u_key=%@&format=json"
                                  , self.serverAddress
                                  , self.accessToken];
    [urlString appendFormat:@"&catID=%@",catID];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)loadBusyEventsWithStartTime:(nonnull NSString *)startDateString
                                                  endTime:(nonnull NSString *)endDateString
                                                  handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@/calendar/getUserBusyCalendar?u_key=%@&format=json"
                        , self.serverAddress
                        , self.accessToken];
    [urlString appendFormat:@"&c_stime=%@", startDateString];
    [urlString appendFormat:@"&c_etime=%@", endDateString];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"Calendars"]) {
            if (![aDic isKindOfClass:[NSDictionary class]])
                continue;
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        handler(returnEvents, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)modifyEventMemberRemindWithObjectID:(nonnull NSString *)objectID
                                                       remindType:(nonnull NSNumber *)remindType
                                                       remindTime:(nonnull NSNumber *)remindTime
                                                          handler:(nonnull MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@/calendar/upCalRemind?u_key=%@&format=json"
                                  , self.serverAddress
                                  , self.accessToken];
    [urlString appendFormat:@"&c_id=%@",objectID];
    [urlString appendFormat:@"&c_remindType=%ld", [remindType longValue]];
    [urlString appendFormat:@"&c_remindTime=%ld", [remindTime longValue]];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSString *urlstring = [[dic objectForKey:@"count"] mutableCopy];
        handler(urlstring, nil);
    }];
    return connection;

    
}


@end
