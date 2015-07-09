//
//  MDAPIManager+Post.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Post.h"
#import <UIKit/UIKit.h>

@implementation MDAPIManager (Post)
#pragma mark -
- (MDURLConnection *)loadPostWithTagName:(NSString *)tagName
                                keywords:(NSString *)keywords
                                   maxID:(NSString *)maxID
                                pageSize:(NSInteger)size
                                 handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/tag?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&tag=%@", tagName];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", (int)type];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/favorite?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", (int)type];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/replyme?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/replybyme?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
                                     pageindex:(int)pageindex
                                      pagesize:(int)size
                                       handler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/atme_2?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (pageindex > 1) {
        [urlString appendFormat:@"&pageindex=%d", pageindex];
    }
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", (int)type];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/my?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", (int)type];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/group?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/doc?format=json"];
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
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (filterType != 0) {
        [urlString appendFormat:@"&filter_type=%d", (int)filterType];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/img?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupID && groupID.length > 0)
        [urlString appendFormat:@"&g_id=%@", groupID];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (filterType != 0)
        [urlString appendFormat:@"&filter_type=%d", (int)filterType];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/faq?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupID && groupID.length > 0)
        [urlString appendFormat:@"&g_id=%@", groupID];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (filterType != 0)
        [urlString appendFormat:@"&filter_type=%d", (int)filterType];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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

- (MDURLConnection *)loadVideoPostsWithGroupID:(NSString *)groupID
                                      Keywords:(NSString *)keywords
                                    filterType:(NSInteger)filterType
                                       sinceID:(NSString *)sinceID
                                         maxID:(NSString *)maxID
                                      pagesize:(NSInteger)size
                                       handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/video?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupID && groupID.length > 0)
        [urlString appendFormat:@"&g_id=%@", groupID];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", (int)size];
    if (filterType != 0)
        [urlString appendFormat:@"&filter_type=%d", (int)filterType];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/list_toppost?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/reply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendString:@"/post/v2/qa_thebestcomment?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSDictionary *replymentDic = [dic objectForKey:@"replyment"];
        MDPostReplyment *reply = [[MDPostReplyment alloc] initWithDictionary:replymentDic];
        
        handler(reply, error);
    }];
    return connection;
}

#pragma mark -
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
    
    NSMutableArray *parameters = [NSMutableArray array];
    if (text) {
        [parameters addObject:@{@"key":@"p_msg", @"object":text}];
    }
    [self postWithParameters:parameters withRequest:req];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *str = [NSString stringWithFormat:@"p_msg=%@&l_title=%@&l_uri=%@", [self localEncode:text], [self localEncode:title], [self localEncode:link]];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:data];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    [urlString appendFormat:@"&access_token=%@&p_type=4&is_reward=1", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&s_type=%d", (int)shareType];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSMutableArray *parameters = [NSMutableArray array];
    if (text) {
        [parameters addObject:@{@"key":@"p_msg", @"object":text}];
    }
    [self postWithParameters:parameters withRequest:req];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    NSMutableArray *parameters = [NSMutableArray array];
    if (text) {
        [parameters addObject:@{@"key":@"p_msg", @"object":text}];
    }
    if (images.count > 0) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSString *fileName = [NSString stringWithFormat:@"photo%d.jpg", i+1];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"p_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            [parameters addObject:@{@"key":parameter, @"object":image, @"fileName":fileName}];
        }
    }
    [self postWithParameters:parameters withRequest:req];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSString *postID = [dic objectForKey:@"post"];
        handler(postID, error);
    }];
    connection.timeOut = 30 + 30*images.count;
    
    return connection;
}

- (MDURLConnection *)createFilePostWithText:(NSString *)text
                                   fileName:(NSString *)fileName
                                       file:(NSData *)fileData
                                   groupIDs:(NSArray *)groupIDs
                                  shareType:(NSInteger)shareType
                                   toCenter:(BOOL)toCenter
                                    handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/upload?format=json"];
    [urlString appendFormat:@"&access_token=%@&f_type=document", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&s_type=%ld", (long)shareType];
    if (toCenter) {
        [urlString appendFormat:@"&is_center=%d", 1];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSMutableArray *parameters = [NSMutableArray array];
    if (text) {
        [parameters addObject:@{@"key":@"p_msg", @"object":text}];
    }
    if (fileName && fileData) {
        [parameters addObject:@{@"key":@"p_doc", @"object":fileData, @"fileName":fileName}];
    }
    [self postWithParameters:parameters withRequest:req];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSString *postID = [dic objectForKey:@"post"];
        handler(postID, error);
    }];
    connection.timeOut = 24*60*60;
    
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
    NSMutableArray *parameters = [NSMutableArray array];
    if (text) {
        [parameters addObject:@{@"key":@"p_msg", @"object":text}];
    }
    if (images.count > 0) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSString *fileName = [NSString stringWithFormat:@"photo%d.jpg", i+1];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"p_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            [parameters addObject:@{@"key":parameter, @"object":image, @"fileName":fileName}];
        }
    }
    [self postWithParameters:parameters withRequest:req];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

#pragma mark -
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
    NSMutableArray *parameters = [NSMutableArray array];
    if (msg) {
        [parameters addObject:@{@"key":@"r_msg", @"object":msg}];
    }
    if (images.count > 0) {
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSString *fileName = [NSString stringWithFormat:@"photo%d.jpg", i+1];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"p_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            [parameters addObject:@{@"key":parameter, @"object":image, @"fileName":fileName}];
        }
    }
    [self postWithParameters:parameters withRequest:req];
    
    
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

#pragma mark -
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

@end
