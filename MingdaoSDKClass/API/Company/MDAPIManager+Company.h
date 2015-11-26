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
- (nullable MDURLConnection *)loadCompanyDetailWithHandler:(nonnull MDAPINSDictionaryHandler)handler;
- (nullable MDURLConnection *)loadCompanyCommonTagsWithPageSize:(nullable NSNumber *)pageSize
                                                      pageIndex:(nullable NSNumber *)pageIndex
                                                        handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadCompanyIsDeploymentSetInfo:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)setCompanyName:(nonnull NSString *)name
                                     handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)addDeparments:(nonnull NSArray *)names
                                    handler:(nonnull MDAPIBoolHandler)handler;
- (nullable MDURLConnection *)loadGeoInfo:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadIndustryInfo:(nonnull MDAPINSArrayHandler)handler;
@end
