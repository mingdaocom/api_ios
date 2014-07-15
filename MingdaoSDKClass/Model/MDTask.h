//
//  MDTask.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-5.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

/*
 sample:
 {
 "task": {
 "guid": "任务编号",
 "title": "",
 "des": "",
 "expire_date": "任务截止日期：yyyy-MM-dd",
 "finished_date": "任务完成日期：yyyy-MM-dd，为空代表尚未完成",
 "reply_count": "讨论数量",
 "create_time": "创建时间：yyyy-MM-dd HH:mm:ss",
 "create_userid": "创建任务用户编号，创建者才有权限去删除任务",
 "project": {
 "guid": "任务隶属项目编号",
 "title": ""
 },
 "user": {
 "avstar": "用户头像：http://img.mingdao.com/users/user1_avstar.gif",
 "id": "用户编号",
 "name": "用户姓名"
 },
 "joined": {
 "users": [{
 "avstar": "用户头像：http://img.mingdao.com/users/user2_avstar.gif",
 "id": "用户编号",
 "name": "用户姓名"
 }]
 }
 
 }
 }
 */

#import <Foundation/Foundation.h>
#import "MDUser.h"
#import "MDProject.h"

@interface MDTask : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
@property (strong, nonatomic) NSString *des;

@property (strong, nonatomic) NSString *createdDateString;
@property (strong, nonatomic) NSString *expiredDateString;
@property (strong, nonatomic) NSString *finishedDateString;

@property (strong, nonatomic) MDUser *charger;
@property (strong, nonatomic) MDUser *creator;

@property (strong, nonatomic) NSArray *members;
@property (strong, nonatomic) NSArray *subTasks;
@property (strong, nonatomic) MDTask *parentTask;

@property (assign, nonatomic) BOOL isLocked, isNoticed;
@property (assign, nonatomic) BOOL isContainMe;

@property (assign, nonatomic) MDUserTaskMemberType currentUserType;

@property (assign, nonatomic) int replyCount, unreadDiscussCount, subTaskCount;
@property (assign, nonatomic) int colorType;

@property (strong, nonatomic) MDTaskFolder *folder;

@property (readonly, nonatomic) BOOL finished, expired;

- (MDTask *)initWithDictionary:(NSDictionary *)aDic;
@end
