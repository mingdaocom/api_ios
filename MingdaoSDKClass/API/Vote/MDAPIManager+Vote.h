//
//  MDAPIManager+Vote.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Vote)
#pragma mark - 投票接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 按需获取当前登录用户参与的投票列表
 @parmas:
 page - 指定当前的页码
 size - int默认值20，最大值100	指定要返回的记录条数
 handler - 包含多个MDPost的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadCurrentUserJoinedVotesWithPageIndex:(NSInteger)page
                                                    keywords:(NSString *)keywords
                                                    pagesize:(NSInteger)size
                                                     handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadCurrentUserCreatedVotesWithPageIndex:(NSInteger)page
                                                     keywords:(NSString *)keywords
                                                     pagesize:(NSInteger)size
                                                      handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadAllVotesWithPageIndex:(NSInteger)page
                                      keywords:(NSString *)keywords
                                      pagesize:(NSInteger)size
                                       handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据投票编号（动态更新编号）获取单条投票内容
 @parmas:
 pID - 动态更新编号
 handler - 包含多个MDPost的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadVoteWithVoteID:(NSString *)pID handler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 增加当前登录用户对某投票的投票
 @parmas:
 pID - 动态更新编号
 optionString - 投票选项，如：1|3,表示选择第1、3两项
 handler - 包含多个MDPost的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)castOptionOnVoteWithVoteID:(NSString *)pID
                                   optionString:(NSString *)optionString
                                        handler:(MDAPIBoolHandler)handler;


@end
