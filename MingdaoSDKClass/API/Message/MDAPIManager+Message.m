//
//  MDAPIManager+Message.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Message.h"

@implementation MDAPIManager (Message)
#pragma mark - 私信接口
- (MDURLConnection *)loadCurrentUserMessagesWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/message/all?format=json"];
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
        
        NSArray *messagesDic = [dic objectForKey:@"messages"];
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *messageDic in messagesDic) {
            if (![messageDic isKindOfClass:[NSDictionary class]])
                continue;
            MDMessageAll *message = [[MDMessageAll alloc] initWithDictionary:messageDic];
            [messages addObject:message];
        }
        handler(messages, error);
    }];
    return connection;
}

- (MDURLConnection *)loadMessagesWithUserID:(NSString *)userID
                                   pageSize:(NSInteger)size
                                       page:(NSInteger)pages
                                    handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/message/v2/msg_list?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    [urlString appendFormat:@"&pageindex=%ld", (long)pages];
    [urlString appendFormat:@"&pagesize=%ld", (long)size];
    
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
        
        NSArray *messageDics = [dic objectForKey:@"messages"];
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *messageDic in messageDics) {
            if (![messageDic isKindOfClass:[NSDictionary class]])
                continue;
            MDMessage *message = [[MDMessage alloc] initWithDictionary:messageDic];
            [messages addObject:message];
        }
        handler(messages, error);
    }];
    return connection;
}

- (MDURLConnection *)sendMessageToUserID:(NSString *)userID
                                 message:(NSString *)text
                                  images:(NSArray *)images
                                 handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/message/create?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    if (images.count > 0) {
        [urlString appendFormat:@"&f_type=%d", 0];
    }
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [req setHTTPMethod:@"POST"];
    
    if (images.count > 0) {
        
        NSString *boundary = @"----------MINGDAO";
        NSString *boundaryPrefix = @"--";
        
        NSMutableData *postBody = [NSMutableData data];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"msg"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", text] dataUsingEncoding:NSUTF8StringEncoding]];
        
        for (int i = 0; i < images.count; i++) {
            NSString *filename = [NSString stringWithFormat:@"photo%d.jpg", i];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"m_img"];
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
        NSString *str = [NSString stringWithFormat:@"msg=%@", [self localEncode:text]];
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
        
        NSString *objectID = [dic objectForKey:@"message"];
        handler(objectID, error);
    }];
    return connection;
}

- (MDURLConnection *)deleteMessageWithMessageID:(NSString *)mID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/message/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&m_id=%@", mID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)markMessageAsReadWithMessageID:(NSString *)mID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/message/read?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&m_id=%@", mID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

@end
