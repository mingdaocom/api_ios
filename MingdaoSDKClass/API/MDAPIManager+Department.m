//
//  MDAPIManager+Department.m
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Department.h"

@implementation MDAPIManager (Department)

- (MDURLConnection *)loadAllDepartmentsWithpageSize:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex keyWords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/getDepartments?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&pageSize=%ld",(long)pageSize];
    [urlString appendFormat:@"&pageIndex=%ld",(long)pageIndex];
    if (keywords.length > 0) {
        [urlString appendFormat:@"&keywords=%@",keywords];
    }
    
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
        
        NSArray *departmentDics = [dic objectForKey:@"departments"];
        NSMutableArray *departments = [NSMutableArray array];
        for (NSDictionary *departmentDic in departmentDics) {
            if (![departmentDic isKindOfClass:[NSDictionary class]])
                continue;
            MDDepartment *department = [[MDDepartment alloc] initWithDictionary:departmentDic];
            [departments addObject:department];
        }
        handler(departments, error);
    }];
    return connection;
}

- (MDURLConnection *)loadDepartmentsSeletLimitWithpageSize:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex keyWords:(NSString *)keywords handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/getDepartments?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&pageSize=%ld",(long)pageSize];
    [urlString appendFormat:@"&pageIndex=%ld",(long)pageIndex];
    if (keywords.length > 0) {
        [urlString appendFormat:@"&keywords=%@",keywords];
    }
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
        
        BOOL enabled = [[dic objectForKey:@"isSetting"] boolValue];
        handler(enabled, error);
    }];
    return connection;

}


- (MDURLConnection *)addDepartmentWithName:(NSString *)name mappingGroupID:(NSString *)mappingGroupID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/addDepartment?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&departmentName=%@",name];
    [urlString appendFormat:@"&mappingGroupID=%@",mappingGroupID];
    NSString* encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)editDepartmentWithdepartmentID:(NSString *)departmentID departmentName:(NSString *)departmentName mappingGroupID:(NSString *)mappingGroupID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/editDepartment?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&departmentID=%@",departmentID];
    [urlString appendFormat:@"&departmentName=%@",departmentName];
    [urlString appendFormat:@"&mappingGroupID=%@",mappingGroupID];
    NSString* encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;

}

- (MDURLConnection *)deleteDepartmentWithdepartmentID:(NSString *)departmentID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/deleteDepartments?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&departmentID=%@",departmentID];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)editDeptSiteMembersWithType:(NSInteger)type name:(NSString *)name op:(NSInteger)op userID:(NSString *)userID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/editDeptSiteMembers?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&type=%ld",(long)type];
    [urlString appendFormat:@"&name=%@",name];
    [urlString appendFormat:@"&op=%ld",(long)op];
    [urlString appendFormat:@"&userID=%@",userID];
    NSString* encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;

}

- (MDURLConnection *)editDepartmentSeletLimitWithIsSetting:(NSString *)isSetting handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/mdprivate/group/editDepartmentSetting?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&isSetting=%@",isSetting];
 
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;

}

@end
