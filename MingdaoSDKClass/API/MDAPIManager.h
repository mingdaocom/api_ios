//
//  MDAPIManager.h
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import <Foundation/Foundation.h>
#import "MDAPIHandler.h"
#import "MDErrorParser.h"
#import "NSMutableArray+MDURLRequestParamsGenerator.h"
#import "NSURLRequest+MDURLRequestGenerator.h"

#define MDAPIVersion @"58"
#define MDAPIDefaultServerAddress @"https://api.mingdao.com"

extern NSString * const MDAPIManagerNewTokenSetNotification;

@interface MDAPIManager : NSObject
@property (strong, nonatomic) NSString *serverAddress;
@property (strong, nonatomic) NSString *accessToken;

+ (MDAPIManager *)sharedManager;

+ (void)setServerAddress:(NSString *)serverAddress;
+ (void)setAppKey:(NSString *)appKey;
+ (void)setAppSecret:(NSString *)appSecret;

- (void)handleBoolData:(NSDictionary *)dic error:(NSError *)error URLString:(NSString *)urlString handler:(MDAPIBoolHandler)handler;

- (NSString *)localEncode:(NSString *)string;
#pragma mark - 登录/验证接口

/**
 *  Login 登录
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param handler  回调结果
 */
- (MDURLConnection *)loginWithUsername:(NSString *)username
                              password:(NSString *)password
                               handler:(MDAPINSDictionaryHandler)handler;

- (MDURLConnection *)loginWithServer:(NSString *)serverAddress
                            username:(NSString *)username
                            password:(NSString *)password
                            handler:(MDAPINSDictionaryHandler)handler;

/**
 *  Refresh Token 延续Token
 *
 *  @param refreshToken 登录时返回的refreshToken
 *  @param handler      回调结果
 */
- (MDURLConnection *)refreshTokenWithRefreshToken:(NSString *)refreshToken
                                          handler:(MDAPINSDictionaryHandler)handler;
@end
