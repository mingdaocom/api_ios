//
//  MDAPIManager+Company.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Company.h"

@implementation MDAPIManager (Company)
#pragma mark - 企业网络与管理员接口
- (MDURLConnection *)loadCompanyDetailWithHandler:(MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/company/detail?format=json"];
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
        
        handler(dic, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCompanyCommonTagsWithPageSize:(int)pageSize
                                             pageIndex:(int)pageIndex
                                               handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/company/get_commonCategory?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&pageindex=%d", pageIndex];
    [urlString appendFormat:@"&pagesize=%d", pageSize];

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

- (MDURLConnection *)loadCompanyIsDeploymentSetInfo:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/company/isSetDeployment?access_token=%@&format=json"
                        , self.serverAddress
                        , self.accessToken];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlStr handler:handler];
    }];
    return connection;

}

- (MDURLConnection *)setCompanyName:(NSString *)name handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/company/setCompanyName?access_token=%@&format=json&pName=%@"
                        , self.serverAddress
                        , self.accessToken
                        , name];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)addDeparments:(NSArray *)names handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/company/addProjectDepartment?access_token=%@&format=json&departs=%@"
                        , self.serverAddress
                        , self.accessToken
                        , [names componentsJoinedByString:@","]];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlStr handler:handler];
    }];
    return connection;
}
@end
