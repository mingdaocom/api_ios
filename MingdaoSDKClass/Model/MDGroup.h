//
//  MDGroup.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

/*
 sample
 {
 "group": {
 "id": "群组编号",
 "name": "群组名称",
 "avstar": "群组头像",
 "is_public": "是否公开群组：0表示私有群组；1表示公开群组",
 "status": "群组状态：0表示已关闭；1表示正常状态",
 "followed_status": "当前登录用户与该群组的加入关系：0表示未加入；1表示已加入",
 "user_count": "群组成员数量",
 "post_count": "动态更新数量",
 "user": {
 "avstar": "用户头像：http://img.mingdao.com/users/user1_avstar.gif",
 "id": "用户编号",
 "name": "用户姓名"
 },
 "admins": ["用户编号1", "用户编号2"]
 }
 }
 */

#import <Foundation/Foundation.h>
#import "MDUser.h"

@interface MDGroup : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) NSString *avatar;
@property (assign, nonatomic) BOOL isPublic, isJoined, isHidden;
@property (assign, nonatomic) int status;
@property (assign, nonatomic) int userCount;
@property (assign, nonatomic) int postCount;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) NSArray *admins;

- (MDGroup *)initWithDictionary:(NSDictionary *)aDic;
@end
