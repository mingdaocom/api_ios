//
//  MDAPIManager+Group.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Group.h"

@implementation MDAPIManager (Group)

#pragma mark - 群组接口
- (MDURLConnection *)loadAllGroupsWithKeywords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *groupDics = [dic objectForKey:@"groups"];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *groupDic in groupDics) {
            if (![groupDic isKindOfClass:[NSDictionary class]])
                continue;
            MDGroup *group = [[MDGroup alloc] initWithDictionary:groupDic];
            [groups addObject:group];
        }
        handler(groups, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserCreatedGroupsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/my_created?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *groupDics = [dic objectForKey:@"groups"];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *groupDic in groupDics) {
            if (![groupDic isKindOfClass:[NSDictionary class]])
                continue;
            MDGroup *group = [[MDGroup alloc] initWithDictionary:groupDic];
            [groups addObject:group];
        }
        handler(groups, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserJoinedGroupsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/my_joined?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *groupDics = [dic objectForKey:@"groups"];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *groupDic in groupDics) {
            if (![groupDic isKindOfClass:[NSDictionary class]])
                continue;
            MDGroup *group = [[MDGroup alloc] initWithDictionary:groupDic];
            [groups addObject:group];
        }
        handler(groups, error);
    }];
    return connection;
}

- (MDURLConnection *)loadGroupsWithGroupID:(NSString *)gID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        MDGroup *group = [[MDGroup alloc] initWithDictionary:[dic objectForKey:@"group"]];
        handler(group, error);
    }];
    return connection;
}

- (MDURLConnection *)loadGroupMembersWithGroupID:(NSString *)gID handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userDic in userDics) {
            if (![userDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:userDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;
}

- (MDURLConnection *)exitGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/exit?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)joinGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/join?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)closeGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/close?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)openGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/open?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)createGroupWithGroupName:(NSString *)gName
                                       detail:(NSString *)detail
                                     isPublic:(BOOL)isPub
                                     isHidden:(BOOL)isHidden
                                      handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/create?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_name=%@", [self localEncode:gName]];
    [urlString appendFormat:@"&about=%@", [self  localEncode:detail]];
    [urlString appendFormat:@"&is_public=%d", isPub?1:0];
    if (!isPub) {
        [urlString appendFormat:@"&is_hidden=%d", isHidden?1:0];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        MDGroup *group = [[MDGroup alloc] initWithDictionary:[dic objectForKey:@"group"]];
        handler(group, error);
    }];
    return connection;
}

- (MDURLConnection *)editGroupWithGroupID:(NSString *)groupID
                                     name:(NSString *)gName
                                   detail:(NSString *)detail
                                 isPublic:(BOOL)isPub
                                 isHidden:(BOOL)isHidden
                                  handler:(MDAPIBoolHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/setting?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&g_name=%@", [self localEncode:gName]];
    [urlString appendFormat:@"&about=%@", [self localEncode:detail]];
    [urlString appendFormat:@"&is_public=%d", isPub?1:0];
    if (!isPub) {
        [urlString appendFormat:@"&is_hidden=%d", isHidden?1:0];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)inviteUserToGroupWithGroupID:(NSString *)gID
                                           emails:(NSArray *)emails
                                       inviteType:(NSInteger)type
                                          handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/groupinvite/again_inviteuser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&invite_type=%ld", (long)type];
    [urlString appendFormat:@"&emails=%@", [emails componentsJoinedByString:@","]];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)cancelInviteToUserToGroupWithTokens:(NSArray *)tokens
                                                 handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/groupinvite/close_inviteuser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&tokens=%@", [tokens componentsJoinedByString:@","]];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadInvitedUserToGroupListWithType:(MDGroupInviteType)type
                                                groupID:(NSString *)groupID
                                                handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/groupinvite/invited_user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&type=%d", type];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        handler(userDics, error);
    }];
    return connection;
}

- (MDURLConnection *)deleteUserFromGroupID:(NSString *)gID
                                    userID:(NSString *)userID
                                   handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/remove_user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)addGroupAdminWithGroupID:(NSString *)gID
                                       userID:(NSString *)userID
                                      handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/add_admin?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)removeGroupAdminWithGroupID:(NSString *)gID
                                          userID:(NSString *)userID
                                         handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/remove_admin?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadUnauditedUsersOfGroupID:(NSString *)groupID
                                         handler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/get_unauditedUsers?format=json"];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userDic in userDics) {
            if (![userDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:userDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;
}

- (MDURLConnection *)passUserID:(NSString *)userID
                      toGroupID:(NSString *)groupID
                        handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/pass_unauditedUser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&u_ids=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)refuseUserID:(NSString *)userID
                      fromGroupID:(NSString *)groupID
                          handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/refuse_unauditedUser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

@end
