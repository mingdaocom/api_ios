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

- (MDURLConnection *)loadTopMentionedUsersWihtHandler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/get_userMetioned?format=json"];
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

- (MDURLConnection *)loadUserWithUserID:(NSString *)uID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", uID];
    
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

- (MDURLConnection *)loadAllDepartmentsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/department?format=json"];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unfollowUserWithUserID:(NSString *)userID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/delete_followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnectionQueue *)inviteUserToCompanyWithEmail:(NSString *)email
                              baseAuthenticationDomain:(NSString *)baseAuthenticationDomain
                                               handler:(MDAPIQueueBoolHandler)handler;
{
    NSArray *emails = [email componentsSeparatedByString:@","];
    NSMutableArray *requests = [NSMutableArray array];
    for (NSString *s in emails) {
        NSString *anEmail = s;
        NSMutableString *urlString = [self.serverAddress mutableCopy];
        [urlString appendString:@"/user/invite?format=json"];
        [urlString appendFormat:@"&access_token=%@", self.accessToken];
        [urlString appendFormat:@"&email=%@", anEmail];
        [urlString appendFormat:@"&fullname=%@", [anEmail substringToIndex:[anEmail rangeOfString:@"@"].location]];
        [urlString appendFormat:@"&msg=%@", @"这是公司专属的企业和信息协作平台，使用明道网络和您的同事沟通协作，分享文档，问答，图片等，创建群组，并可使用不断增加的企业信息服务和应用程序。"];
        NSInteger type = 1;
        if ([anEmail hasSuffix:baseAuthenticationDomain]) {
            type = 0;
        }
        [urlString appendFormat:@"&type=%ld", (long)type];
        NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [requests addObject:req];
    }
    
    MDURLConnectionQueue *queue = [[MDURLConnectionQueue alloc] initWithRequest:requests handler:^(NSInteger lastFinishedIndex, CGFloat progress, NSData *data, NSError *error){
        
        NSURLRequest *req = requests[lastFinishedIndex];
        if (error) {
            handler(lastFinishedIndex, progress ,NO, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(lastFinishedIndex, progress ,NO, [MDErrorParser errorWithMDDic:dic URLString:req.URL.absoluteString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(lastFinishedIndex,progress ,NO, [MDErrorParser errorWithMDDic:dic URLString:req.URL.absoluteString]);
            return;
        }
        
        if ([[dic objectForKey:@"count"] boolValue]) {
            handler(lastFinishedIndex,progress, YES, error);
        } else {
            handler(lastFinishedIndex,progress ,NO, error);
        }
    }];
    return queue;
}

- (MDURLConnection *)reinviteUserWithEmails:(NSArray *)emails handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/invite/again_inviteuser?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&emails=%@", [emails componentsJoinedByString:@","]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadInvitedUserListWithType:(MDInvitedUserType)type handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/invite/invited_user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&status=%d", type];
    
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

- (MDURLConnection *)loadFavouritedUsersWithHandler:(MDAPIObjectHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/frequent?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unfavouriteUserWithUserID:(NSString *)uID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/user/delete_frequent?format=json"];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

@end
