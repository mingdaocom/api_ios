//
//  MDAPIManager+Group.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Group)
#pragma mark - 群组接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取所有群组
 @parmas:
 keywords - 包含的关键词，可选
 handler  - 处理包含多个MDGroup的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadAllGroupsWithKeywords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取所有当前用户创建的群组
 @parmas:
 handler  - 处理包含多个MDGroup的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadCurrentUserCreatedGroupsWithHandler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取所有当前用户加入的群组
 @parmas:
 handler  - 处理包含多个MDGroup的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadCurrentUserJoinedGroupsWithHandler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取单个群组详情
 @parmas:
 gID      - 群组ID
 handler  - 处理单个MDGroup
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadGroupsWithGroupID:(NSString *)gID handler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取单个群组的所有成员
 @parmas:
 gID      - 群组ID
 handler  - 处理包含多个MDUser的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadGroupMembersWithGroupID:(NSString *)gID handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 群组操作（退出、加入、关闭、开启、删除）
 @parmas:
 gID      - 群组ID
 handler  - 处理操作结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)exitGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)joinGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)closeGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)openGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)deleteGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 创建群组
 @parmas:
 gName - 群组名称，必须
 isPub - 是否开放，可选
 handler - 处理修改后的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)createGroupWithGroupName:(NSString *)gName
                                       detail:(NSString *)detail
                                     isPublic:(BOOL)isPub
                                     isHidden:(BOOL)isHidden
                                      handler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 编辑群组
 @parmas:
 gName - 群组名称，必须
 isPub - 是否开放，可选
 handler - 处理修改后的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)editGroupWithGroupID:(NSString *)groupID
                                     name:(NSString *)gName
                                   detail:(NSString *)detail
                                 isPublic:(BOOL)isPub
                                 isHidden:(BOOL)isHidden
                                  handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 邀请用户（同事邮箱）加入群组
 @parmas:
 gID        - 群组ID，必须
 被邀请者邮箱 - 是否开放，必须
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)inviteUserToGroupWithGroupID:(NSString *)gID
                                           emails:(NSArray *)emails
                                       inviteType:(NSInteger)type
                                          handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)cancelInviteToUserToGroupWithTokens:(NSArray *)tokens
                                                 handler:(MDAPIBoolHandler)handler;
typedef enum {
    MDGroupInviteTypeAll = 0,
    MDGroupInviteTypeWithOtherCompanyUser = 1,
    MDGroupInviteTypeWithColleagueOlny = 2
} MDGroupInviteType;

- (MDURLConnection *)loadInvitedUserToGroupListWithType:(MDGroupInviteType)type
                                                groupID:(NSString *)groupID
                                                handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)deleteUserFromGroupID:(NSString *)gID
                                    userID:(NSString *)userID
                                   handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)addGroupAdminWithGroupID:(NSString *)gID
                                       userID:(NSString *)userID
                                      handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)removeGroupAdminWithGroupID:(NSString *)gID
                                          userID:(NSString *)userID
                                         handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)loadUnauditedUsersOfGroupID:(NSString *)groupID
                                         handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)passUserID:(NSString *)userID
                      toGroupID:(NSString *)groupID
                        handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)refuseUserID:(NSString *)userID
                      fromGroupID:(NSString *)groupID
                          handler:(MDAPIBoolHandler)handler;
@end
