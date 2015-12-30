//
//  MDAPIManager+Message.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Message.h"
#import <UIKit/UIKit.h>

@implementation MDAPIManager (Message)
#pragma mark - 私信接口
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
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
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
@end
