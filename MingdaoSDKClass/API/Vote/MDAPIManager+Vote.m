//
//  MDAPIManager+Vote.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Vote.h"
#import <UIKit/UIKit.h>

@implementation MDAPIManager (Vote)
#pragma mark - 投票接口
- (MDURLConnection *)loadCurrentUserJoinedVotesWithPageIndex:(NSInteger)page
                                                    keywords:(NSString *)keywords
                                                    pagesize:(NSInteger)size
                                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/vote/my_joined?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
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

- (MDURLConnection *)loadCurrentUserCreatedVotesWithPageIndex:(NSInteger)page
                                                     keywords:(NSString *)keywords
                                                     pagesize:(NSInteger)size
                                                      handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/vote/my_create?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
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

- (MDURLConnection *)loadAllVotesWithPageIndex:(NSInteger)page
                                      keywords:(NSString *)keywords
                                      pagesize:(NSInteger)size
                                       handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/vote/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (page > 1)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
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

- (MDURLConnection *)loadVoteWithVoteID:(NSString *)pID handler:(MDAPIObjectHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/vote/detail?format=json"];
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

- (MDURLConnection *)castOptionOnVoteWithVoteID:(NSString *)pID
                                   optionString:(NSString *)optionString
                                        handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/vote/cast_options?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&p_id=%@", pID];
    [urlString appendFormat:@"&options=%@", optionString];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)createPollPostWithText:(NSString *)text
                                    options:(NSString *)options
                                     images:(NSArray *)images
                               imageOptions:(NSString *)imageOptions
                              endDateString:(NSString *)endDateString
                                  maxChoice:(NSInteger)maxChoice
                                isAnonymous:(BOOL)isAnonymous
                                  isVisible:(BOOL)isVisible
                                   groupIDs:(NSArray *)groupIDs
                                  shareType:(NSInteger)shareType
                                    handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/vote/create?format=json"];
    
    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"", @"object":@""}];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    [parameters addObject:@{@"key":@"p_msg", @"object":text}];
    [parameters addObject:@{@"key":@"vote_options", @"object":options}];
    [parameters addObject:@{@"key":@"vote_lasttime", @"object":endDateString}];
    [parameters addObject:@{@"key":@"available_number", @"object":[NSNumber numberWithInteger:maxChoice]}];
    if (imageOptions) {
        [parameters addObject:@{@"key":@"v_img_options", @"object":imageOptions}];
    }
    if (isAnonymous) {
        [parameters addObject:@{@"key":@"vote_anonymous", @"object":@1}];
    }
    if (isVisible) {
        [parameters addObject:@{@"key":@"vote_visble", @"object":@1}];
    }
    if (groupIDs &&groupIDs.count>0) {
        [parameters addObject:@{@"key":@"g_id", @"object":[groupIDs componentsJoinedByString:@","]}];
    }
    [parameters addObject:@{@"key":@"s_type", @"object":[NSNumber numberWithInteger:shareType]}];
    if (images.count > 0) {
        for (int i = 0; i < images.count; i++) {
            NSString *filename = [NSString stringWithFormat:@"photo%d.jpg", i];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"v_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            [parameters addObject:@{@"key":parameter, @"fileName":filename, @"object":images[i]}];
        }
    }
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
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
@end
