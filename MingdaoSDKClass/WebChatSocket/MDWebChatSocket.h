//
//  MDWebChatSocket.h
//  MingdaoV2
//
//  Created by Wee Tom on 13-11-6.
//  Copyright (c) 2013年 Mingdao. All rights reserved.
//

#import "SocketIO.h"

@class MDWebChatSocket;
typedef void (^MDWebChatSocketConnectionHandler)(MDWebChatSocket *socket, NSError *error);
typedef void(^MDWebChatSocketCallBackHandler)(id argsData);

@interface MDWebChatSocket : SocketIO
// 连接
- (void)connectToHost:(NSString *)host onPort:(NSInteger)port withUserID:(NSString *)userID projectID:(NSString *)projectID handler:(MDWebChatSocketConnectionHandler)handler;
- (void)disconnect:(BOOL)forced handler:(MDWebChatSocketConnectionHandler)handler;

// 数据传输
- (void)loginWithStatus:(BOOL)onlineOrHidden handler:(MDWebChatSocketCallBackHandler)handler;
- (void)changeStatusTo:(BOOL)onlineOrHidden handler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadAllUserListWithHandler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadOnlineUserListWithHandler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadJoinedGroupListWithHandler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadUnreadCountWithHanlder:(MDWebChatSocketCallBackHandler)handler;
- (void)loadRecentContactListWithHandler:(MDWebChatSocketCallBackHandler)handler;
- (void)clearUnreadWithType:(BOOL)userOrGroup objectID:(NSString *)objectID handler:(MDWebChatSocketCallBackHandler)handler;
- (void)sendMessageToUserWithUserID:(NSString *)userID message:(NSString *)msg type:(NSInteger)type file:(id)file handler:(MDWebChatSocketCallBackHandler)handler;
- (void)sendMessageToGroupWithGroupID:(NSString *)groupID message:(NSString *)msg type:(NSInteger)type file:(id)file handler:(MDWebChatSocketCallBackHandler)handler;
- (void)createGroupWithName:(NSString *)name userIDs:(NSArray *)userIDs handler:(MDWebChatSocketCallBackHandler)handler;
- (void)renameGroupWithGroupID:(NSString *)groupID groupName:(NSString *)name handler:(MDWebChatSocketCallBackHandler)handler;
- (void)addMemberToGroupWithGroupID:(NSString *)groupID userIDs:(NSArray *)userIDs handler:(MDWebChatSocketCallBackHandler)handler;
- (void)removeUserFromGroupWithGroupID:(NSString *)groupID userIDs:(NSArray *)userIDs handler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadGroupMembersWithGroupID:(NSString *)groupID handler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadUnreadUserMessageListWithUserID:(NSString *)userID count:(NSInteger)count handler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadUserMessageListWithUserID:(NSString *)userID count:(NSInteger)count sinceTime:(NSString *)timeString page:(NSInteger)page handler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadUnreadGroupMessageListWithGroupID:(NSString *)groupID count:(NSInteger)count handler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadGroupMessageListWithGroupID:(NSString *)groupID count:(NSInteger)count sinceTime:(NSString *)timeString page:(NSInteger)page handler:(MDWebChatSocketCallBackHandler)handler;
- (void)loadQiniuTokenAndKeyWithType:(NSInteger)type handler:(MDWebChatSocketCallBackHandler)handler;

// 数据处理
@property (copy, nonatomic) MDWebChatSocketCallBackHandler statusDidChangeHandler, groupJoinedHandler, groupRemovedHandler, newGroupMessageHandler, newUserMessageHandler;
@end
