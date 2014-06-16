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

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
@usage:
 创建投票动态
 @param
 text          动态内容
 options       投票选项内容以[option]标示符分开
 images        投票发布时的图片信息
 imageOptions  发布的图片信息对应的选项
 endDateString 投票结束时间
 maxChoice     投票最大可选项
 isAnonymous   是否为匿名投票
 isVisible     是否可以查看投票结果
 groupIDs      投票动态分享的群组
 shareType     分享范围
 handler       处理动态发布是否成功的信息
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)createPollPostWithText:(NSString *)text
                                    options:(NSString *)options
                                     images:(NSArray *)images
                               imageOptions:(NSString *)imageOptions
                              endDateString:(NSString *)endDateString
                                  maxChoice:(NSInteger)maxChoice
                                isAnonymous:(BOOL)isAnonymous
                                  isVisible:(BOOL)isVisible
                                   groupIDs:(NSArray *)groupIDs
                                  shareType:(NSInteger)shareType
                                    handler:(MDAPINSStringHandler)handler;
@end
