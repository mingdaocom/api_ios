//
//  MDAPIManager+User.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (User)
#pragma mark - 用户接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取企业通讯录信息
 @parmas:
 handler - 处理包含多个MDUser的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadAllUsersWithHandler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadTopMentionedUsersWihtHandler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据筛选条件获取用户列表信息
 @parmas:
 keywords - 关键词 可选
 gID      - 所在群组ID 可选
 dep      - 所在部门 可选
 handler  - 处理包含多个MDUser的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadUsersWithKeywords:(NSString *)keywords
                                   groupID:(NSString *)gID
                                department:(NSString *)dep
                                   handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据用户编号获取用户的基本资料
 @parmas:
 uID      - 用户编号
 handler  - 处理MDUser
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadUserWithUserID:(NSString *)uID
                                handler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据用户编号获取用户正在关注用户信息
 @parmas:
 uID      - 用户编号
 handler  - 处理包含多个MDUser的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadUserFollowedByUserWithUserID:(NSString *)uID
                                              handler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取企业所有部门列表信息
 @parmas:
 handler  - 处理包含多个NSString的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadAllDepartmentsWithHandler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 关注，取消关注用户
 @parmas:
 userID   - 被关注，取消的用户编号
 handler  - 处理包含多个NSString的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)followUserWithUserID:(NSString *)userID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)unfollowUserWithUserID:(NSString *)userID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 邀请用户（同事邮箱）加入企业网络
 @parmas:
 type -	邀请类型。默认值0，表示网络内有效邮箱域名邀请；1表示来宾邀请（仅限高级模式）可选
 email - 邀请的邮箱 必须
 fullname - 被邀请人姓名 必须
 msg - 邀请的消息 必须
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnectionQueue *)inviteUserToCompanyWithEmail:(NSString *)email
                              baseAuthenticationDomain:(NSString *)baseAuthenticationDomain
                                               handler:(MDAPIQueueBoolHandler)handler;

- (MDURLConnection *)reinviteUserWithEmails:(NSArray *)emails handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)cancelInviteToUserWithEmails:(NSArray *)emails tokens:(NSArray *)tokens handler:(MDAPIBoolHandler)handler;

typedef enum
{
    MDInvitedUserTypeAllFailed = 0,
    MDInvitedUserTypeTokenUnuserd = 1,
    MDInvitedUserTypePendding = 2,
    MDInvitedUserTypeRefused = 3,
    MDInvitedUserTypeSucceed = 4
} MDInvitedUserType;

- (MDURLConnection *)loadInvitedUserListWithType:(MDInvitedUserType)type handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前登录用户常用联系人列表
 @parmas:
 handler  - 处理包含多个MDUser的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadFavouritedUsersWithHandler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 当前登录用户添加/删除常用关系
 @parmas:
 uID     - 被操作对象编号
 handler - 处理包含多个MDUser的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)favouriteUserWithUserID:(NSString *)uID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)unfavouriteUserWithUserID:(NSString *)uID handler:(MDAPIBoolHandler)handler;


@end
