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
    [urlString appendString:@"/mdprivate/group/getWorkSites?format=json"];
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


@end
