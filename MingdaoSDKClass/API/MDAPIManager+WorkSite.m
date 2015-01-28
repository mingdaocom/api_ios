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
    [urlString appendFormat:@"sortType=%ld",(long)sortType];
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


@end
