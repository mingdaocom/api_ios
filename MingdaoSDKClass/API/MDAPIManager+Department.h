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
 创建、更改、删除部门
 @parmas:
 departmentName   - 部门名称
 mappingGroupID  - 官方群组ID
 departmentID - 部门ID
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/

- (MDURLConnection *)addDepartmentWithName:(NSString *)name mappingGroupID:(NSString *)mappingGroupID handler:(MDAPIBoolHandler)handler;


@end
