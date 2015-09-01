//
//  MDAPIManager+User.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+User.h"

@implementation MDAPIManager (User)
#pragma mark - 用户接口
- (MDURLConnection *)loadAllUsersWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/all?format=json"];
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

- (MDURLConnection *)loadTopMentionedUsersWihtHandler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/get_userMetioned?format=json"];
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

- (MDURLConnection *)loadUsersWithKeywords:(NSString *)keywords
                                   groupID:(NSString *)gID
                                department:(NSString *)dep
                                   handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/search?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (gID && gID.length > 0)
        [urlString appendFormat:@"&g_id=%@", gID];
    if (dep && dep.length > 0)
        [urlString appendFormat:@"&dep=%@", dep];
    
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

- (MDURLConnection *)loadUserWithUserID:(NSString *)uID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        MDUser *aUser = [[MDUser alloc] initWithDictionary:[dic objectForKey:@"user"]];
        handler(aUser, error);
    }];
    return connection;
}

- (MDURLConnection *)loadUserFollowedByUserWithUserID:(NSString *)uID
                                              handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", uID];
    
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

- (MDURLConnection *)loadAllDepartmentsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/department?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSArray *depDics = [dic objectForKey:@"departments"];
        NSMutableArray *deps = [NSMutableArray array];
        for (NSDictionary *depDic in depDics) {
            if (![depDic isKindOfClass:[NSDictionary class]])
                continue;
            NSString *dep = [depDic objectForKey:@"name"];
            if (dep && dep.length > 0)
                [deps addObject:dep];
        }
        handler(deps, error);
    }];
    return connection;
}

- (MDURLConnection *)followUserWithUserID:(NSString *)userID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/add_followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unfollowUserWithUserID:(NSString *)userID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/delete_followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)inviteUserToCompanyWithEmails:(NSString *)emails
                                            phones:(NSString *)phones
                                           handler:(MDAPINSDictionaryHandler)handler;
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/v2/invite"];
    
    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    if (emails && emails.length > 0)
        [parameters addObject:@{@"key":@"emails", @"object":emails}];
    if (phones && phones.length > 0)
        [parameters addObject:@{@"key":@"mobilePhones", @"object":phones}];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self postWithParameters:parameters withRequest:req];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        handler(dic, error);
    }];
    return connection;
}

- (MDURLConnection *)reinviteUserWithEmails:(NSArray *)emails handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/invite/again_inviteuser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&emails=%@", [emails componentsJoinedByString:@","]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)cancelInviteToUserWithEmails:(NSArray *)emails tokens:(NSArray *)tokens handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/invite/close_inviteuser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&emails=%@", [emails componentsJoinedByString:@","]];
    [urlString appendFormat:@"&tokens=%@", [tokens componentsJoinedByString:@","]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadInvitedUserListWithType:(MDInvitedUserType)type handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/invite/invited_user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&status=%d", type];
    
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

- (MDURLConnection *)loadFavouritedUsersWithHandler:(MDAPIObjectHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/frequent?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (MDURLConnection *)favouriteUserWithUserID:(NSString *)uID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/add_frequent?format=json"];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unfavouriteUserWithUserID:(NSString *)uID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/delete_frequent?format=json"];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}
@end
