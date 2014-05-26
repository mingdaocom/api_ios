//
//  MDAPIManager+FullSearch.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (FullSearch)
/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据关键字全文搜索公司的信息（包含实体：用户、群组、私信、动态、任务、文档、图片、问答）
 @parmas:
 keywords - 关键词模糊搜索 (必须)
 filterType - 筛选动态更新类型,默认0:表示所有；1：表示用户；2：表示群组；3.表示私信；4：表示动态；5：表示任务；6：表示文档；7：表示图片；8:表示问答;
 gID - 群组编号；默认全公司范围
 sinceID - 若指定此参数，则只返回ID比since_id大的动态更新（即比since_id发表时间晚的动态更新）为MDPost.autoID
 maxID - 若指定此参数，则只返回ID比max_id小的动态更新（即比max_id发表时间早的动态更新) 为MDPost.autoID
 page - 指定要返回的记录的页码
 size - 指定要返回的记录条数
 handler - 包含多个MDPost的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadFullSearchWithKeyWords:(NSString *)keywords filterType:(NSInteger)filterType groupID:(NSString *)gID sinceID:(NSString *)sinceID maxID:(NSString *)maxID pageindex:(NSInteger)page pageSize:(NSInteger)size handler:(MDAPINSDictionaryHandler)handler;
@end
