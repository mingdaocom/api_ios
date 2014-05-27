//
//  MDAPIManager+Post.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Post.h"

@implementation MDAPIManager (Post)
#pragma mark - 动态接口

- (MDURLConnection *)loadFollowedPostsWithKeywords:(NSString *)keywords
                                          postType:(MDPostType)type
                                           sinceID:(NSString *)sinceID
                                             maxID:(NSString *)maxID
                                          pagesize:(NSInteger)size
                                           handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%ld", (long)type];
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadPostWithTagName:(NSString *)tagName
                                keywords:(NSString *)keywords
                                   maxID:(NSString *)maxID
                                pageSize:(NSInteger)size
                                 handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/tag?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&tag=%@", tagName];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadAllPostsWithKeywords:(NSString *)keywords
                                     postType:(MDPostType)type
                                      sinceID:(NSString *)sinceID
                                        maxID:(NSString *)maxID
                                     pagesize:(NSInteger)size
                                      handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%ld", (long)type];
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadFavouritedPostsWithKeywords:(NSString *)keywords
                                            postType:(MDPostType)type
                                             sinceID:(NSString *)sinceID
                                               maxID:(NSString *)maxID
                                            pagesize:(NSInteger)size
                                             handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/favorite?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%ld", (long)type];
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadReplyMePostsWithKeywords:(NSString *)keywords
                                            maxID:(NSString *)maxID
                                         pagesize:(NSInteger)size
                                          handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/replyme?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    
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
        
        NSArray *postRepliesDics = [dic objectForKey:@"replyments"];
        NSMutableArray *postReplyments = [NSMutableArray array];
        for (NSDictionary *postReplyDic in postRepliesDics) {
            if (![postReplyDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPostReplyment *postReplyment = [[MDPostReplyment alloc] initWithDictionary:postReplyDic];
            [postReplyments addObject:postReplyment];
        }
        handler(postReplyments, error);
    }];
    return connection;
}

- (MDURLConnection *)loadMyReplyWithKeywords:(NSString *)keywords
                                       maxID:(NSString *)maxID
                                    pagesize:(NSInteger)size
                                     handler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/replybyme?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    
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
        
        NSArray *postRepliesDics = [dic objectForKey:@"replyments"];
        NSMutableArray *postReplyments = [NSMutableArray array];
        for (NSDictionary *postReplyDic in postRepliesDics) {
            if (![postReplyDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPostReplyment *postReplyment = [[MDPostReplyment alloc] initWithDictionary:postReplyDic];
            [postReplyments addObject:postReplyment];
        }
        handler(postReplyments, error);
    }];
    return connection;
}

- (MDURLConnection *)loadAtMePostsWithKeywords:(NSString *)keywords
                                      postType:(MDPostType)type
                                     pageindex:(NSInteger)pageindex
                                      pagesize:(NSInteger)size
                                       handler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/atme_2?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (pageindex > 1) {
        [urlString appendFormat:@"&pageindex=%ld", (long)pageindex];
    }
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%ld", (long)type];
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPostAt *post = [[MDPostAt alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
    
}

- (MDURLConnection *)loadMyPostsWithKeywords:(NSString *)keywords
                                    postType:(MDPostType)type
                                       maxID:(NSString *)maxID
                                    pagesize:(NSInteger)size
                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/my?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%ld", (long)type];
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadUserPostsWithUserID:(NSString *)userID
                                       maxID:(NSString *)maxID
                                    pagesize:(NSInteger)size
                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    
    
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadGroupPostsWithGroupID:(NSString *)groupID
                                      Keywords:(NSString *)keywords
                                         maxID:(NSString *)maxID
                                      pagesize:(NSInteger)size
                                       handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/group?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadDocumentPostsWithGroupID:(NSString *)groupID
                                         Keywords:(NSString *)keywords
                                       filterType:(NSInteger)filterType
                                          sinceID:(NSString *)sinceID
                                            maxID:(NSString *)maxID
                                         pagesize:(NSInteger)size
                                          handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/doc?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupID && groupID.length > 0)
        [urlString appendFormat:@"&g_id=%@", groupID];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (filterType != 0) {
        [urlString appendFormat:@"&filter_type=%ld", (long)filterType];
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadImagePostsWithGroupID:(NSString *)groupID
                                      Keywords:(NSString *)keywords
                                    filterType:(NSInteger)filterType
                                       sinceID:(NSString *)sinceID
                                         maxID:(NSString *)maxID
                                      pagesize:(NSInteger)size
                                       handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/img?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupID && groupID.length > 0)
        [urlString appendFormat:@"&g_id=%@", groupID];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (filterType != 0)
        [urlString appendFormat:@"&filter_type=%ld", (long)filterType];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadFAQPostsWithGroupID:(NSString *)groupID
                                    Keywords:(NSString *)keywords
                                  filterType:(NSInteger)filterType
                                     sinceID:(NSString *)sinceID
                                       maxID:(NSString *)maxID
                                    pagesize:(NSInteger)size
                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/faq?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupID && groupID.length > 0)
        [urlString appendFormat:@"&g_id=%@", groupID];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (filterType != 0)
        [urlString appendFormat:@"&filter_type=%ld", (long)filterType];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadToppedPostsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/list_toppost?format=json"];
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
        
        NSArray *postDics = [dic objectForKey:@"posts"];
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postDic in postDics) {
            if (![postDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
            [posts addObject:post];
        }
        handler(posts, error);
    }];
    return connection;
}

- (MDURLConnection *)loadPostWithPostID:(NSString *)pID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
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
        
        NSDictionary *postDic = [dic objectForKey:@"post"];
        MDPost *post = [[MDPost alloc] initWithDictionary:postDic];
        handler(post, error);
    }];
    return connection;
}

- (MDURLConnection *)loadPostReplymentsWithPostID:(NSString *)pID handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/reply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
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
        
        NSArray *replymentDics = [dic objectForKey:@"replyments"];
        NSMutableArray *replies = [NSMutableArray array];
        for (NSDictionary *replymentDic in replymentDics) {
            if (![replymentDic isKindOfClass:[NSDictionary class]])
                continue;
            MDPostReplyment *reply = [[MDPostReplyment alloc] initWithDictionary:replymentDic];
            [replies addObject:reply];
        }
        handler(replies, error);
    }];
    return connection;
}

- (MDURLConnection *)loadFAQPostBestAnsewerCommentWithPostID:(NSString *)pID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/qa_thebestcomment?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
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
        
        NSDictionary *replymentDic = [dic objectForKey:@"replyment"];
        MDPostReplyment *reply = [[MDPostReplyment alloc] initWithDictionary:replymentDic];
        
        handler(reply, error);
    }];
    return connection;
}

- (MDURLConnection *)createTextPostWithText:(NSString *)text
                                   groupIDs:(NSArray *)groupIDs
                                  shareType:(NSInteger)shareType
                                    handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/update?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *str = [NSString stringWithFormat:@"p_msg=%@", [self localEncode:text]];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:data];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *postID = [dic objectForKey:@"post"];
        handler(postID, error);
    }];
    return connection;
}

- (MDURLConnection *)createURLPostWithText:(NSString *)text
                                  urlTitle:(NSString *)title
                                   urlLink:(NSString *)link
                                  groupIDs:(NSArray *)groupIDs
                                 shareType:(NSInteger)shareType
                                   handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/update?format=json"];
    [urlString appendFormat:@"&access_token=%@&p_type=1", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&l_title=%@", [self localEncode:link]];
    [urlString appendFormat:@"&l_uri=%@", link];
    [urlString appendFormat:@"&p_msg=%@", [self localEncode:text]];
    [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *postID = [dic objectForKey:@"post"];
        handler(postID, error);
    }];
    return connection;
}

- (MDURLConnection *)createFAQPostWithText:(NSString *)text
                                  groupIDs:(NSArray *)groupIDs
                                 shareType:(NSInteger)shareType
                                   handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/update?format=json"];
    [urlString appendFormat:@"&access_token=%@&p_type=4", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    NSString *str = [NSString stringWithFormat:@"p_msg=%@", [self localEncode:text]];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:data];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *postID = [dic objectForKey:@"post"];
        handler(postID, error);
    }];
    return connection;
}

- (MDURLConnection *)createImagePostWithText:(NSString *)text
                                      images:(NSArray *)images
                                    groupIDs:(NSArray *)groupIDs
                                   shareType:(NSInteger)shareType
                                    toCenter:(BOOL)toCenter
                                     handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/upload?format=json"];
    [urlString appendFormat:@"&access_token=%@&f_type=picture", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    if (toCenter) {
        [urlString appendFormat:@"&is_center=%d", 1];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *boundary = @"----------MINGDAO";
    NSString *boundaryPrefix = @"--";
    
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"p_msg"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", [self localEncode:text]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (images.count > 0) {
        for (int i = 0; i < images.count; i++) {
            NSString *filename = [NSString stringWithFormat:@"photo%d.jpg", i];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"p_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\";\r\n\r\n", parameter, filename] dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *imageData = UIImageJPEGRepresentation(images[i], 0.5);
            [postBody appendData:imageData];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
        [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    }
    
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *postID = [dic objectForKey:@"post"];
        handler(postID, error);
    }];
    connection.timeOut = 30 + 30*images.count;
    
    return connection;
}

- (MDURLConnection *)createRepostWithText:(NSString *)text
                                   images:(NSArray *)images
                                   postID:(NSString *)postID
                                 groupIDs:(NSArray *)groupIDs
                                shareType:(NSInteger)shareType
                    commentToOriginalPost:(BOOL)yesOrNo
                                  handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/repost?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&re_p_id=%@", postID];
    [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    if (images.count > 0) {
        [urlString appendFormat:@"&f_type=%@", @"picture"];
    }
    if (yesOrNo) {
        [urlString appendString:@"&withComment=1"];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    if (images.count > 0) {
        NSString *boundary = @"----------MINGDAO";
        NSString *boundaryPrefix = @"--";
        
        NSMutableData *postBody = [NSMutableData data];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"p_msg"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", [self localEncode:text]] dataUsingEncoding:NSUTF8StringEncoding]];
        for (int i = 0; i < images.count; i++) {
            NSString *filename = [NSString stringWithFormat:@"photo%d.jpg", i];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"p_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\";\r\n\r\n", parameter, filename] dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *imageData = UIImageJPEGRepresentation(images[i], 0.5);
            [postBody appendData:imageData];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
        [req setValue:contentType forHTTPHeaderField:@"Content-type"];
        [req setHTTPBody:postBody];
    }
    else {
        NSString *str = [NSString stringWithFormat:@"p_msg=%@", [self localEncode:text]];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:data];
    }
    
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *postID = [dic objectForKey:@"post"];
        handler(postID, error);
    }];
    connection.timeOut = 30 + 30*images.count;
    
    return connection;
}

- (MDURLConnection *)deletePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)createPostReplymentOnPostWithPostID:(NSString *)pID
                         replyToReplymentWithReplymentID:(NSString *)rID
                                                 message:(NSString *)msg
                                                  images:(NSArray *)images
                                              isReshared:(BOOL)yesOrNo
                                                groupIDs:(NSArray *)groupIDs
                                               shareType:(NSInteger)shareType
                                                 handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/add_reply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    if (rID && rID.length > 0)
        [urlString appendFormat:@"&r_id=%@", rID];
    if (images.count > 0) {
        [urlString appendFormat:@"&f_type=%@", @"picture"];
    }
    if (yesOrNo) {
        [urlString appendString:@"&isReshared=1"];
        if (groupIDs && groupIDs.count > 0)
            [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
        [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    }
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    if (images.count > 0) {
        NSString *boundary = @"----------MINGDAO";
        NSString *boundaryPrefix = @"--";
        
        NSMutableData *postBody = [NSMutableData data];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"r_msg"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", [self localEncode:msg]] dataUsingEncoding:NSUTF8StringEncoding]];
        
        for (int i = 0; i < images.count; i++) {
            NSString *filename = [NSString stringWithFormat:@"photo%d.jpg", i];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"p_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\";\r\n\r\n", parameter, filename] dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *imageData = UIImageJPEGRepresentation(images[i], 0.5);
            [postBody appendData:imageData];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
        [req setValue:contentType forHTTPHeaderField:@"Content-type"];
        [req setHTTPBody:postBody];
    }
    else {
        NSString *str = [NSString stringWithFormat:@"r_msg=%@", [self localEncode:msg]];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:data];
    }
    
    
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *replymentID = [dic objectForKey:@"replyment"];
        handler(replymentID, nil);
    }];
    connection.timeOut = 30 + 30*images.count;
    
    return connection;
}

- (MDURLConnection *)deletePostReplymentWithPostID:(NSString *)pID
                                       replymentID:(NSString *)rID
                                           handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/delete_reply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    [urlString appendFormat:@"&r_id=%@", rID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}


- (MDURLConnection *)favouritePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/add_favorite?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unFavouritePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/delete_favorite?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)likePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/add_like?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unLikePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/delete_like?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadAllTagsWithKeywords:(NSString *)keywords
                                    pagesize:(NSInteger)size
                                        page:(NSInteger)page
                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/list_tag?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
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
        
        NSArray *tagDics = [dic objectForKey:@"tags"];
        NSMutableArray *tags = [NSMutableArray array];
        for (NSDictionary *tagDic in tagDics) {
            if (![tagDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTag *tag = [[MDTag alloc] initWithDictionary:tagDic];
            [tags addObject:tag];
        }
        handler(tags, error);
    }];
    return connection;
}

- (MDURLConnection *)addTagToPostWithPostID:(NSString *)pID
                                    tagName:(NSString *)tagName
                                    handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/add_tag?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    [urlString appendFormat:@"&tag=%@", tagName];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteTagFromPostWithPostID:(NSString *)pID
                                         tagName:(NSString *)tagName
                                         handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/delete_tag?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    [urlString appendFormat:@"&tag=%@", tagName];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

@end
