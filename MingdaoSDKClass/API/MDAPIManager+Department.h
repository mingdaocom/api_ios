//
//  MDAPIManager+Department.h
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Department)

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取所有部门
 @parmas:
 pageSize   - 加载的个数
 pageIndex  - 索引
 keywords   - 关键字
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/

- (MDURLConnection *)loadAllDepartmentsWithpageSize:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex keyWords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取部门选择限制
 @parmas:
 pageSize   - 加载的个数
 pageIndex  - 索引
 keywords   - 关键字
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadDepartmentsSeletLimitWithpageSize:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex keyWords:(NSString *)keywords handler:(MDAPIBoolHandler)handler;



/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 创建、更改、删除部门
 @parmas:
 departmentName   - 部门名称
 mappingGroupID  - 官方群组ID
 departmentID - 部门ID
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/

- (MDURLConnection *)addDepartmentWithName:(NSString *)name mappingGroupID:(NSString *)mappingGroupID handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)editDepartmentWithdepartmentID:(NSString *)departmentID departmentName:(NSString *)departmentName mappingGroupID:(NSString *)mappingGroupID handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)deleteDepartmentWithdepartmentID:(NSString *)departmentID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
新增删除部门工作地成员
 @parmas:
 type - 1 部门  2工作地
 name  -  名称
 op -   1 新增  2 移除
 userID - 成员ID
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/

- (MDURLConnection *)editDeptSiteMembersWithType:(NSInteger)type name:(NSString *)name op:(NSInteger)op userID:(NSString *)userID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
设置是否开启新用户部门选择限制
 @parmas:
 isSetting - 0 关闭  1 开启
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/

- (MDURLConnection *)editDepartmentSeletLimitWithIsSetting:(NSString *)isSetting handler:(MDAPIBoolHandler)handler;


@end
