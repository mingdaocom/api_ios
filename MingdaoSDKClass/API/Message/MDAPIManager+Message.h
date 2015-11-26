//
//  MDAPIManager+Message.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Message)
#pragma mark - 私信接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前登录用户私人消息列表（列举所有私信的发送人列表,按照最新消息时间排序）
 @parmas:
 handler - 处理获取到的包含多个MDMessageAll的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadCurrentUserMessagesWithHandler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前登录用户与其它单个用户的私人消息列表
 @parmas:
 userID   - 私信来自这个userID的user
 pageSize - 每页包含的私信数量 默认20，最大100
 page     - 私信的页数
 handler  - 处理获取到的包含多个MDMessage的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadMessagesWithUserID:(nonnull NSString *)userID
                                            pageSize:(nullable NSNumber *)size
                                                page:(nullable NSNumber *)pages
                                             handler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 向某个用户发送一条私人消息
 @parmas:
 userID   - 私信来自这个userID的user
 text     - 私信内容
 handler  - 处理发送成功后返回的私信ID
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)sendMessageToUserID:(nonnull NSString *)userID
                                          message:(nonnull NSString *)text
                                           images:(nullable NSArray *)images
                                          handler:(nonnull MDAPINSStringHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 删除当前登录用户的私人消息
 @parmas:
 mID      - 被删除的消息编号
 handler  - 处理删除的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)deleteMessageWithMessageID:(nonnull NSString *)mID handler:(nonnull MDAPIBoolHandler)handler;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 标记某条消息已经阅读
 @parmas:
 mID      - 被阅读的消息编号
 handler  - 处理已读的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)markMessageAsReadWithMessageID:(nonnull NSString *)mID handler:(nonnull MDAPIBoolHandler)handler;


@end
