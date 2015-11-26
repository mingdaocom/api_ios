//
//  MDAPIManager+FullSearch.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+FullSearch.h"

@implementation MDAPIManager (FullSearch)

- (nullable MDURLConnection *)loadFullSearchWithKeyWords:(nonnull NSString *)keywords
                                              filterType:(nullable NSNumber *)filterType
                                                 groupID:(nullable NSString *)gID
                                                 sinceID:(nullable NSString *)sinceID
                                                   maxID:(nullable NSString *)maxID
                                               pageindex:(nullable NSNumber *)page
                                                pageSize:(nullable NSNumber *)size
                                                 handler:(nonnull MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/search/fullsearch?format=json"];
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    [urlString appendFormat:@"&keywords=%@",keywords];
    if (filterType && [filterType longValue] >= 0 && [filterType longValue] <= 8 ) {
        [urlString appendFormat:@"&filter_type=%ld",[filterType longValue]];
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
        [urlString appendFormat:@"&pageindex=%ld",[page longValue]];
    }
    if (size > 0) {
        [urlString appendFormat:@"&pagesize=%ld",[size longValue]];
    }
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        handler(dic, error);
    }];
    return connection;
}
@end
