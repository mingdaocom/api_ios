//
//  MDAPIManager+Company.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Company)
#pragma mark - 企业网络与管理员接口
- (MDURLConnection *)loadCompanyDetailWithHandler:(MDAPINSDictionaryHandler)handler;
- (MDURLConnection *)loadCompanyCommonTagsWithPageSize:(int)pageSize
                                             pageIndex:(int)pageIndex
                                               handler:(MDAPINSArrayHandler)handler;
@end
