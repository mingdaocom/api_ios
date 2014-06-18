//
//  MDAPIManager.h
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import <Foundation/Foundation.h>
#import "MDAPIHandler.h"
#import "UIDevice+IdentifierAddition.h"
#import "MDErrorParser.h"

#define MDAPIDefaultServerAddress @"https://api.mingdao.com"

extern NSString * const MDAPIManagerNewTokenSetNotification;

@interface MDAPIManager : NSObject
@property (strong, nonatomic) NSString *serverAddress;
@property (strong, nonatomic) NSString *accessToken;

+ (MDAPIManager *)sharedManager;

+ (void)setServerAddress:(NSString *)serverAddress;
+ (void)setAppKey:(NSString *)appKey;
+ (void)setAppSecret:(NSString *)appSecret;

- (void)handleBoolData:(NSData *)data error:(NSError *)error URLString:(NSString *)urlString handler:(MDAPIBoolHandler)handler;

- (NSString *)localEncode:(NSString *)string;
#pragma mark - 登录/验证接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 通过用户名密码登录，可能返回多个MDProject，如果只有一个，则登录成功或失败
 @parmas:
 username - 用户登录名
 password - 用户登录密码
 pHandler - 处理存在多网络的情况，返回包含多个MDProject的NSArray
 sHandler - 处理仅存在一个网络时登录结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loginWithUsername:(NSString *)username
                              password:(NSString *)password
                        projectHandler:(MDAPINSArrayHandler)pHandler
                               handler:(MDAPINSDictionaryHandler)sHandler;

- (MDURLConnection *)loginWithServer:(NSString *)serverAddress
                            username:(NSString *)username
                            password:(NSString *)password
                      projectHandler:(MDAPINSArrayHandler)pHandler
                            handler:(MDAPINSDictionaryHandler)sHandler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 通过用户名密码以及选定的MDProject.objectID来登录，projectID为必填
 @parmas:
 username  - 用户登录名
 password  - 用户登录密码
 projectID - 登录的网络ID，ID(MDProject.objectID)可从上方的方法获取
 handler   - 处理登录结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loginWithServer:(NSString *)serverAddress
                            username:(NSString *)username
                            password:(NSString *)password
                            projectID:(NSString *)projectID
                            handler:(MDAPINSDictionaryHandler)handler;

- (MDURLConnection *)loginWithUsername:(NSString *)username
                              password:(NSString *)password
                             projectID:(NSString *)projectID
                               handler:(MDAPINSDictionaryHandler)handler;

- (MDURLConnection *)loginWithAppKey:(NSString *)appKey
                           appSecret:(NSString *)appSecret
                                code:(NSString *)code
                         redirectURL:(NSString *)redirectURL
                             handler:(MDAPINSDictionaryHandler)handler;


@end
