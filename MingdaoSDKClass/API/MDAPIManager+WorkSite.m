//
//  MDAPIManager+WorkSite.m
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDAPIManager+WorkSite.h"

@implementation MDAPIManager (WorkSite)

- (MDURLConnection *)loadAllWorkSiteWithpageSize:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex keyWords:(NSString *)keyWords sortType:(NSInteger)sortType handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/getWorkSites?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&pageSize=%ld",(long)pageSize];
    [urlString appendFormat:@"&pageIndex=%ld",(long)pageIndex];
    if (keyWords.length > 0) {
        [urlString appendFormat:@"&keywords=%@",keyWords];
    }
    [urlString appendFormat:@"&sortType=%ld",(long)sortType];
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
        
        NSArray *workSiteDics = [dic objectForKey:@"workSites"];
        NSMutableArray *workSites = [NSMutableArray array];
        for (NSDictionary *workSiteDic in workSiteDics) {
            if (![workSiteDic isKindOfClass:[NSDictionary class]])
                continue;
            MDWorkSite *site = [[MDWorkSite alloc] initWithDictionary:workSiteDic];
            [workSites addObject:site];
        }
        handler(workSites, error);
    }];
    return connection;

}


- (MDURLConnection *)loadWorkSiteSeletLimitWithpageSize:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex keyWords:(NSString *)keyWords sortType:(NSInteger)sortType handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/getWorkSites?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&pageSize=%ld",(long)pageSize];
    [urlString appendFormat:@"&pageIndex=%ld",(long)pageIndex];
    if (keyWords.length > 0) {
        [urlString appendFormat:@"&keywords=%@",keyWords];
    }
    [urlString appendFormat:@"&sortType=%ld",(long)sortType];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(NO, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        BOOL enabled = [[dic objectForKey:@"enabled"] boolValue];
        handler(enabled, error);
    }];
    return connection;

}

- (MDURLConnection *)loadWorkSiteOrDepartmentMemberWithType:(NSInteger)type setValue:(NSString *)setValue handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/getDeartmentWorkSiteMembers?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&type=%ld",(long)type];
    [urlString appendFormat:@"&setValue=%@",setValue];
    NSString* encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]] handler:^(NSData *data, NSError *error){
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
        
        NSArray *workSiteDics = [dic objectForKey:@"members"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *workSiteDic in workSiteDics) {
            if (![workSiteDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:workSiteDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;   
}

- (MDURLConnection *)addWorkSiteWithValue:(NSString *)value handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/addWorkSiteNew?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&value=%@",value];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)setWorkSiteSelectLimitWithvalue:(NSInteger)value handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/updateWorkSiteSetting?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&value=%ld",(long)value];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

@end
