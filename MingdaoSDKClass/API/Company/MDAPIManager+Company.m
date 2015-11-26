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
- (nullable MDURLConnection *)loadCompanyDetailWithHandler:(nonnull MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/company/detail?format=json"];
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

- (nullable MDURLConnection *)loadCompanyCommonTagsWithPageSize:(nullable NSNumber *)pageSize
                                                      pageIndex:(nullable NSNumber *)pageIndex
                                                        handler:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/company/get_commonCategory?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (pageIndex) {
        [urlString appendFormat:@"&pageindex=%d", [pageIndex intValue]];
    }
    if (pageSize) {
        [urlString appendFormat:@"&pagesize=%d", [pageSize intValue]];
    }
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

- (nullable MDURLConnection *)loadCompanyIsDeploymentSetInfo:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/company/isSetDeployment?access_token=%@&format=json"
                        , self.serverAddress
                        , self.accessToken];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;

}

- (nullable MDURLConnection *)setCompanyName:(nonnull NSString *)name
                                     handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/company/setCompanyName?access_token=%@&format=json&pName=%@"
                        , self.serverAddress
                        , self.accessToken
                        , name];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)addDeparments:(nonnull NSArray *)names
                                    handler:(nonnull MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/company/addProjectDepartment?access_token=%@&format=json&departs=%@"
                        , self.serverAddress
                        , self.accessToken
                        , [names componentsJoinedByString:@","]];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        [self handleBoolData:dic error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (nullable MDURLConnection *)loadGeoInfo:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/company/getFixedData?format=json&type=2"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSArray *geos = dic[@"geographies"];
        handler(geos, error);
    }];
    return connection;
}

- (nullable MDURLConnection *)loadIndustryInfo:(nonnull MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/company/getFixedData?format=json&type=1"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        NSArray *industries = dic[@"industries"];
        handler(industries, error);
    }];
    return connection;
}
@end
