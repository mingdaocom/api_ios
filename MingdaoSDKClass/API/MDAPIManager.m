//
//  MDAPIManager.m
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import "MDAPIManager.h"

NSString * const MDAPIManagerNewTokenSetNotification = @"MDAPIManagerNewTokenSetNotification";

@interface MDAPIManager ()
@property (strong, nonatomic) NSString *appKey, *appSecret;
@end

@implementation MDAPIManager
static MDAPIManager *sharedManager = nil;
+ (MDAPIManager *)sharedManager
{
    @synchronized(self)
    {
        if  (!sharedManager)
        {
            sharedManager = [[MDAPIManager alloc] init];
        }
    }
    return sharedManager;
}

+ (void)setServerAddress:(NSString *)serverAddress
{
    [[self sharedManager] setServerAddress:serverAddress];
}

+ (void)setAppKey:(NSString *)appKey
{
    [[self sharedManager] setAppKey:appKey];
}

+ (void)setAppSecret:(NSString *)appSecret
{
    [[self sharedManager] setAppSecret:appSecret];
}

- (NSString *)serverAddress
{
    if (!_serverAddress) {
        _serverAddress = MDAPIDefaultServerAddress;
        //_serverAddress = @"http://172.16.23.247/MD.api.Web";
        return _serverAddress;
    }
    return _serverAddress;
}

- (void)setAccessToken:(NSString *)accessToken
{
    if (![_accessToken isEqualToString:accessToken]) {
        _accessToken = accessToken;
        [[NSNotificationCenter defaultCenter] postNotificationName:MDAPIManagerNewTokenSetNotification object:accessToken userInfo:nil];
    }
}

- (void)handleBoolData:(NSData *)data error:(NSError *)error URLString:(NSString *)urlString handler:(MDAPIBoolHandler)handler
{
    if (error) {
        handler(NO, error);
        return ;
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
        handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
        return ;
    }
    NSString *errorCode = [dic objectForKey:@"error_code"];
    if (errorCode) {
        handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
        return;
    }
    
    if ([[dic objectForKey:@"count"] boolValue]) {
        handler(YES, error);
    } else {
        handler(NO, error);
    }
}


#pragma mark - 登录/验证接口
- (MDURLConnection *)loginWithUsername:(NSString *)username
                              password:(NSString *)password
                        projectHandler:(MDAPINSArrayHandler)pHandler
                               handler:(MDAPINSDictionaryHandler)sHandler
{
    return [self loginWithServer:[MDAPIManager sharedManager].serverAddress username:username password:password projectHandler:pHandler handler:sHandler];
}

- (MDURLConnection *)loginWithServer:(NSString *)serverAddress
                            username:(NSString *)username
                            password:(NSString *)password
                      projectHandler:(MDAPINSArrayHandler)pHandler
                             handler:(MDAPINSDictionaryHandler)sHandler
{
    
    NSMutableString *urlString = [serverAddress mutableCopy];
    [urlString appendString:@"/oauth2/access_token?format=json"];
    [urlString appendFormat:@"&app_key=%@&app_secret=%@",  self.appKey, self.appSecret];
    
    //生成UserName令牌签名,首先处理用户名和密码中的特殊字符
    NSString *userNameTmp = [self localEncode:username];
    NSString *passwordTmp = [self localEncode:password];
    
    
    [urlString appendFormat:@"&grant_type=password&username=%@&password=%@", userNameTmp, passwordTmp];
    
    
    NSString *urlStr = urlString;
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        if (error) {
            sHandler(NO, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            sHandler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            sHandler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        NSArray *projectsDic = [dic objectForKey:@"projects"];
        if ([projectsDic isKindOfClass:[NSArray class]]) {
            NSMutableArray *projects = [NSMutableArray array];
            for(NSDictionary *projectDic in projectsDic) {
                if (![projectDic isKindOfClass:[NSDictionary class]])
                    continue;
                
                MDCompany *p = [[MDCompany alloc] initWithDictionary:projectDic];
                [projects addObject:p];
            }
            pHandler(projects, error);
            return;
        }
        
        sHandler(dic, error);
    }];
    return connection;

}

- (MDURLConnection *)loginWithUsername:(NSString *)username
                              password:(NSString *)password
                             projectID:(NSString *)projectID
                               handler:(MDAPINSDictionaryHandler)handler
{
    return [self loginWithServer:[MDAPIManager sharedManager].serverAddress username:username password:password projectID:projectID handler:handler];
}

- (MDURLConnection *)loginWithServer:(NSString *)serverAddress username:(NSString *)username password:(NSString *)password projectID:(NSString *)projectID handler:(MDAPINSDictionaryHandler)handler
{
    
    NSMutableString *urlString = [serverAddress mutableCopy];
    [urlString appendString:@"/oauth2/access_token?format=json"];
    [urlString appendFormat:@"&app_key=%@&app_secret=%@", self.appKey, self.appSecret];
    //生成UserName令牌签名,首先处理用户名和密码中的特殊字符
    NSString *userNameTmp = [self localEncode:username];
    NSString *passwordTmp = [self localEncode:password];
    
    [urlString appendFormat:@"&grant_type=password&username=%@&password=%@", userNameTmp, passwordTmp];    if (projectID && projectID.length > 0)
    {
        [urlString appendFormat:@"&p_signature=%@", projectID];
    } else {
        NSLog(@"[error]ProjectID can not be nil![error]");
    }
    
    NSString *urlStr = urlString;
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(NO, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        handler(dic, error);
    }];
    return connection;

}

- (MDURLConnection *)loginWithAppKey:(NSString *)appKey
                           appSecret:(NSString *)appSecret
                                code:(NSString *)code
                         redirectURL:(NSString *)redirectURL
                             handler:(MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"/oauth2/access_token?format=json"];
    [urlString appendFormat:@"&app_key=%@&app_secret=%@&redirect_uri=%@&code=%@", appKey, appSecret, redirectURL, code];
    [urlString appendString:@"&grant_type=authorization_code"];
    
    NSString *urlStr = urlString;
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        if (error) {
            handler(NO, error);
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return ;
        }
        NSString *errorCode = [dic objectForKey:@"error_code"];
        if (errorCode) {
            handler(NO, [MDErrorParser errorWithMDDic:dic URLString:urlString]);
            return;
        }
        
        handler(dic, error);
    }];
    return connection;
}

- (NSString *)localEncode:(NSString *)string
{
    NSMutableString *passwordTmp = [string mutableCopy];
    {
        [passwordTmp replaceOccurrencesOfString:@"%" withString:@"%25" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"&" withString:@"%26" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"(" withString:@"%28" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@")" withString:@"%29" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"?" withString:@"%3F" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\"" withString:@"%22" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"," withString:@"%2C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@":" withString:@"%3A" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@";" withString:@"%3B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"=" withString:@"%3D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"@" withString:@"%40" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@" " withString:@"%20" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\t" withString:@"%09" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"#" withString:@"%23" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"<" withString:@"%3C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@">" withString:@"%3E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\n" withString:@"%0A" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"!" withString:@"%21" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"^" withString:@"%5E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"~" withString:@"%7E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"`" withString:@"%60" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"!" withString:@"%21" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"$" withString:@"%24" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"." withString:@"%2E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"!" withString:@"%21" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"*" withString:@"%2A" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"-" withString:@"%2D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"[" withString:@"%5B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"]" withString:@"%5D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"_" withString:@"%5F" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"{" withString:@"%7B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"|" withString:@"%7C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"}" withString:@"%7D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\\" withString:@"%5C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
    }
    return passwordTmp;
}
@end
