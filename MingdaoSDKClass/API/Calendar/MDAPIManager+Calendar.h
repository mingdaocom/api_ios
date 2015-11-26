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
- (nullable MDURLConnection *)subscribeCalendar:(nonnull MDAPINSStringHandler)handler;

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
                                               handler:(nonnull MDAPINSStringHandler)handler;

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
                                           handler:(nonnull MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 邀请/取消邀请/再次邀请用户加入日程
 @parmas:
 eIDs - 被邀请用户们的ID
 emails - 被邀请的用户们的email
 handler - 处理结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)addUsersWithUserIDs:(nullable NSArray *)uIDs
                                           emails:(nullable NSArray *)emails
                                        toEventID:(nonnull NSString *)eID
                                          handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)deleteUserWithUserIDs:(nullable NSArray *)uIDs
                                             emails:(nullable NSArray *)emails
                                        fromEventID:(nonnull NSString *)eID
                                            handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)reinviteUserWithUserIDs:(nullable NSArray *)uIDs
                                               emails:(nullable NSArray *)emails
                                            toEventID:(nonnull NSString *)eID
                                              handler:(nonnull MDAPIBoolHandler)handler;

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
- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                             forDay:(nullable NSString *)yearMonthAndDay
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                            forWeek:(nullable NSNumber *)week
                                               year:(nullable NSNumber *)year
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadEventsWithUserIDs:(nullable NSArray *)userIDs
                                           forMonth:(nullable NSString *)yearAndMonth
                                     isWorkCalendar:(nonnull NSNumber *)isWorkCalendar
                                  isPrivateCalendar:(nonnull NSNumber *)isPrivateCalendar
                                     isTaskCalendar:(nonnull NSNumber *)isTaskCalendar
                                          categorys:(nullable NSString *)categorys
                                            handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadUnconfirmedEventsWithPageSize:(nullable NSNumber *)pageSize
                                                           page:(nullable NSNumber *)page
                                                        handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadUpComingEventsForChatCardWithKeywors:(nullable NSString *)keywords
                                                               handler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据日程编号获取单条日程内容
 @parmas:
 objectID - 日程编号
 handler - 处理MDEvent
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadEventWithObjectID:(nonnull NSString *)objectID
                                            handler:(nonnull MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 删除/接受/拒绝/退出日程
 @parmas:
 objectID - 日程编号
 handler - 处理结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)deleteEventWithObjectID:(nonnull NSString *)objectID
                                              handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)exitEventWithObjectID:(nonnull NSString *)objectID
                                            handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)acceptEventWithObjectID:(nonnull NSString *)objectID
                                              handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)rejectEventWithObjectID:(nonnull NSString *)objectID
                                              handler:(nonnull MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取/增加/修改/删除当前登录用户日程分类

 handler - 处理MDEvent
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadCurrentUserEventCategory:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)addCurrentUserEventCategoryWithCatName:(nonnull NSString *)catName
                                                               color:(nonnull NSNumber *)color
                                                             handler:(nonnull MDAPIBoolHandler)handler;//--
- (nullable MDURLConnection *)editCurrentUserEventCategoryWithCatName:(nonnull NSString *)catName
                                                                catID:(nonnull NSString *)catID
                                                                color:(nonnull NSNumber *)color
                                                              handler:(nonnull MDAPIBoolHandler)handler;//--
- (nullable MDURLConnection *)deleteCurrentUserEventCategoryWithCatID:(nonnull NSString *)catID
                                                              handler:(nonnull MDAPIBoolHandler)handler;//--
/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据日程开始和结束时间获取冲突日程列表
 @parmas:
 handler - 处理MDEvent
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadBusyEventsWithStartTime:(nonnull NSString *)startDateString
                                                  endTime:(nonnull NSString *)endDateString
                                                  handler:(nonnull MDAPINSArrayHandler)handler;//--

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据日程ID修改日程成员受到提醒的时间
 @parmas:
 handler - 处理结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)modifyEventMemberRemindWithObjectID:(nonnull NSString *)objectID
                                                       remindType:(nonnull NSNumber *)remindType
                                                       remindTime:(nonnull NSNumber *)remindTime
                                                          handler:(nonnull MDAPINSStringHandler)handler;//--
@end
