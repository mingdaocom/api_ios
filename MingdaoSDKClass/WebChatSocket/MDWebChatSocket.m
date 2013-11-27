//
//  MDWebChatSocket.m
//  MingdaoV2
//
//  Created by Wee Tom on 13-11-6.
//  Copyright (c) 2013年 Mingdao. All rights reserved.
//

#import "MDWebChatSocket.h"
#import "SocketIOPacket.h"

@interface MDWebChatSocket () <SocketIODelegate>
@property (copy, nonatomic) MDWebChatSocketConnectionHandler connectHandler, disconnectHandler;
@end

@implementation MDWebChatSocket
- (id)init
{
    self = [super initWithDelegate:self];
    return self;
}

- (void)connectToHost:(NSString *)host onPort:(NSInteger)port withUserID:(NSString *)userID projectID:(NSString *)projectID handler:(MDWebChatSocketConnectionHandler)handler
{
    if (!userID || !projectID) {
        handler(self, [[NSError alloc] init]);
        return;
    }
    self.connectHandler = handler;
    [self connectToHost:host onPort:port withParams:@{@"UserID":userID, @"ProjectID":projectID}];
}

- (void)socketIODidConnect:(SocketIO *)socket
{
    self.connectHandler(self, nil);
    self.connectHandler = nil;
}

- (void)socketIO:(SocketIO *)socket onError:(NSError *)error
{
    if (self.connectHandler) {
        self.connectHandler(self, error);
        return;
    }
    
}

- (void)disconnect:(BOOL)forced handler:(MDWebChatSocketConnectionHandler)handler
{
    self.disconnectHandler = handler;
    if (forced) {
        [self disconnectForced];
    } else {
        [self disconnect];
    }
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    if (self.disconnectHandler) {
        self.disconnectHandler(self, error);
    }
    self.disconnectHandler = nil;
}


#pragma mark - 数据传输
- (void)loginWithStatus:(BOOL)onlineOrHidden handler:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"login" withData:@{@"status":onlineOrHidden?@"1":@"0"} andAcknowledge:handler];
}

- (void)changeStatusTo:(BOOL)onlineOrHidden handler:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"status" withData:@{@"status":onlineOrHidden?@"1":@"0"} andAcknowledge:handler];
}

- (void)loadAllUserListWithHandler:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"user list" withData:@{} andAcknowledge:handler];
}

- (void)loadOnlineUserListWithHandler:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"online users" withData:@{} andAcknowledge:handler];
}

- (void)loadJoinedGroupListWithHandler:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"joined groups" withData:@{} andAcknowledge:handler];
}

- (void)loadUnreadCountWithHanlder:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"unread count" withData:@{} andAcknowledge:handler];
}

- (void)loadRecentContactListWithHandler:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"chat history" withData:@{} andAcknowledge:handler];
}

- (void)clearUnreadWithType:(BOOL)userOrGroup objectID:(NSString *)objectID handler:(MDWebChatSocketCallBackHandler)handler
{
    [self sendEvent:@"clear unread" withData:@{@"type":userOrGroup?@"1":@"2", @"id":objectID} andAcknowledge:handler];
}

- (void)sendMessageToUserWithUserID:(NSString *)userID message:(NSString *)msg type:(NSInteger)type file:(id)file handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    if (msg) {
        [data setObject:msg forKey:@"msg"];
    }
    [data setObject:userID forKey:@"touser"];
    [data setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    if (file) {
        [data setObject:file forKey:@"file"];
    }
    [self sendEvent:@"send message" withData:data andAcknowledge:handler];
}

- (void)sendMessageToGroupWithGroupID:(NSString *)groupID message:(NSString *)msg type:(NSInteger)type file:(id)file handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    if (msg) {
        [data setObject:msg forKey:@"msg"];
    }
    [data setObject:groupID forKey:@"togroup"];
    [data setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    if (file) {
        [data setObject:file forKey:@"file"];
    }
    [self sendEvent:@"send group message" withData:data andAcknowledge:handler];
}

- (void)createGroupWithName:(NSString *)name userIDs:(NSArray *)userIDs handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:name forKey:@"groupname"];
    if (userIDs.count > 0) {
        [data setObject:userIDs forKey:@"userid"];
    }
    [self sendEvent:@"add group" withData:data andAcknowledge:handler];
}
- (void)renameGroupWithGroupID:(NSString *)groupID groupName:(NSString *)name handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:name forKey:@"groupname"];
    [data setObject:groupID forKey:@"groupid"];
    [self sendEvent:@"rename group" withData:data andAcknowledge:handler];
}

- (void)addMemberToGroupWithGroupID:(NSString *)groupID userIDs:(NSArray *)userIDs handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:groupID forKey:@"groupid"];
    [data setObject:userIDs forKey:@"userid"];
    [self sendEvent:@"add member" withData:data andAcknowledge:handler];
}

- (void)removeUserFromGroupWithGroupID:(NSString *)groupID userIDs:(NSArray *)userIDs handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:groupID forKey:@"groupid"];
    [data setObject:userIDs forKey:@"userid"];
    [self sendEvent:@"remove member" withData:data andAcknowledge:handler];
}

- (void)loadGroupMembersWithGroupID:(NSString *)groupID handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:groupID forKey:@"groupid"];
    [self sendEvent:@"group members" withData:data andAcknowledge:handler];
}

- (void)loadUnreadUserMessageListWithUserID:(NSString *)userID count:(NSInteger)count handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:userID forKey:@"userid"];
    [data setObject:[NSNumber numberWithInteger:count] forKey:@"num"];
    [self sendEvent:@"unread message list" withData:data andAcknowledge:handler];
}

- (void)loadUserMessageListWithUserID:(NSString *)userID count:(NSInteger)count sinceTime:(NSString *)timeString page:(NSInteger)page handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:userID forKey:@"userid"];
    [data setObject:[NSNumber numberWithInteger:count] forKey:@"num"];
    if (timeString) {
        [data setObject:timeString forKey:@"sincetime"];
    }
    [data setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self sendEvent:@"message list" withData:data andAcknowledge:handler];
}

- (void)loadUnreadGroupMessageListWithGroupID:(NSString *)groupID count:(NSInteger)count handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:groupID forKey:@"groupid"];
    [data setObject:[NSNumber numberWithInteger:count] forKey:@"num"];
    [self sendEvent:@"unread group message list" withData:data andAcknowledge:handler];
}

- (void)loadGroupMessageListWithGroupID:(NSString *)groupID count:(NSInteger)count sinceTime:(NSString *)timeString page:(NSInteger)page handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:groupID forKey:@"groupid"];
    [data setObject:[NSNumber numberWithInteger:count] forKey:@"num"];
    if (timeString) {
        [data setObject:timeString forKey:@"sincetime"];
    }
    [data setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self sendEvent:@"message list" withData:data andAcknowledge:handler];
}

- (void)loadQiniuTokenAndKeyWithType:(NSInteger)type handler:(MDWebChatSocketCallBackHandler)handler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [self sendEvent:@"upload token" withData:data andAcknowledge:handler];
}
#pragma mark - 数据处理
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"recieved Event: %@ <<<<", packet.name);
    if ([packet.name isEqualToString:@"user status"]) {
        if (self.statusDidChangeHandler) {
            self.statusDidChangeHandler(packet.dataAsJSON);
        }
    } else if ([packet.name isEqualToString:@"new group"]) {
        if (self.groupJoinedHandler) {
            self.groupJoinedHandler(packet.dataAsJSON);
        }
    } else if ([packet.name isEqualToString:@"removed from group"]) {
        if (self.groupRemovedHandler) {
            self.groupRemovedHandler(packet.dataAsJSON);
        }
    } else if ([packet.name isEqualToString:@"new user message"]) {
        if (self.newUserMessageHandler) {
            self.newUserMessageHandler(packet.dataAsJSON);
        }
    } else if ([packet.name isEqualToString:@"new group message"]) {
        if (self.newGroupMessageHandler) {
            self.newGroupMessageHandler(packet.dataAsJSON);
        }
    }
}
@end
