//
//  MDUser.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MDOrgnization;

enum {
    MDUserLicenseNomalUser = -1,
    MDUserLicenseAdminAndAnnouncer = 0,
    MDUserLicenseAdmin = 1,
    MDUserLicenseAnnouncer = 2
};
typedef int MDUserLicense;

enum {
    MDUserGenderUnknown = 0,
    MDUserGenderMale = 1,
    MDUserGenderFemale = 2
};
typedef int MDUserGender;

enum {
    MDUserTaskMemberTypeNone = -1,
    MDUserTaskMemberTypeMember = 0,
    MDUserTaskMemberTypeDelegater = 1
};
typedef int MDUserTaskMemberType;

enum {
    MDUserTaskApplyStatusNone = 0,
    MDUserTaskApplyStatusPending = 1,
    MDUserTaskApplyStatusRejected = 2
};
typedef int MDUserTaskApplyStatus;

typedef enum : int {
    MDUserStatusDeleted = 0,
    MDUserStatusNormal = 1,
    MDUserStatusError = 2,
} MDUserStatus;

enum {
    MDUserFolderTypeNone = 0,
    MDUserFolderTypeMember = 1,
    MDUserFolderTypeTransfor = 2,
    MDUserFolderTypeApply = 4,
};
typedef int MDUserFolderType;

@interface MDUser : NSObject
// unknown
@property (strong, nonatomic, nullable) NSString *user_id, *project_id, *unit_name;
@property (assign, nonatomic) BOOL egroup;

// basic
@property (strong, nonatomic, nonnull) NSString *account_id;
@property (strong, nonatomic, nonnull) NSString *full_name;
@property (strong, nonatomic, nullable) NSString *avatar;

// social
@property (strong, nonatomic, nullable) NSString *followed_status;

// contacts
@property (strong, nonatomic, nullable) NSString *email, *mobile_phone, *work_phone;

// private information
@property (strong, nonatomic, nullable) NSString *birth, *city;
@property (assign, nonatomic) MDUserGender gender;

// Mingdao information
@property (strong, nonatomic, nullable) NSString *mark, *grade, *create_time;
@property (assign, nonatomic) MDUserLicense license;
@property (assign, nonatomic) MDUserStatus status;

// job information
@property (strong, nonatomic, nullable) NSString *company, *department, *job, *work_site, *job_number;
@property (strong, nonatomic, nullable) NSArray<NSDictionary *> *jobs;

// education information
@property (strong, nonatomic, nullable) NSArray<NSDictionary *> *educations;

// orgnizations
@property (strong, nonatomic, nullable) NSArray<MDOrgnization *> *orgnizations;

- (nonnull MDUser *)initWithDictionary:(nullable NSDictionary *)aDic;

// old stuff DEPRECATED!
@property (assign, nonatomic) int unreadMessageCount, messageCount;
@property (strong, nonatomic, nullable) NSString *joinDateString;
@property (strong, nonatomic, nullable) NSString *lastLoginDate;
@property (strong, nonatomic, nullable) NSString *workSite;
@property (strong, nonatomic, nullable) NSString *operateUserName;
@property (strong, nonatomic, nullable) NSString *approveDate;
@property (strong, nonatomic, nullable) NSString *approveTime;

@property (assign, nonatomic) MDUserTaskMemberType taskMemberType;
@property (assign, nonatomic) MDUserTaskApplyStatus taskApplyStatus;
@property (assign, nonatomic) MDUserFolderType folderType;
@property (assign, nonatomic) BOOL isFolderAdmin;

@property (assign, nonatomic) NSInteger kcFolderPermission;

@property (strong, nonatomic, nullable) NSString *userRegisterTime;
@property (strong, nonatomic, nullable) NSString *versionPublishTime;
@end
