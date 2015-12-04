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
- (nullable MDURLConnection *)loadPostsWithTagName:(nonnull NSString *)tagName
                                          keywords:(nullable NSString *)keywords
                                             maxID:(nullable NSString *)maxID
                                          pageSize:(nullable NSNumber *)size
                                           handler:(nonnull MDAPINSArrayHandler)handler  
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/tag?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&tag=%@", [tagName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadAllPostsWithKeywords:(nullable NSString *)keywords
                                              postType:(MDPostType)type
                                               sinceID:(nullable NSString *)sinceID
                                                 maxID:(nullable NSString *)maxID
                                              pagesize:(nullable NSNumber *)size
                                               handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", type];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadFavouritedPostsWithKeywords:(nullable NSString *)keywords
                                                     postType:(MDPostType)type
                                                      sinceID:(nullable NSString *)sinceID
                                                        maxID:(nullable NSString *)maxID
                                                     pagesize:(nullable NSNumber *)size
                                                      handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/favorite?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", type];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadReplyMePostsWithKeywords:(nullable NSString *)keywords
                                                     maxID:(nullable NSString *)maxID
                                                  pagesize:(nullable NSNumber *)size
                                                   handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/replyme?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadMyReplyWithKeywords:(nullable NSString *)keywords
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/replybyme?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadAtMePostsWithKeywords:(nullable NSString *)keywords
                                               postType:(MDPostType)type
                                              pageindex:(nullable NSNumber *)pageindex
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/atme_2?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (pageindex) {
        [urlString appendFormat:@"&pageindex=%d", [pageindex intValue]];
    }
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", type];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadMyPostsWithKeywords:(nullable NSString *)keywords
                                             postType:(MDPostType)type
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/my?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (type != -1) {
        [urlString appendFormat:@"&post_type=%d", type];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadUserPostsWithUserID:(nonnull NSString *)userID
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadGroupPostsWithGroupID:(nonnull NSString *)groupID
                                               Keywords:(nullable NSString *)keywords
                                                  maxID:(nullable NSString *)maxID
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/group?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", groupID];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadDocumentPostsWithGroupID:(nullable NSString *)groupID
                                                  Keywords:(nullable NSString *)keywords
                                                filterType:(nullable NSNumber *)filterType
                                                   sinceID:(nullable NSString *)sinceID
                                                     maxID:(nullable NSString *)maxID
                                                  pagesize:(nullable NSNumber *)size
                                                   handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/doc?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupID && groupID.length > 0)
        [urlString appendFormat:@"&g_id=%@", groupID];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (sinceID && sinceID.length > 0)
        [urlString appendFormat:@"&since_id=%@", sinceID];
    if (maxID && maxID.length > 0)
        [urlString appendFormat:@"&max_id=%@", maxID];
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (filterType) {
        [urlString appendFormat:@"&filter_type=%d", [filterType intValue]];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadImagePostsWithGroupID:(nullable NSString *)groupID
                                               Keywords:(nullable NSString *)keywords
                                             filterType:(nullable NSNumber *)filterType
                                                sinceID:(nullable NSString *)sinceID
                                                  maxID:(nullable NSString *)maxID
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler
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
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (filterType)
        [urlString appendFormat:@"&filter_type=%d", [filterType intValue]];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadFAQPostsWithGroupID:(nullable NSString *)groupID
                                             Keywords:(nullable NSString *)keywords
                                           filterType:(nullable NSNumber *)filterType
                                              sinceID:(nullable NSString *)sinceID
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler
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
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (filterType)
        [urlString appendFormat:@"&filter_type=%d", [filterType intValue]];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadVideoPostsWithGroupID:(nullable NSString *)groupID
                                               Keywords:(nullable NSString *)keywords
                                             filterType:(nullable NSNumber *)filterType
                                                sinceID:(nullable NSString *)sinceID
                                                  maxID:(nullable NSString *)maxID
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler
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
    if (size)
        [urlString appendFormat:@"&pagesize=%d", [size intValue]];
    if (filterType)
        [urlString appendFormat:@"&filter_type=%d", [filterType intValue]];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadToppedPostsWithHandler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/list_toppost?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadPostWithPostID:(nonnull NSString *)pID handler:(nonnull MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadPostReplymentsWithPostID:(nonnull NSString *)pID handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/reply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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

- (nullable MDURLConnection *)loadFAQPostBestAnsewerCommentWithPostID:(nonnull NSString *)pID handler:(nonnull MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/v2/qa_thebestcomment?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
- (nullable MDURLConnection *)createTextPostWithText:(nonnull NSString *)text
                                            groupIDs:(nullable NSArray *)groupIDs
                                           shareType:(nullable NSNumber *)shareType
                                             handler:(nonnull MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/update?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    if (shareType) {
        [urlString appendFormat:@"&s_type=%d", [shareType intValue]];
    }
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
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

- (nullable MDURLConnection *)createURLPostWithText:(nullable NSString *)text
                                           urlTitle:(nullable NSString *)title
                                            urlLink:(nullable NSString *)link
                                           groupIDs:(nullable NSArray *)groupIDs
                                          shareType:(nullable NSNumber *)shareType
                                            handler:(nonnull MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/update?format=json"];
    [urlString appendFormat:@"&access_token=%@&p_type=1", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    if (shareType)
        [urlString appendFormat:@"&s_type=%d", [shareType intValue]];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
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

- (nullable MDURLConnection *)createFAQPostWithText:(nullable NSString *)text
                                           groupIDs:(nullable NSArray *)groupIDs
                                          shareType:(nullable NSNumber *)shareType
                                            handler:(nonnull MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/update?format=json"];
    [urlString appendFormat:@"&access_token=%@&p_type=4&is_reward=1", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    if (shareType)
        [urlString appendFormat:@"&s_type=%d", [shareType intValue]];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
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

- (nullable MDURLConnection *)createImagePostWithText:(nullable NSString *)text
                                      images:(nullable NSArray *)images
                                    groupIDs:(nullable NSArray *)groupIDs
                                   shareType:(int)shareType
                                    toCenter:(BOOL)toCenter
                                     handler:(nonnull MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/upload"];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    [parameters addObject:@{@"key":@"f_type", @"object":@"picture"}];
    if (groupIDs && groupIDs.count > 0)
        [parameters addObject:@{@"key":@"g_id", @"object":[groupIDs componentsJoinedByString:@","]}];
    [parameters addObject:@{@"key":@"s_type", @"object":@(shareType)}];
    if (toCenter) {
        [parameters addObject:@{@"key":@"is_center", @"object":@"1"}];
    }
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
            if (parameter && image && fileName) {
                [parameters addObject:@{@"key":parameter, @"object":image, @"fileName":fileName}];
            }
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
                                  shareType:(int)shareType
                                   toCenter:(BOOL)toCenter
                                    handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/upload?format=json"];
    [urlString appendFormat:@"&access_token=%@&f_type=document", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&s_type=%d", shareType];
    if (toCenter) {
        [urlString appendFormat:@"&is_center=%d", 1];
    }
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
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
                                shareType:(int)shareType
                    commentToOriginalPost:(BOOL)yesOrNo
                                  handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/repost?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (groupIDs && groupIDs.count > 0)
        [urlString appendFormat:@"&g_id=%@", [groupIDs componentsJoinedByString:@","]];
    [urlString appendFormat:@"&re_p_id=%@", postID];
    [urlString appendFormat:@"&s_type=%d", shareType];
    if (images.count > 0) {
        [urlString appendFormat:@"&f_type=%@", @"picture"];
    }
    if (yesOrNo) {
        [urlString appendString:@"&withComment=1"];
    }

    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
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
            if (parameter && image && fileName) {
                [parameters addObject:@{@"key":parameter, @"object":image, @"fileName":fileName}];
            }
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
                                               shareType:(int)shareType
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
        [urlString appendFormat:@"&s_type=%d", shareType];
    }
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
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
            if (parameter && image && fileName) {
                [parameters addObject:@{@"key":parameter, @"object":image, @"fileName":fileName}];
            }
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

#pragma mark -
- (MDURLConnection *)loadAllTagsWithKeywords:(NSString *)keywords
                                    pagesize:(int)size
                                        page:(int)page
                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/post/list_tag?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%d", page];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", size];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
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
    [urlString appendFormat:@"&tag=%@", [tagName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

@end
