//
//  MDAPIManager+WorkSite.h
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (WorkSite)

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取所有工作地点
 @parmas:
 pageSize   - 加载的个数
 pageIndex  - 索引
 keywords   - 关键字
 sortType   - 0 正序  1 反序
 handler    - 处理邀请结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/

- (MDURLConnection *)loadAllWorkSiteWithpageSize:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex keyWords:(NSString *)keyWords sortType:(NSInteger)sortType handler:(MDAPINSArrayHandler)handler;





@end
