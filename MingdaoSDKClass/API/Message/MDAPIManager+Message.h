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
 获取当前登录用户与其它单个用户的私人消息列表
 @parmas:
 userID   - 私信来自这个userID的user
 pageSize - 每页包含的私信数量 默认20，最大100
 page     - 私信的页数
 handler  - 处理获取到的包含多个MDMessage的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadMessagesWithUserID:(NSString *)userID
                                   pageSize:(NSInteger)size
                                       page:(NSInteger)pages
                                    handler:(MDAPINSArrayHandler)handler;

@end
