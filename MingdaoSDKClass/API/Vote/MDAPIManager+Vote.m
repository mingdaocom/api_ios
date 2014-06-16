//
//  MDAPIManager+Vote.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Vote.h"

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

- (MDURLConnection *)loadVoteWithVoteID:(NSString *)pID handler:(MDAPIObjectHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/vote/detail?format=json"];
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
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
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    
    NSMutableData *postBody = [NSMutableData data];

    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *boundary = @"----------MINGDAO";
    NSString *boundaryPrefix = @"--";
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"p_msg"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", [self localEncode:text]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"vote_options"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", options] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"vote_lasttime"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", endDateString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"available_number"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%ld\r\n", (long)maxChoice] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (imageOptions) {
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"v_img_options"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", imageOptions] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if (isAnonymous) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"vote_anonymous"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%d\r\n", 1] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if (isVisible) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"vote_visble"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%d\r\n", 1] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if (groupIDs &&groupIDs.count>0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"g_id"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", [groupIDs componentsJoinedByString:@","]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"s_type"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%ld\r\n", (long)shareType] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (images.count > 0) {
        for (int i = 0; i < images.count; i++) {
            NSString *filename = [NSString stringWithFormat:@"photo%d.jpg", i];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"v_img"];
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
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error) {
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
@end
