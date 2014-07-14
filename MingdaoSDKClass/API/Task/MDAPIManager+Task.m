//
//  MDAPIManager+Task.m
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager+Task.h"

@implementation MDAPIManager (Task)

#pragma mark - 任务接口
- (MDURLConnection *)loadCurrentUserJoinedTasksWithKeywords:(NSString *)keywords
                                            allOrUnfinished:(BOOL)allOrUnFinished
                                                    handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_joined?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (allOrUnFinished)
        [urlString appendString:@"&f_type=0"];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserJoinedFinishedTasksWithPageSize:(NSInteger)size
                                                               page:(NSInteger)page
                                                            handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_joined_finished?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserAssignedTasksWithKeywords:(NSString *)keywords
                                              allOrUnfinished:(BOOL)allOrUnFinished
                                                      handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_assign?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (allOrUnFinished)
        [urlString appendString:@"&f_type=0"];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserAssignedFinishedTasksWithPageSize:(NSInteger)size
                                                                 page:(NSInteger)page
                                                              handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_assign_finished?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserChargedTasksWithKeywords:(NSString *)keywords
                                             allOrUnfinished:(BOOL)allOrUnFinished
                                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_charge?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (allOrUnFinished)
        [urlString appendString:@"&f_type=0"];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserChargedFinishedTasksWithPageSize:(NSInteger)size
                                                                page:(NSInteger)page
                                                             handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_charge_finished?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadProjectsWithKeywords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/project?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    
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
        
        NSArray *projectDics = [dic objectForKey:@"projects"];
        NSMutableArray *projects = [NSMutableArray array];
        for (NSDictionary *projectDic in projectDics) {
            if (![projectDic isKindOfClass:[NSDictionary class]])
                continue;
            MDProject *task = [[MDProject alloc] initWithDictionary:projectDic];
            [projects addObject:task];
        }
        handler(projects, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserObservedTasksWithKeywords:(NSString *)keywords allOrUnfinished:(BOOL)allOrUnFinished handler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_observer?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (allOrUnFinished)
        [urlString appendString:@"&f_type=0"];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
    
}

- (MDURLConnection *)loadCurrentUserObservedFinishedTasksWithPageSize:(NSInteger)size
                                                                 page:(NSInteger)page
                                                              handler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/my_observer_finished?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%ld", (long)page];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadTaskWithTaskID:(NSString *)tID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
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
        
        NSDictionary *projectDic = [dic objectForKey:@"task"];
        MDTask *task = [[MDTask alloc] initWithDictionary:projectDic];
        handler(task, error);
    }];
    return connection;
}

- (MDURLConnection *)loadTaskReplymentsWithTaskID:(NSString *)tID
                                         onlyFile:(BOOL)onlyFile
                                            maxID:(NSString *)maxTID
                                         pageSize:(NSInteger)size
                                          handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/getTopicListByTaskID?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    if (maxTID)
        [urlString appendFormat:@"&max_id=%@", maxTID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%ld", (long)size];
    if (onlyFile) {
        [urlString appendFormat:@"&is_onlyFile=%d", 1];
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
        
        NSArray *replyDics = [dic objectForKey:@"replyments"];
        NSMutableArray *replies = [NSMutableArray array];
        for (NSDictionary *replyDic in replyDics) {
            if (![replyDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTaskReplyment *reply = [[MDTaskReplyment alloc] initWithDictionary:replyDic];
            [replies addObject:reply];
        }
        handler(replies, error);
    }];
    return connection;
}

- (MDURLConnection *)createTaskWithTaskName:(NSString *)name
                                description:(NSString *)des
                              endDateString:(NSString *)endDateString
                                  chargerID:(NSString *)chargerID
                                  memberIDs:(NSArray *)memberIDs
                                  projectID:(NSString *)projectID
                                   parentID:(NSString *)parentID
                                    handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/create?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_title=%@", name];
    
    if (endDateString && endDateString.length > 0)
        [urlString appendFormat:@"&t_ed=%@", endDateString];
    if (memberIDs && memberIDs.count > 0)
        [urlString appendFormat:@"&t_mids=%@", [memberIDs componentsJoinedByString:@","]];
    if (chargerID && chargerID.length > 0)
        [urlString appendFormat:@"&u_id=%@", chargerID];
    if (projectID && projectID.length > 0)
        [urlString appendFormat:@"&t_pid=%@", projectID];
    if (parentID && parentID.length > 0) {
        [urlString appendFormat:@"&t_parentID=%@", parentID];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    if (des && des.length > 0) {
        NSString *str = [NSString stringWithFormat:@"t_des=%@", des];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:data];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *taskID = [dic objectForKey:@"task"];
        handler(taskID, nil);
    }];
    return connection;
}

- (MDURLConnection *)createProjectWithName:(NSString *)name handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/add_project?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&title=%@", name];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *projectID = [dic objectForKey:@"project"];
        handler(projectID, nil);
    }];
    return connection;
}

- (MDURLConnection *)createTaskReplymentOnTaskWithTaskID:(NSString *)tID
                                                 message:(NSString *)message
                                 replyToReplymentWithRID:(NSString *)rID
                                                  images:(NSArray *)images
                                                 handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/addreply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    if (rID && rID.length > 0)
        [urlString appendFormat:@"&r_id=%@", rID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    if (images.count > 0) {
        NSString *boundary = @"----------MINGDAO";
        NSString *boundaryPrefix = @"--";
        
        NSMutableData *postBody = [NSMutableData data];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"r_msg"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", message] dataUsingEncoding:NSUTF8StringEncoding]];
        
        for (int i = 0; i < images.count; i++) {
            NSString *filename = [NSString stringWithFormat:@"photo%d.jpg", i];
            NSMutableString *parameter = [NSMutableString string];
            [parameter appendString:@"r_img"];
            if (i > 0) {
                [parameter appendFormat:@"%d", i];
            }
            
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\";\r\n\r\n", parameter, filename] dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *imageData = UIImageJPEGRepresentation(images[i], 0.5);
            [postBody appendData:imageData];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
        [req setValue:contentType forHTTPHeaderField:@"Content-type"];
        
        [req setHTTPBody:postBody];
    }
    else {
        NSString *str = [NSString stringWithFormat:@"r_msg=%@", message];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:data];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
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
        
        NSString *replementID = [dic objectForKey:@"replyment"];
        handler(replementID, nil);
    }];
    connection.timeOut = 30 + 30*images.count;
    return connection;
}

- (MDURLConnection *)finishTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/finish?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unfinishTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/unfinish?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                                  title:(NSString *)title
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/edit_title?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&t_title=%@", title];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                                    des:(NSString *)des
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/edit_des?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    if (des && des.length > 0) {
        NSString *str = [NSString stringWithFormat:@"des=%@", des];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:data];
    }
    
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              chargerID:(NSString *)chargerID
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/edit_charge?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", chargerID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                          endDateString:(NSString *)endDateString
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/edit_expiredate?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&expiredate=%@", endDateString];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              projectID:(NSString *)projectID
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/edit_project?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    if (projectID && projectID.length > 0) {
        [urlString appendFormat:@"&p_id=%@", projectID];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)addMemberToTaskWithTaskID:(NSString *)tID
                                      memberID:(NSString *)memberID
                                       handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/add_member?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", memberID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteMemberFromeTaskWithTaskID:(NSString *)tID
                                            memberID:(NSString *)memberID
                                             handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/delete_member?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", memberID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)applyTaskMemberWithTaskID:(NSString *)tID
                                       handler:(MDAPIBoolHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/applyTaskMember?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
   
}

- (MDURLConnection *)applyJoinInTaskWithTaskID:(NSString *)tID
                                        memberID:(NSString *)memberID
                                         isAgree:(BOOL)agree
                                         handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/isAgreeMember?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", memberID];
    [urlString appendFormat:@"&is_agree=%d",agree?1:0];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)agreeToTaskWithTaskID:(NSString *)tID
                                  memberID:(NSString *)memberID
                                   handler:(MDAPIBoolHandler)handler
{
    return [self applyJoinInTaskWithTaskID:tID memberID:memberID isAgree:YES handler:handler];
}
- (MDURLConnection *)refuseToTaskWithTaskID:(NSString *)tID
                                   memberID:(NSString *)memberID
                                    handler:(MDAPIBoolHandler)handler
{
    return [self applyJoinInTaskWithTaskID:tID memberID:memberID isAgree:NO handler:handler];
}

- (MDURLConnection *)saveTaskWitTaskID:(NSString *)tID colorType:(int)colorType handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/editTaskColor?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&color=%d", colorType];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              lockState:(BOOL)lockedOrNot
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/editTaskLockState?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&stateLock=%d", lockedOrNot?1:0];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                               parentID:(NSString *)parentID
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/editTaskParent?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    if (parentID && parentID.length > 0) {
        [urlString appendFormat:@"&t_parentID=%@", parentID];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)copyTaskWithTaskID:(NSString *)tID
                              chargerID:(NSString *)chargerID
                                  title:(NSString *)title
                                options:(NSArray *)options
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/duplicate_task?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", chargerID];
    [urlString appendFormat:@"&title=%@", title];
    if (options.count == 6) {
        [urlString appendFormat:@"&is_taskdesc=%d", [options[0] boolValue]?1:0];
        [urlString appendFormat:@"&is_folderID=%d", [options[1] boolValue]?1:0];
        [urlString appendFormat:@"&is_members=%d", [options[2] boolValue]?1:0];
        [urlString appendFormat:@"&is_observers=%d", [options[3] boolValue]?1:0];
        [urlString appendFormat:@"&is_deadline=%d", [options[4] boolValue]?1:0];
        [urlString appendFormat:@"&is_subtask=%d", [options[5] boolValue]?1:0];
    }
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                            noticeState:(BOOL)noticeState
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/editUserNotice?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&notice=%d", noticeState?1:0];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadFoldersWithKeywords:(NSString *)keywords
                                  filterType:(int)type
                                   colorType:(int)colorType
                                   orderType:(int)orderType
                           isShowEmptyFolder:(BOOL)isShowEmptyFolder
                       isShowCompletedFolder:(BOOL)isShowCompletedFolder
                                    pageSize:(int)pageSize
                                   pageIndex:(int)pageIndex
                                     handler:(void(^)(NSArray *folders, MDTaskFolder *noFolderTaskInfo, NSError *error))handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/getFolders?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0){
        [urlString appendFormat:@"&keywords=%@", keywords];
    }
    if (type == 2 || type == 3) {
        [urlString appendFormat:@"&filter_type=%d", type];
    }
    if (colorType >= 0 && colorType <= 5) {
        [urlString appendFormat:@"&color=%d", colorType];
    }
    if (orderType >= 1 && orderType <= 2) {
        [urlString appendFormat:@"&order_type=%d", orderType];
    }
    if (pageSize > 0) {
        [urlString appendFormat:@"&pagesize=%d", pageSize];
    }
    if (pageIndex > 0) {
        [urlString appendFormat:@"&pageindex=%d", pageIndex];
    }
    [urlString appendFormat:@"&is_showEmptyFolder=%d", isShowEmptyFolder?1:0];
    [urlString appendFormat:@"&is_showCompletedFolder=%d", isShowCompletedFolder?1:0];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(nil, nil, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(nil, nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(nil, nil, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *projectDics = [dic objectForKey:@"folders"];
        NSMutableArray *projects = [NSMutableArray array];
        for (NSDictionary *projectDic in projectDics) {
            if (![projectDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTaskFolder *task = [[MDTaskFolder alloc] initWithDictionary:projectDic];
            [projects addObject:task];
        }
        
        if ([[dic objectForKey:@"nullFolder_notificationCount"] intValue] == -1 || [[dic objectForKey:@"nullFolder_unCompleteCount"] intValue] == -1 || [[dic objectForKey:@"nullFolder_completedCount"] intValue] == -1) {
            handler(projects, nil, error);
        } else {
            MDTaskFolder *noFolderTaskInfo = [[MDTaskFolder alloc] init];
            noFolderTaskInfo.unreadDiscussCount = [[dic objectForKey:@"nullFolder_notificationCount"] intValue];
            noFolderTaskInfo.taskInProgressCount = [[dic objectForKey:@"nullFolder_unCompleteCount"] intValue];
            noFolderTaskInfo.taskCompletedCount = [[dic objectForKey:@"nullFolder_completedCount"] intValue];
            handler(projects, noFolderTaskInfo, error);
        }
    }];
    return connection;
}

- (MDURLConnection *)loadTasksWithKeywords:(NSString *)keywords
                                  folderID:(NSString *)folderID
                                filterType:(int)filterType
                                 colorType:(int)colorType
                                  finished:(BOOL)finished
                               categortIDs:(NSString *)categortIDs
                                    userID:(NSString *)userID
                                 pageIndex:(int)pageIndex
                                  pageSize:(int)pageSize
                                   handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/getTaskList?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0){
        [urlString appendFormat:@"&keywords=%@", keywords];
    }
    if (folderID) {
        [urlString appendFormat:@"&t_folderID=%@", folderID];
    }
    if (filterType == 2 || filterType == 3) {
        [urlString appendFormat:@"&filter_type=%d", filterType];
    }
    if (colorType >= 0 && colorType <= 5) {
        [urlString appendFormat:@"&color=%d", colorType];
    }
    [urlString appendFormat:@"&status=%d", finished?1:0];
    if (categortIDs) {
        [urlString appendFormat:@"&categoryIDs=%@", categortIDs];
    }
    if (userID) {
        [urlString appendFormat:@"&u_id=%@", userID];
    }
    if (pageSize > 0)
        [urlString appendFormat:@"&pagesize=%d", pageSize];
    if (pageIndex > 0)
        [urlString appendFormat:@"&pageindex=%d", pageIndex];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadTaskDetailWithTaskID:(NSString *)taskID
                                       handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/getTaskDetail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@",taskID];
    
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
        
        NSDictionary *taskDics = [dic objectForKey:@"task"];
        
        MDTask *task = [[MDTask alloc] initWithDictionary:taskDics];
        handler(task, error);
    }];
    return connection;
}

- (MDURLConnection *)loadSubTasksWithParentID:(NSString *)parentID
                                    pageIndex:(int)pageIndex
                                     pageSize:(int)pageSize
                                      handler:(MDAPINSArrayHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/getSubTasks?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_parentID=%@", parentID];
    if (pageSize > 0)
        [urlString appendFormat:@"&pagesize=%d", pageSize];
    if (pageIndex > 0)
        [urlString appendFormat:@"&pageindex=%d", pageIndex];
    
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCanBeRelatedTasksWithTaskID:(NSString *)taskID
                                              keywords:(NSString *)keywords
                                               handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/getTasksByKeywordsAndID?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", taskID];
    if (keywords && keywords.length> 0){
        [urlString appendFormat:@"&keywords=%@", keywords];
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
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadAllTaskMessagesWithKeyWords:(NSString *)keywords
                                         messageType:(int)messageType
                                          isFavorite:(BOOL)isFavorite
                                            isUnread:(BOOL)isUnread
                                           pageIndex:(int)pageIndex
                                            pageSize:(int)pageSize
                                             handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/getAllTaskMessage?format=json"];
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    if (keywords && keywords.length > 0) {
        [urlString appendFormat:@"&keywords=%@",keywords];
    }
    [urlString appendFormat:@"&msg_type=%d",messageType];
    
    [urlString appendFormat:@"&is_favorite=%d",isFavorite?1:0];
    [urlString appendFormat:@"&is_unread=%d",isUnread?1:0];
    if (pageIndex > 0) {
        [urlString appendFormat:@"&pageindex=%d",pageIndex];
    }
    if (pageSize > 0) {
        [urlString appendFormat:@"&pagesize=%d",pageSize];
    }
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error) {
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
        
        NSArray *msgDics = [dic objectForKey:@"taskMessages"];
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *msgDic in msgDics) {
            if (![msgDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTaskMessage *message = [[MDTaskMessage alloc] initWithDictionary:msgDic];
            [messages addObject:message];
        }
        handler(messages, error);
    }];
    
    return connection;
}

- (MDURLConnection *)validateFolderWithName:(NSString *)folderName
                                    handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/validateFolder?format=json"];
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    
    NSMutableData *postBody = [NSMutableData data];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *boundary = @"--------MINGDAO";
    NSString *boundaryPrefix = @"--";
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"name"]dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", folderName] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error) {
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    
    return connection;
}

- (MDURLConnection *)createFolderWithName:(NSString *)folderName
                             chargeUserID:(NSString *)userID
                                colorType:(int)colorType
                                 deadLine:(NSString *)deadLine
                                  handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/addFolder?format=json"];
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    
    NSMutableData *postBody = [NSMutableData data];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *boundary = @"--------MINGDAO";
    NSString *boundaryPrefix = @"--";
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"name"]dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", folderName] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"chargeUserID"]dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", userID] dataUsingEncoding:NSUTF8StringEncoding]];

    if (colorType >= 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"color"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%d\r\n", colorType] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (deadLine && deadLine.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"deadline"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", deadLine] dataUsingEncoding:NSUTF8StringEncoding]];
    }

    [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error) {
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
        
        NSString *postID = [dic objectForKey:@"folderId"];
        handler(postID, error);
    }];
    return connection;
}

- (MDURLConnection *)createTaskV2WithTaskName:(NSString *)title
                                 description:(NSString *)description
                               endDateString:(NSString *)endDateString
                                   chargerID:(NSString *)chargerID
                                   memberIDs:(NSArray *)memberIDs
                                   projectID:(NSString *)projectID
                                    parentID:(NSString *)parentID
                                   colorType:(int)colorType
                                handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/addTask?format=json"];
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    
    NSMutableData *postBody = [NSMutableData data];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *boundary = @"--------MINGDAO";
    NSString *boundaryPrefix = @"--";
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"t_title"]dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", title] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (description && description.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"t_des"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", description] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (endDateString && endDateString.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"t_ed"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", endDateString] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"u_id"]dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", chargerID] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (memberIDs && memberIDs.count > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"t_mids"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", [memberIDs componentsJoinedByString:@","]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (projectID && projectID.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"t_folderID"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", projectID] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (parentID && parentID.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"t_parentID"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", parentID] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (colorType >= 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"color"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%d\r\n", colorType] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error) {
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
        
        NSString *postID = [dic objectForKey:@"task"];
        handler(postID, error);
    }];
    return connection;
}

- (MDURLConnection *)saveFolderWithFolderID:(NSString *)folderID
                                 folderName:(NSString *)folderName
                                 chargeUser:(NSString *)chargeUser
                                  colorType:(int)colorType
                                   deadLine:(NSString *)deadLine
                                    handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/editFolderInfo?format=json"];
    [urlString appendFormat:@"&access_token=%@",self.accessToken];
    
    NSMutableData *postBody = [NSMutableData data];
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    NSString *boundary = @"--------MINGDAO";
    NSString *boundaryPrefix = @"--";
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"t_folderID"]dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", folderID] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (folderName.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"name"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", folderName] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if (chargeUser.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"chargeUserID"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", chargeUser] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (colorType >= 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"color"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%d\r\n", colorType] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (deadLine && deadLine.length > 0) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"deadline"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", deadLine] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error) {
        [self handleBoolData:data error:error URLString:urlStr handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveFolderWithFolderID:(NSString *)folderID
                                  colorType:(int)colorType
                                    handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/editFolderColor?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_folderID=%@", folderID];
    [urlString appendFormat:@"&color=%d", colorType];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteFolderWithFolderID:(NSString *)folderID
                                isDeleteTasks:(BOOL)isDeleteTasks
                                      handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/task/v2/deleteFolder?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_folderID=%@", folderID];
    
    [urlString appendFormat:@"&is_deleteTask=%d",isDeleteTasks?1:0];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handleBoolData:data error:error URLString:urlString handler:handler];
    }];
    return connection;
}
@end
