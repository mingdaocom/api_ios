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
- (nullable MDURLConnection *)loadAllGroupsWithKeywords:(nullable NSString *)keywords
                                                handler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取所有当前用户创建的群组
 @parmas:
 handler  - 处理包含多个MDGroup的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadCurrentUserCreatedGroupsWithHandler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取所有当前用户加入的群组
 @parmas:
 handler  - 处理包含多个MDGroup的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadCurrentUserJoinedGroupsWithHandler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取单个群组详情
 @parmas:
 gID      - 群组ID
 handler  - 处理单个MDGroup
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadGroupsWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取单个群组的所有成员
 @parmas:
 gID      - 群组ID
 handler  - 处理包含多个MDUser的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadGroupMembersWithGroupID:(nullable NSString *)gID handler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 群组操作（退出、加入、关闭、开启、删除）
 @parmas:
 gID      - 群组ID
 handler  - 处理操作结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)exitGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)joinGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)closeGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)openGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)deleteGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 创建群组
 @parmas:
 gName - 群组名称，必须
 isPub - 是否开放，可选
 handler - 处理修改后的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)createGroupWithGroupName:(nonnull NSString *)gName
                                                detail:(nullable NSString *)detail
                                              isHidden:(nullable NSNumber *)isHidden
                                            isApproval:(nullable NSNumber *)isApproval
                                                isPost:(nullable NSNumber *)isPost
                                                deptID:(nullable NSString *)deptID
                                               handler:(nonnull MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 编辑群组
 @parmas:
 gName - 群组名称，必须
 isPub - 是否开放，可选
 handler - 处理修改后的结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)editGroupWithGroupID:(nonnull NSString *)groupID
                                              name:(nullable NSString *)gName
                                            detail:(nullable NSString *)detail
                                          isHidden:(nullable NSNumber *)isHidden
                                        isApproval:(nullable NSNumber *)isApproval
                                            isPost:(nullable NSNumber *)isPost
                                           handler:(nonnull MDAPIBoolHandler)handler;

- (nullable MDURLConnection *)inviteUserToGroupWithGroupID:(nonnull NSString *)gID
                                                   userIDs:(nullable NSArray *)userIDs
                                                    emails:(nullable NSArray *)emails
                                              phoneNumbers:(nullable NSArray *)phoneNumbers
                                                   handler:(nonnull MDAPINSDictionaryHandler)handler;

- (nullable MDURLConnection *)cancelInviteToUserToGroupWithTokens:(nonnull NSArray *)tokens
                                                          handler:(nonnull MDAPIBoolHandler)handler;
typedef enum {
    MDGroupInviteTypeAll = 0,
    MDGroupInviteTypeWithOtherCompanyUser = 1,
    MDGroupInviteTypeWithColleagueOlny = 2
} MDGroupInviteType;

- (nullable MDURLConnection *)loadInvitedUserToGroupListWithType:(MDGroupInviteType)type
                                                         groupID:(nonnull NSString *)groupID
                                                         handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)deleteUserFromGroupID:(nonnull NSString *)gID
                                             userID:(nonnull NSString *)userID
                                            handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)addGroupAdminWithGroupID:(nonnull NSString *)gID
                                                userID:(nonnull NSString *)userID
                                               handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)removeGroupAdminWithGroupID:(nonnull NSString *)gID
                                                   userID:(nonnull NSString *)userID
                                                  handler:(nonnull MDAPIBoolHandler)handler;

- (nullable MDURLConnection *)loadUnauditedUsersOfGroupID:(nonnull NSString *)groupID
                                                  handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)passUserID:(nonnull NSString *)userID
                               toGroupID:(nonnull NSString *)groupID
                                 handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)refuseUserID:(nonnull NSString *)userID
                               fromGroupID:(nonnull NSString *)groupID
                                   handler:(nonnull MDAPIBoolHandler)handler;


- (nullable MDURLConnection *)loadEGroupUsersListWithHandler:(nonnull MDAPINSDictionaryHandler)handler;


- (nullable MDURLConnection *)chatToPostWithChatGroupID:(nonnull NSString *)groupID
                                                handler:(nonnull MDAPIBoolHandler)handler;


@end
