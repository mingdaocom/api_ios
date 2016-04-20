//
//  MDAPIManager+Passport.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Passport.h"
#import <UIKit/UIKit.h>

@implementation MDAPIManager (Passport)

#pragma mark - 账号接口
- (MDURLConnection *)loadCurrentUserDetailWithHandler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/passport/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
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

- (MDURLConnection *)loadCurrentUserSettingWithHandler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/passport/get_setting?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        handler(dic, error);
    }];
    return connection;
}

- (MDURLConnection *)setCurrentUserSettingWithMentionMeOn:(NSNumber *)mentionOn replymeOn:(NSNumber *)replyOn sysOn:(NSNumber *)sysOn Handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/passport/setuserpush?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (mentionOn) {
        [urlString appendFormat:@"&push_mentioned=%ld", (long)[mentionOn integerValue]];
    }
    if (replyOn) {
        [urlString appendFormat:@"&push_comment=%ld", (long)[replyOn integerValue]];
    }
    if (sysOn) {
        [urlString appendFormat:@"&push_sysmessage=%ld", (long)[sysOn integerValue]];
    }
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserUnreadCountWithHandler:(MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/passport/unreadcount?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        handler(dic, error);
    }];
    return connection;
}

- (MDURLConnection *)logoutWithHandler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/passport/logout?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveUserWithName:(NSString *)name
                           department:(NSString *)dep
                                  job:(NSString *)job
                    mobilePhoneNumber:(NSString *)mpn
                      workPhoneNumber:(NSString *)wpn
                             birthday:(NSString *)birthday
                               gender:(NSInteger)gender
                              handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/passport/edit"];
    
    NSMutableArray *parameters = [NSMutableArray array];
    [parameters addObject:@{@"key":@"format", @"object":@"json"}];
    [parameters addObject:@{@"key":@"access_token", @"object":self.accessToken}];
    if (name && name.length > 0)
        [parameters addObject:@{@"key":@"name", @"object":name}];
    if (dep)
        [parameters addObject:@{@"key":@"dep", @"object":dep}];
    if (job)
        [parameters addObject:@{@"key":@"job", @"object":job}];
    if (mpn)
        [parameters addObject:@{@"key":@"mobile_phone", @"object":mpn}];
    if (wpn)
        [parameters addObject:@{@"key":@"work_phone", @"object":wpn}];
    if (birthday)
        [parameters addObject:@{@"key":@"birth", @"object":birthday}];
    if (gender != 0)
        [parameters addObject:@{@"key":@"gender", @"object":[NSNumber numberWithInteger:gender]}];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self postWithParameters:parameters withRequest:req];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveUserWithAvatar:(UIImage *)avatarImg handler:(MDAPIBoolHandler)handler
{
    NSString *boundary = @"-----------------MINGDAO-----------------";
    NSString *filename = @"photo.jpg";
    
    NSString *urlstr = [NSString stringWithFormat:@"%@/passport/edit_avstar?u_key=%@&format=json"
                        , self.serverAddress
                        , self.accessToken];
    NSURL *url = [[NSURL alloc]initWithString:urlstr];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    
    //准备数据
    NSData *imageData = UIImageJPEGRepresentation(avatarImg, 0.5);
    
    //adding the body:
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_img\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: application/octet-stream; charset=UTF-8\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:imageData];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlstr handler:handler];
    }];
    connection.timeOut = 30 + 30*1;
    
    return connection;
}

- (MDURLConnection *)loadCurrentUserCommonTagsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/passport/get_commonCategory?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
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
@end
