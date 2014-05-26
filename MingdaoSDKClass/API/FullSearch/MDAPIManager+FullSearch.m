//
//  MDAPIManager+FullSearch.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+FullSearch.h"

@implementation MDAPIManager (FullSearch)

- (MDURLConnection *)loadFullSearchWithKeyWords:(NSString *)keywords filterType:(NSInteger)filterType groupID:(NSString *)gID sinceID:(NSString *)sinceID maxID:(NSString *)maxID pageindex:(NSInteger)page pageSize:(NSInteger)size handler:(MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/search/fullsearch?format=json"];
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    [urlString appendFormat:@"&keywords=%@",keywords];
    if (filterType && filterType >= 0 && filterType <= 8 ) {
        [urlString appendFormat:@"&filter_type=%ld",(long)filterType];
    }
    if (gID && gID.length > 0) {
        [urlString appendFormat:@"&g_id=%@",gID];
    }
    if (sinceID && sinceID.length > 0) {
        [urlString appendFormat:@"&start_date=%@",sinceID];
    }
    if (maxID && maxID.length > 0) {
        [urlString appendFormat:@"&end_date=%@",maxID];
    }
    if (page > 0) {
        [urlString appendFormat:@"&pageindex=%ld",(long)page];
    }
    if (size > 0) {
        [urlString appendFormat:@"&pagesize=%ld",(long)size];
    }
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
        
        handler(dic, error);
    }];
    return connection;
}
@end
