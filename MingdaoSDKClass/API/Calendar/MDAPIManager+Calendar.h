//
//  MDAPIManager+Calendar.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Calendar)
#pragma mark - 日程中心

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前用户日历订阅地址
 @parmas:
 handler - 处理返回的地址结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)subscribeCalendar:(MDAPINSStringHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 创建日程
 @parmas:
 name    - 日程名称
 sDateString - 日程开始时间，精确到分。如：2013-05-05 10:25
 eDateString - 日程结束时间，精确到分。如：2013-05-05 10:25
 isAllday - 是否全天日程。0表示非全天，1表示全天
 address - 日程地点
 des - 日程描述
 isPrivate - 是否私人日程。1表示私人，0表示非私人
 uIDs - 指定的日程成员 (多个成员用逗号隔开)。注：明道用户
 emails - 指定的日程成员邮件 (多个成员用逗号隔开)。注：非明道用户
 handler - 创建成功返回日程编号
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)createEventWithEventName:(NSString *)name
                              startDateString:(NSString *)sDateString
                                endDateString:(NSString *)eDateString
                                     isAllDay:(BOOL)isAllday
                                      address:(NSString *)address
                                  description:(NSString *)des
                                    isPrivate:(BOOL)isPrivate
                                      userIDs:(NSArray *)uIDs
                                       emails:(NSArray *)emails
                                      isRecur:(BOOL)isRecur
                                    frequency:(NSInteger)frequency
                                     interval:(NSInteger)interval
                                     weekDays:(NSString *)weekDays
                                   recurCount:(NSInteger)recurCount
                                    untilDate:(NSString *)untilDate
                                      handler:(MDAPINSStringHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 编辑日程
 @parmas:
 eID     - 被修改日程编号
 name    - 日程名称
 sDateString - 日程开始时间，精确到分。如：2013-05-05 10:25
 eDateString - 日程结束时间，精确到分。如：2013-05-05 10:25
 isAllday - 是否全天日程。0表示非全天，1表示全天
 address - 日程地点
 des - 日程描述
 isPrivate - 是否私人日程。1表示私人，0表示非私人
 handler - 处理编辑结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)saveEventWithEventID:(NSString *)eID
                                     name:(NSString *)name
                          startDateString:(NSString *)sDateString
                            endDateString:(NSString *)eDateString
                                 isAllDay:(BOOL)isAllday
                                  address:(NSString *)address
                              description:(NSString *)des
                                isPrivate:(BOOL)isPrivate
                                  isRecur:(BOOL)isRecur
                                frequency:(NSInteger)frequency
                                 interval:(NSInteger)interval
                                 weekDays:(NSString *)weekDays
                               recurCount:(NSInteger)recurCount
                                untilDate:(NSString *)untilDate
                                  handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 邀请/取消邀请/再次邀请用户加入日程
 @parmas:
 eIDs - 被邀请用户们的ID
 emails - 被邀请的用户们的email
 handler - 处理结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)addUsersWithUserIDs:(NSArray *)uIDs emails:(NSArray *)emails toEventID:(NSString *)eID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)deleteUserWithUserIDs:(NSArray *)uIDs emails:(NSArray *)emails fromEventID:(NSString *)eID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)reinviteUserWithUserIDs:(NSArray *)uIDs emails:(NSArray *)emails toEventID:(NSString *)eID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 按需求获取日程列表
 @parmas:
 year - 日期年数字。默认值为当前年。如：2013 Int，最大值9999，最小值2000
 week - 某年第几周数。默认值为当前日期周数 Int，最大值54，最小值1
 yearAndMonth - 日期字符串。默认值为本月。如：2013-05。
 yearMonthAndDay - date	false	string	日期字符串。默认值为今天。如：2013-05-05。
 handler - 处理包含多个MDEvent的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadEventsWithUserIDs:(NSArray *)userIDs
                                   handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadEventsWithUserIDs:(NSArray *)userIDs
                                    forDay:(NSString *)yearMonthAndDay
                                   handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadEventsWithUserIDs:(NSArray *)userIDs
                                   forWeek:(NSInteger)week
                                      year:(NSInteger)year
                                   handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadEventsWithUserIDs:(NSArray *)userIDs
                                  forMonth:(NSString *)yearAndMonth
                                   handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadUnconfirmedEventsWithPageSize:(int)pageSize
                                                  page:(int)page
                                               handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据日程编号获取单条日程内容
 @parmas:
 objectID - 日程编号
 handler - 处理MDEvent
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadEventWithObjectID:(NSString *)objectID handler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 删除/接受/拒绝/退出日程
 @parmas:
 objectID - 日程编号
 handler - 处理结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)deleteEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)exitEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)acceptEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)rejectEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler;


@end
