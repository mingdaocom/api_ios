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

- (MDURLConnection *)loadCurrentUserCreatedGroupsWithHandler:(MDAPINSArrayHandler)handler
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

- (MDURLConnection *)loadCurrentUserJoinedGroupsWithHandler:(MDAPINSArrayHandler)handler
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

- (MDURLConnection *)loadGroupsWithGroupID:(NSString *)gID handler:(MDAPIObjectHandler)handler
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

- (MDURLConnection *)loadGroupMembersWithGroupID:(NSString *)gID handler:(MDAPINSArrayHandler)handler
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

- (MDURLConnection *)exitGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
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

- (MDURLConnection *)joinGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
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

- (MDURLConnection *)closeGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
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

- (MDURLConnection *)openGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
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

- (MDURLConnection *)deleteGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
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

- (MDURLConnection *)createGroupWithGroupName:(NSString *)gName
                                       detail:(NSString *)detail
                                     isHidden:(BOOL)isHidden
                                   isApproval:(BOOL)isApproval
                                       isPost:(BOOL)isPost
                                       deptID:(NSString *)deptID
                                      handler:(MDAPIObjectHandler)handler
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
    [parameters addObject:@{@"key":@"isApproval", @"object":isApproval?@1:@0}];
    [parameters addObject:@{@"key":@"isPost", @"object":isPost?@1:@0}];
    [parameters addObject:@{@"key":@"is_hidden", @"object":isHidden?@1:@0}];
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

- (MDURLConnection *)editGroupWithGroupID:(NSString *)groupID
                                     name:(NSString *)gName
                                   detail:(NSString *)detail
                                 isHidden:(NSNumber *)isHidden
                               isApproval:(NSNumber *)isApproval
                                   isPost:(NSNumber *)isPost
                                  handler:(MDAPIBoolHandler)handler
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

- (MDURLConnection *)inviteUserToGroupWithGroupID:(NSString *)gID
                                          userIDs:(NSArray *)userIDs
                                           emails:(NSArray *)emails
                                     phoneNumbers:(NSArray *)phoneNumbers
                                          handler:(MDAPINSDictionaryHandler)handler
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

- (MDURLConnection *)cancelInviteToUserToGroupWithTokens:(NSArray *)tokens
                                                 handler:(MDAPIBoolHandler)handler
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

- (MDURLConnection *)loadInvitedUserToGroupListWithType:(MDGroupInviteType)type
                                                groupID:(NSString *)groupID
                                                handler:(MDAPINSArrayHandler)handler
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadEGroupUsersListWithHandler:(MDAPINSDictionaryHandler)handler
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


- (MDURLConnection *)chatToPostWithChatGroupID:(NSString *)groupID
                                       handler:(MDAPIBoolHandler)handler
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
