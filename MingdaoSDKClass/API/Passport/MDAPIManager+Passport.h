//
//  MDAPIManager+Passport.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"
#import <UIKit/UIKit.h>

@interface MDAPIManager (Passport)
#pragma mark - 账号接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前登录用户的基本信息
 @parmas:
 handler - 处理MDUser结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadCurrentUserDetailWithHandler:(nonnull MDAPIObjectHandler)handler;

- (nullable MDURLConnection *)loadCurrentUserSettingWithHandler:(nonnull MDAPIObjectHandler)handler;
- (nullable MDURLConnection *)setCurrentUserSettingWithMentionMeOn:(nullable NSNumber *)mentionOn replymeOn:(nullable NSNumber *)replyOn sysOn:(nullable NSNumber *)sysOn Handler:(nonnull MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前登录用户的未读信息数量
 @parmas:
 handler - 处理NSDictionary结果（keys: updated, replyme, atme, message, task）
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
#define MDAPIResultKeyUnreadUpdated @"updated"
#define MDAPIResultKeyUnreadReplyme @"replyme"
#define MDAPIResultKeyUnreadAtme    @"atme"
#define MDAPIResultKeyUnreadMessage @"message"
#define MDAPIResultKeyUnreadTask    @"task"
- (nullable MDURLConnection *)loadCurrentUserUnreadCountWithHandler:(nonnull MDAPINSDictionaryHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 登出
 @parmas:
 handler - 处理登出后的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)logoutWithHandler:(nonnull MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 保存新的用户信息到服务器
 @parmas:
 name必须 - 用户姓名
 dep必须  - 部门
 job必须 - 工作
 mpn可选  - 移动号码
 wpn可选  - 工作号码
 birthday可选 - 生日
 gender可选   - 性别
 handler - 处理修改后的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)saveUserWithName:(nonnull NSString *)name
                                    department:(nonnull NSString *)dep
                                           job:(nonnull NSString *)job
                             mobilePhoneNumber:(nullable NSString *)mpn
                               workPhoneNumber:(nullable NSString *)wpn
                                      birthday:(nullable NSString *)birthday
                                        gender:(nullable NSNumber *)gender
                                       handler:(nonnull MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 保存新的用户头像
 @parmas:
 avatarImg - 头像图片，不超过5MB
 handler - 处理修改后的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)saveUserWithAvatar:(nonnull UIImage *)avatarImg handler:(nonnull MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前个人常用动态标签信息
 @parmas:
 handler - 处理包含多个MDTag的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadCurrentUserCommonTagsWithHandler:(nonnull MDAPINSArrayHandler)handler;

@end
