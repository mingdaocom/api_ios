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
- (nullable MDURLConnection *)loadAllGroupsWithKeywords:(nullable NSString *)keywords
                                                handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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

- (nullable MDURLConnection *)loadCurrentUserCreatedGroupsWithHandler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/my_created?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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

- (nullable MDURLConnection *)loadCurrentUserJoinedGroupsWithHandler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/my_joined?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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

- (nullable MDURLConnection *)loadGroupsWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        MDGroup *group = [[MDGroup alloc] initWithDictionary:[dic objectForKey:@"group"]];
        handler(group, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadGroupMembersWithGroupID:(nullable NSString *)gID handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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

- (nullable MDURLConnection *)exitGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/exit?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)joinGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/join?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)closeGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/close?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)openGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/open?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)deleteGroupWithGroupID:(nonnull NSString *)gID handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)createGroupWithGroupName:(nonnull NSString *)gName
                                                detail:(nullable NSString *)detail
                                              isHidden:(nullable NSNumber *)isHidden
                                            isApproval:(nullable NSNumber *)isApproval
                                                isPost:(nullable NSNumber *)isPost
                                                deptID:(nullable NSString *)deptID
                                               handler:(nonnull MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/create"];
    
    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"g_name", @"object":gName}];
    if (detail) {
        [parameters addObject:@{@"key":@"about", @"object":detail}];
    }
    if (isHidden) {
        [parameters addObject:@{@"key":@"is_hidden", @"object":[isHidden boolValue]?@1:@0}];
    }
    if (isApproval) {
        [parameters addObject:@{@"key":@"isApproval", @"object":[isApproval boolValue]?@1:@0}];
    }
    if (isPost) {
        [parameters addObject:@{@"key":@"isPost", @"object":[isPost boolValue]?@1:@0}];
    }
    if (deptID.length > 0) {
        [parameters addObject:@{@"key":@"deptID", @"object":deptID}];
    }

    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self postWithParameters:parameters withRequest:req];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        MDGroup *group = [[MDGroup alloc] initWithDictionary:[dic objectForKey:@"group"]];
        handler(group, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)editGroupWithGroupID:(nonnull NSString *)groupID
                                              name:(nullable NSString *)gName
                                            detail:(nullable NSString *)detail
                                          isHidden:(nullable NSNumber *)isHidden
                                        isApproval:(nullable NSNumber *)isApproval
                                            isPost:(nullable NSNumber *)isPost
                                           handler:(nonnull MDAPIBoolHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/setting"];

    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"g_id", @"object":groupID}];
    if (gName) {
        [parameters addObject:@{@"key":@"g_name", @"object":gName}];
    }
    if (detail) {
        [parameters addObject:@{@"key":@"about", @"object":detail}];
    }
    if (isHidden) {
        [parameters addObject:@{@"key":@"is_hidden", @"object":[isHidden boolValue]?@1:@0}];
    }
    if (isApproval) {
        [parameters addObject:@{@"key":@"isApproval", @"object":[isApproval boolValue]?@1:@0}];
    }
    if (isPost) {
        [parameters addObject:@{@"key":@"isPost", @"object":[isPost boolValue]?@1:@0}];
    }

    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self postWithParameters:parameters withRequest:req];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)inviteUserToGroupWithGroupID:(nonnull NSString *)gID
                                                   userIDs:(nullable NSArray *)userIDs
                                                    emails:(nullable NSArray *)emails
                                              phoneNumbers:(nullable NSArray *)phoneNumbers
                                                   handler:(nonnull MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/v2/invite"];

    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"g_id", @"object":gID}];
    if (userIDs.count > 0) {
        [parameters addObject:@{@"key":@"u_ids", @"object":[userIDs componentsJoinedByString:@","]}];
    }
    if (emails.count > 0) {
        [parameters addObject:@{@"key":@"eGroupEmail", @"object":[emails componentsJoinedByString:@","]}];
    }
    if (phoneNumbers.count > 0) {
        [parameters addObject:@{@"key":@"eGroupMobilePhone", @"object":[phoneNumbers componentsJoinedByString:@","]}];
    }
    
    NSURLRequest *req = [MDAPIManager postWithParameters:parameters baseURL:urlString];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        handler(dic, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)cancelInviteToUserToGroupWithTokens:(nonnull NSArray *)tokens
                                                          handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/groupinvite/close_inviteuser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&tokens=%@", [tokens componentsJoinedByString:@","]];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)loadInvitedUserToGroupListWithType:(MDGroupInviteType)type
                                                         groupID:(nonnull NSString *)groupID
                                                         handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/groupinvite/invited_user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&type=%d", type];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        handler(userDics, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)deleteUserFromGroupID:(nonnull NSString *)gID
                                             userID:(nonnull NSString *)userID
                                            handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/remove_user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)addGroupAdminWithGroupID:(nonnull NSString *)gID
                                                userID:(nonnull NSString *)userID
                                               handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/add_admin?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)removeGroupAdminWithGroupID:(nonnull NSString *)gID
                                                   userID:(nonnull NSString *)userID
                                                  handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/remove_admin?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)loadUnauditedUsersOfGroupID:(nonnull NSString *)groupID
                                                  handler:(nonnull MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/get_unauditedUsers?format=json"];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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

- (nullable MDURLConnection *)passUserID:(nonnull NSString *)userID
                               toGroupID:(nonnull NSString *)groupID
                                 handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/pass_unauditedUser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&u_ids=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)refuseUserID:(nonnull NSString *)userID
                               fromGroupID:(nonnull NSString *)groupID
                                   handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/refuse_unauditedUser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)loadEGroupUsersListWithHandler:(nonnull MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/my_withegroupgroup.aspx?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSArray *userDics = [dic objectForKey:@"groups"];
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
        NSMutableArray *groups = [NSMutableArray array];
        NSMutableArray *users = [NSMutableArray array];
        
        for (NSDictionary *dic in userDics) {
            MDGroup *group = [[MDGroup alloc] init];
            group.objectID = dic[@"id"];
            group.objectName = dic[@"name"];
            group.avatar = dic[@"avatar"];
            [groups addObject:group];
            
            NSMutableArray *members = [NSMutableArray array];
            NSArray *memberDics = dic[@"members"];
            for (NSDictionary *memDic in memberDics) {
                MDUser *user = [[MDUser alloc] initWithDictionary:memDic];
                [members addObject:user];
            }
            [users addObject:members];
        }
        [resultDic setObject:groups forKey:@"Groups"];
        [resultDic setObject:users forKey:@"Users"];
        handler(resultDic, error);
    }];
    return connection;
}


- (nullable MDURLConnection *)chatToPostWithChatGroupID:(nonnull NSString *)groupID
                                                handler:(nonnull MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/group/chatToPost.aspx?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;

}

@end
