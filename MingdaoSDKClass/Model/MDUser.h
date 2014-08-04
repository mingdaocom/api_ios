//
//  MDUser.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

/*
 @sample:
 {
 "user": {
 "id": "用户编号",
 "name": "用户姓名",
 "avstar": "用户头像地址",
 "email": "用户邮箱",
 "grade": "用户等级",
 "mark": "用户积分",
 "birth": "生日：yyyy-MM-dd",
 "gender": "性别：0表示未选；1表示男性；2表示女性",
 "company": "公司",
 "department": "所属部门",
 "job": "职位",
 "mobile_phone": "移动电话",
 "work_phone": "工作电话",
 "followed_status": "当前登录用户与该用户的关注关系：0表示未关注；1表示已关注",
 "license": "当前用户的权限：-1表示普通用户；0表示既是管理员又是广播员；1表示管理员；2表示广播员",
 "status": "用户状态：0为删除；1为正常；",
 "jobs": [{
 "description": "工作内容",
 "endDate": "结束年月",
 "name": "公司名称",
 "startDate": "开始年月",
 "title": "职位"
 }],
 "educations": [{
 "description": "核心课程",
 "endDate": "结束年月",
 "name": "学校名称",
 "startDate": "开始年月",
 "title": "学位或学历",
 "egroup":"是否外部用户0 为否 1为是"
 }]
 }
 }
 */

#import <Foundation/Foundation.h>
#import "MDCompany.h"

enum {
    MDUserLicenceNomalUser = -1,
    MDUserLicenceAdminAndAnnouncer = 0,
    MDUserLicenceAdmin = 1,
    MDUserLicenceAnnouncer = 2
};
typedef int MDUserLicence;

enum {
    MDUserGenderUnknown = 0,
    MDUserGenderMale = 1,
    MDUserGenderFemale = 2
};
typedef int MDUserGender;

enum {
    MDUserTaskMemberTypeNone = 0,
    MDUserTaskMemberTypeMember = 1,
    MDUserTaskMemberTypeDelegater = 2
};
typedef int MDUserTaskMemberType;

enum {
    MDUserTaskApplyStatusNone = 0,
    MDUserTaskApplyStatusPending = 1,
    MDUserTaskApplyStatusRejected = 2
};
typedef int MDUserTaskApplyStatus;

@interface MDUser : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
@property (strong, nonatomic) NSString *avatar, *avatar100;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *grade;
@property (strong, nonatomic) NSString *mark;
@property (strong, nonatomic) NSString *birth;
@property (assign, nonatomic) MDUserGender gender;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *department;
@property (strong, nonatomic) NSString *job;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *workSite;
@property (strong, nonatomic) NSString *mobilePhoneNumber;
@property (strong, nonatomic) NSString *workPhoneNumber;
@property (assign, nonatomic) BOOL isMobilePhoneNumberVisible;
@property (assign, nonatomic) BOOL isFollowed;
@property (assign, nonatomic) BOOL egroup;
@property (assign, nonatomic) MDUserLicence licence;
@property (assign, nonatomic) int status;
@property (assign, nonatomic) int unreadMessageCount, messageCount;
@property (strong, nonatomic) NSArray *jobs;
@property (strong, nonatomic) NSArray *educations;
@property (strong, nonatomic) MDCompany *project;

@property (assign, nonatomic) MDUserTaskMemberType taskMemberType;
@property (assign, nonatomic) MDUserTaskApplyStatus taskApplyStatus;

- (MDUser *)initWithDictionary:(NSDictionary *)aDic;
@end
