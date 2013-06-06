//
//  MDAPIManager.m
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import "MDAPIManager.h"
#import "UIDevice+IdentifierAddition.h"
#import "JSONKit.h"

#define MDAPIErrorDomain @"MDAPIErrorDomain"

@interface MDAPIManager ()
@property (strong, nonatomic) NSString *serverAddress;
@property (strong, nonatomic) NSString *accessToken;
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

+ (NSString *)encodeUrl:(NSString *)str
{
    __autoreleasing NSString *outputStr = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, (CFStringRef) @"%&()?\"+,/:;=@ \t#<>\n!^~`!$.*-[]_{}|", kCFStringEncodingUTF8);
    return outputStr;
}

- (NSString *)serverAddress
{
    if (!_serverAddress) {
        return @"https://api.mingdao.com/";
    }
    return _serverAddress;
}

- (void)handlerBoolData:(NSData *)data error:(NSError *)error handler:(MDAPIBoolHandler)handler
{
    NSDictionary *dic = [data objectFromJSONData];
    if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"JSON ERROR");
        return ;
    }
    NSDictionary *errorDic = [dic objectForKey:@"error_code"];
    if (errorDic) {
        handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
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
                  handler:(MDAPIBoolHandler)sHandler
{
    NSString *userNameTmp = [[self class] encodeUrl:[NSMutableString stringWithString:username]];
    NSString *passwordTmp = [[self class] encodeUrl:[NSMutableString stringWithString:password]];
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"oauth2/access_token?format=json"];
    [urlString appendFormat:@"&app_key=%@&app_secret=%@", @"935527504", [[UIDevice currentDevice] uniqueDeviceIdentifier]];
    [urlString appendFormat:@"&grant_type=password&username=%@&password=%@", userNameTmp, passwordTmp];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            sHandler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
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

        NSString *accessToken = [dic objectForKey:@"access_token"];
        if (accessToken && accessToken.length > 0) {
            self.accessToken = accessToken;
            sHandler(YES, error);
        } else {
            sHandler(NO, error);
        }
    }];
    return connection;
}

- (MDURLConnection *)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                projectID:(NSString *)projectID
                  handler:(MDAPIBoolHandler)handler
{
    NSString *userNameTmp = [[self class] encodeUrl:[NSMutableString stringWithString:username]];
    NSString *passwordTmp = [[self class] encodeUrl:[NSMutableString stringWithString:password]];
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"oauth2/access_token?format=json"];
    [urlString appendFormat:@"&app_key=%@&app_secret=%@", @"935527504", [[UIDevice currentDevice] uniqueDeviceIdentifier]];
    [urlString appendFormat:@"&grant_type=password&username=%@&password=%@", userNameTmp, passwordTmp];
    if (projectID && projectID.length > 0)
    {
        [urlString appendFormat:@"&p_signature=%@", projectID];
    } else {
        NSLog(@"[error]ProjectID can not be nil![error]");
    }
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSString *accessToken = [dic objectForKey:@"access_token"];
        if (accessToken && accessToken.length > 0) {
            self.accessToken = accessToken;
            handler(YES, error);
        } else {
            handler(NO, error);
        }
    }];
    return connection;
}

#pragma mark - 账号接口

- (MDURLConnection *)loadCurrentUserDetailWithHandler:(MDAPIObjectHandler)handler
{    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"passport/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        MDUser *aUser = [[MDUser alloc] initWithDictionary:[dic objectForKey:@"user"]];
        handler(aUser, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserUnreadCountWithHandler:(MDAPINSDictionaryHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"passport/unreadcount?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        handler(dic, error);
    }];
    return connection;
}

- (MDURLConnection *)logoutWithHandler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"passport/logout?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveUserWithName:(NSString *)name
              department:(NSString *)dep
                     job:(NSString *)job
       mobilePhoneNumber:(NSString *)mpn
         workPhoneNumber:(NSString *)wpn
                birthday:(NSString *)birthday
                  gender:(NSInteger)gender
                 handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"passport/edit?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (name && name.length > 0)
        [urlString appendFormat:@"&name=%@", [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (dep && dep.length > 0)
        [urlString appendFormat:@"&dep=%@", [dep stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (job && job.length > 0)
        [urlString appendFormat:@"&job=%@", [job stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (mpn && mpn.length > 0)
        [urlString appendFormat:@"&mobile_phone=%@", [mpn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (wpn && wpn.length > 0)
        [urlString appendFormat:@"&work_phone=%@", [wpn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (birthday && birthday.length > 0)
        [urlString appendFormat:@"&birth=%@", [birthday stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (gender != 0)
        [urlString appendFormat:@"&gender=%d", gender];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveUserWithAvatar:(UIImage *)avatarImg handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSString *boundary = @"-----------------MINGDAO-----------------";
    NSString *filename = @"photo.jpg";
    
    NSString *urlstr = [NSString stringWithFormat:@"%@/passport/edit_avstar?u_key=%@"
                        , self.serverAddress
                        , self.accessToken];
    NSURL *url = [[NSURL alloc]initWithString:urlstr];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    
    //准备数据
    NSData *imageData = UIImageJPEGRepresentation(avatarImg, 0.5);
    
    //adding the body:
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_img\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: application/octet-stream; charset=UTF-8\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:imageData];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPBody:postBody];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

#pragma mark - 私信接口
- (MDURLConnection *)loadCurrentUserMessagesWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"message/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *messagesDic = [dic objectForKey:@"messages"];
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *messageDic in messagesDic) {
            if (![messageDic isKindOfClass:[NSDictionary class]])
                continue;
            MDMessageAll *message = [[MDMessageAll alloc] initWithDictionary:messageDic];
            [messages addObject:message];
        }
        handler(messages, error);
    }];
    return connection;
}

- (MDURLConnection *)loadMessagesWithUserID:(NSString *)userID
                      pageSize:(NSInteger)size
                          page:(NSInteger)pages
                       handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"message/list?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    [urlString appendFormat:@"&pageindex=%d", pages];
    [urlString appendFormat:@"&pagesize=%d", size];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *messageDics = [dic objectForKey:@"messages"];
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *messageDic in messageDics) {
            if (![messageDic isKindOfClass:[NSDictionary class]])
                continue;
            MDMessage *message = [[MDMessage alloc] initWithDictionary:messageDic];
            [messages addObject:message];
        }
        handler(messages, error);
    }];
    return connection;
}

- (MDURLConnection *)sendMessageToUserID:(NSString *)userID
                    message:(NSString *)text
                       type:(NSInteger)type
                    handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"message/create?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    [urlString appendFormat:@"&msg=%@", [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [urlString appendFormat:@"&type=%d", type];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [req setHTTPMethod:@"POST"];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSString *objectID = [dic objectForKey:@"message"];
        handler(objectID, error);
    }];
    return connection;
}

- (MDURLConnection *)deleteMessageWithMessageID:(NSString *)mID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"message/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&m_id=%@", mID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)markMessageAsReadWithMessageID:(NSString *)mID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"message/read?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&m_id=%@", mID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

#pragma mark - 群组接口
- (MDURLConnection *)loadAllGroupsWithKeywords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *groupDics = [dic objectForKey:@"groups"];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *groupDic in groupDics) {
            if (![groupDic isKindOfClass:[NSDictionary class]])
                continue;
            MDGroup *group = [[MDGroup alloc] initWithDictionary:groupDic];
            [groups addObject:group];
        }
        handler(groups, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserCreatedGroupsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/my_created?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *groupDics = [dic objectForKey:@"groups"];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *groupDic in groupDics) {
            if (![groupDic isKindOfClass:[NSDictionary class]])
                continue;
            MDGroup *group = [[MDGroup alloc] initWithDictionary:groupDic];
            [groups addObject:group];
        }
        handler(groups, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserJoinedGroupsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/my_joined?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *groupDics = [dic objectForKey:@"groups"];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *groupDic in groupDics) {
            if (![groupDic isKindOfClass:[NSDictionary class]])
                continue;
            MDGroup *group = [[MDGroup alloc] initWithDictionary:groupDic];
            [groups addObject:group];
        }
        handler(groups, error);
    }];
    return connection;
}

- (MDURLConnection *)loadGroupsWithGroupID:(NSString *)gID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        MDGroup *group = [[MDGroup alloc] initWithDictionary:[dic objectForKey:@"group"]];
        handler(group, error);
    }];
    return connection;
}

- (MDURLConnection *)loadGroupMembersWithGroupID:(NSString *)gID handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/user?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userDic in userDics) {
            if (![userDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:userDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;
}

- (MDURLConnection *)exitGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/exit?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)joinGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/join?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)closeGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/close?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)openGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/open?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteGroupWithGroupID:(NSString *)gID handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)createGroupWithGroupName:(NSString *)gName
                        isPublic:(BOOL)isPub
                         handler:(MDAPIObjectHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/create?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_name=%@", gName];
    [urlString appendFormat:@"&is_public=%d", isPub?1:0];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        MDGroup *group = [[MDGroup alloc] initWithDictionary:[dic objectForKey:@"group"]];
        handler(group, error);
    }];
    return connection;
}

- (MDURLConnection *)inviteUserToGroupWithGroupID:(NSString *)gID
                               email:(NSString *)email
                             handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"group/invite?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&g_id=%@", gID];
    [urlString appendFormat:@"&email=%@", [[self class] encodeUrl:email]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

#pragma mark - 用户接口
- (MDURLConnection *)loadAllUsersWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/all?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userDic in userDics) {
            if (![userDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:userDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;
}

- (MDURLConnection *)loadUsersWithKeywords:(NSString *)keywords
                      groupID:(NSString *)gID
                   department:(NSString *)dep
                      handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/search?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (gID && gID.length > 0)
        [urlString appendFormat:@"&g_id=%@", gID];
    if (dep && dep.length > 0)
        [urlString appendFormat:@"&dep=%@", dep];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userDic in userDics) {
            if (![userDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:userDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;
}

- (MDURLConnection *)loadUserWithUserID:(NSString *)uID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        MDUser *aUser = [[MDUser alloc] initWithDictionary:[dic objectForKey:@"user"]];
        handler(aUser, error);
    }];
    return connection;
}

- (MDURLConnection *)loadUserFollowedByUserWithUserID:(NSString *)uID
                                 handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userDic in userDics) {
            if (![userDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:userDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;
}

- (MDURLConnection *)loadAllDepartmentsWithHandler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/department?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *depDics = [dic objectForKey:@"departments"];
        NSMutableArray *deps = [NSMutableArray array];
        for (NSDictionary *depDic in depDics) {
            if (![depDic isKindOfClass:[NSDictionary class]])
                continue;
            NSString *dep = [depDic objectForKey:@"name"];
            if (dep && dep.length > 0)
                [deps addObject:dep];
        }
        handler(deps, error);
    }];
    return connection;
}

- (MDURLConnection *)followUserWithUserID:(NSString *)userID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/add_followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unfollowUserWithUserID:(NSString *)userID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/delete_followed?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&u_id=%@", userID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)inviteUserToCompanyWithEmail:(NSString *)email
                            fullname:(NSString *)fullname
                                 msg:(NSString *)msg
                                type:(NSInteger)type
                             handler:(MDAPIBoolHandler)handler
{
#warning NOT TESTED
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/invite?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&email=%@", [[self class] encodeUrl:email]];
    [urlString appendFormat:@"&fullname=%@", [fullname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [urlString appendFormat:@"&msg=%@", [msg?msg:@"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (type == 0 || type == 1)
        [urlString appendFormat:@"&type=%d", type];

    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadFavouritedUsersWithHandler:(MDAPIObjectHandler)handler
{
    
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/frequent?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *userDics = [dic objectForKey:@"users"];
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userDic in userDics) {
            if (![userDic isKindOfClass:[NSDictionary class]])
                continue;
            MDUser *user = [[MDUser alloc] initWithDictionary:userDic];
            [users addObject:user];
        }
        handler(users, error);
    }];
    return connection;

}

- (MDURLConnection *)favouriteUserWithUserID:(NSString *)uID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/add_frequent?format=json"];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)unfavouriteUserWithUserID:(NSString *)uID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"user/delete_frequent?format=json"];
    [urlString appendFormat:@"&u_id=%@", uID];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

#pragma mark - 日程中心
- (MDURLConnection *)subscribeCalendar:(MDAPINSStringHandler)handler
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/todo?u_key=%@&rssCal=1&format=json"
                        , self.serverAddress
                        , self.accessToken];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){        
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSString *urlString = [[dic objectForKey:@"calendar_url"] mutableCopy];
        handler(urlString, nil);
    }];
    return connection;
}

- (MDURLConnection *)createEventWithEventName:(NSString *)name
                 startDateString:(NSString *)sDateString
                   endDateString:(NSString *)eDateString
                        isAllDay:(BOOL)isAllday
                         address:(NSString *)address
                     description:(NSString *)des
                       isPrivate:(BOOL)isPrivate
                         userIDs:(NSArray *)uIDs
                          emails:(NSArray *)emails
                         handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"calendar/create?format=json"];
    [urlString appendFormat:@"&c_name=%@", name];
    [urlString appendFormat:@"&c_stime=%@", sDateString];
    [urlString appendFormat:@"&c_etime=%@", eDateString];
    [urlString appendFormat:@"&c_allday=%@", isAllday?@"1":@"0"];
    if (address && address.length > 0)
        [urlString appendFormat:@"&c_address=%@", address];
    if (des && des.length > 0)
        [urlString appendFormat:@"&c_des=%@", des];
    [urlString appendFormat:@"&c_private=%@", isPrivate?@"0":@"1"];
    if (uIDs && uIDs.count > 0)
        [urlString appendFormat:@"&c_mids=%@", [uIDs componentsJoinedByString:@","]];
    if (emails && emails.count > 0)
        [urlString appendFormat:@"&c_memails=%@", [emails componentsJoinedByString:@","]];

    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        

        NSString *eventID = [dic objectForKey:@"calendar"];
        handler(eventID, nil);
    }];
    return connection;
}

- (MDURLConnection *)saveEventWithEventID:(NSString *)eID
                        name:(NSString *)name
             startDateString:(NSString *)sDateString
               endDateString:(NSString *)eDateString
                    isAllDay:(BOOL)isAllday
                     address:(NSString *)address
                 description:(NSString *)des
                   isPrivate:(BOOL)isPrivate
                     handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"calendar/edit?format=json"];
    [urlString appendFormat:@"&c_id=%@", eID];
    [urlString appendFormat:@"&c_name=%@", name];
    [urlString appendFormat:@"&c_stime=%@", sDateString];
    [urlString appendFormat:@"&c_etime=%@", eDateString];
    [urlString appendFormat:@"&c_allday=%@", isAllday?@"1":@"0"];
    if (address && address.length > 0)
        [urlString appendFormat:@"&c_address=%@", address];
    if (des && des.length > 0)
        [urlString appendFormat:@"&c_des=%@", des];
    [urlString appendFormat:@"&c_private=%@", isPrivate?@"0":@"1"];
    
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)addUsersWithUserIDs:(NSArray *)uIDs
                     emails:(NSArray *)emails
                  toEventID:(NSString *)eID
                    handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/add_member?u_key=%@&c_id=%@&c_mids=%@&c_memails=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , eID
                        , uIDs.count > 0 ? [uIDs componentsJoinedByString:@","] : @""
                        , emails.count > 0 ? [emails componentsJoinedByString:@","] : @""
                        ];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteUserWithUserIDs:(NSArray *)uIDs
                       emails:(NSArray *)emails
                  fromEventID:(NSString *)eID
                      handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/delete_member?u_key=%@&c_id=%@&c_mids=%@&c_memails=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , eID
                        , uIDs.count > 0 ? [uIDs componentsJoinedByString:@","] : @""
                        , emails.count > 0 ? [emails componentsJoinedByString:@","] : @""
                        ];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)reinviteUserWithUserIDs:(NSArray *)uIDs
                         emails:(NSArray *)emails
                      toEventID:(NSString *)eID
                        handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/reinvite_member?u_key=%@&c_id=%@&c_mids=%@&c_memails=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , eID
                        , uIDs.count > 0 ? [uIDs componentsJoinedByString:@","] : @""
                        , emails.count > 0 ? [emails componentsJoinedByString:@","] : @""
                        ];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)loadEvents:(MDAPINSArrayHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/todo?u_key=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        ];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (MDURLConnection *)loadEventsForDay:(NSString *)yearMonthAndDay handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"calendar/day?format=json"];
    [urlString appendFormat:@"&date=%@", yearMonthAndDay];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (MDURLConnection *)loadEventsForWeek:(NSInteger)week
                     year:(NSInteger)year
                  handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"calendar/week?format=json"];
    [urlString appendFormat:@"&year=%d", year];
    [urlString appendFormat:@"&week=%d", week];    
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (MDURLConnection *)loadEventsForMonth:(NSString *)yearAndMonth handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"calendar/month?format=json"];
    [urlString appendFormat:@"&date=%@", yearAndMonth];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSMutableArray *returnEvents = [NSMutableArray array];
        for (NSDictionary *aDic in [dic objectForKey:@"calendars"]) {
            MDEvent *aEvent = [[MDEvent alloc] initWithDictionary:aDic];
            [returnEvents addObject:aEvent];
        }
        
        handler(returnEvents, error);
    }];
    return connection;
}

- (MDURLConnection *)loadEventWithObjectID:(NSString *)objectID handler:(MDAPIObjectHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/detail?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(NO, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSDictionary *aDic = [dic objectForKey:@"calendar"];
        MDEvent *returnEvent = [[MDEvent alloc] initWithDictionary:aDic];
        handler(returnEvent, error);
    }];
    return connection;
}

- (MDURLConnection *)deleteEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/destroy?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)exitEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/exit?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)acceptEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/join?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)rejectEventWithObjectID:(NSString *)objectID handler:(MDAPIBoolHandler)handler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/calendar/deny?u_key=%@&c_id=%@&format=json"
                        , self.serverAddress
                        , self.accessToken
                        , objectID];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

#pragma mark - 任务接口
- (MDURLConnection *)loadCurrentUserJoinedTasksWithKeywords:(NSString *)keywords
                                            allOrUnfinished:(BOOL)allOrUnFinished
                                                    handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/my_joined?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (allOrUnFinished)
        [urlString appendString:@"&f_type=0"];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserJoinedFinishedTasksWithPageSize:(NSInteger)size
                                                         page:(NSInteger)page
                                                      handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/my_joined_finished?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", size];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%d", page];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserAssignedTasksWithKeywords:(NSString *)keywords
                                              allOrUnfinished:(BOOL)allOrUnFinished
                                                      handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/my_assign?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (allOrUnFinished)
        [urlString appendString:@"&f_type=0"];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserAssignedFinishedTasksWithPageSize:(NSInteger)size
                                                                 page:(NSInteger)page
                                                              handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/my_assign_finished?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", size];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%d", page];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserChargedTasksWithKeywords:(NSString *)keywords
                                             allOrUnfinished:(BOOL)allOrUnFinished
                                                     handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/my_charge?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];
    if (allOrUnFinished)
        [urlString appendString:@"&f_type=0"];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadCurrentUserChargedFinishedTasksWithPageSize:(NSInteger)size
                                                                page:(NSInteger)page
                                                             handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/my_charge_finished?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", size];
    if (page > 0)
        [urlString appendFormat:@"&pageindex=%d", page];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *taskDics = [dic objectForKey:@"tasks"];
        NSMutableArray *tasks = [NSMutableArray array];
        for (NSDictionary *taskDic in taskDics) {
            if (![taskDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:taskDic];
            [tasks addObject:task];
        }
        handler(tasks, error);
    }];
    return connection;
}

- (MDURLConnection *)loadProjectsWithKeywords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/project?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    if (keywords && keywords.length > 0)
        [urlString appendFormat:@"&keywords=%@", keywords];

    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *projectDics = [dic objectForKey:@"projects"];
        NSMutableArray *projects = [NSMutableArray array];
        for (NSDictionary *projectDic in projectDics) {
            if (![projectDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTask *task = [[MDTask alloc] initWithDictionary:projectDic];
            [projects addObject:task];
        }
        handler(projects, error);
    }];
    return connection;
}

- (MDURLConnection *)loadTaskWithTaskID:(NSString *)tID handler:(MDAPIObjectHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/detail?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSDictionary *projectDic = [dic objectForKey:@"task"];
        MDTask *task = [[MDTask alloc] initWithDictionary:projectDic];
        handler(task, error);
    }];
    return connection;
}

- (MDURLConnection *)loadTaskReplymentsWithTaskID:(NSString *)tID maxID:(NSString *)maxTID pageSize:(NSInteger)size handler:(MDAPINSArrayHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/reply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    if (maxTID)
        [urlString appendFormat:@"&max_id=%@", maxTID];
    if (size > 0)
        [urlString appendFormat:@"&pagesize=%d", size];
    
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSArray *replyDics = [dic objectForKey:@"replyments"];
        NSMutableArray *replies = [NSMutableArray array];
        for (NSDictionary *replyDic in replyDics) {
            if (![replyDic isKindOfClass:[NSDictionary class]])
                continue;
            MDTaskReplyment *reply = [[MDTaskReplyment alloc] initWithDictionary:replyDic];
            [replies addObject:reply];
        }
        handler(replies, error);
    }];
    return connection;
}

- (MDURLConnection *)createTaskWithTaskName:(NSString *)name
                                description:(NSString *)des
                              endDateString:(NSString *)endDateString
                                  chargerID:(NSString *)chargerID
                                  memberIDs:(NSArray *)memberIDs
                                  projectID:(NSString *)projectID
                                    handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/create?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_title=%@", name];
    [urlString appendFormat:@"&t_ed=%@", endDateString];
    
    if (des && des.length > 0)
        [urlString appendFormat:@"&t_des=%@", des];
    if (memberIDs && memberIDs.count > 0)
        [urlString appendFormat:@"&t_mids=%@", [memberIDs componentsJoinedByString:@","]];
    if (chargerID && chargerID.length > 0)
        [urlString appendFormat:@"&u_id=%@", chargerID];
    if (projectID && projectID.length > 0)
        [urlString appendFormat:@"&t_pid=%@", projectID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSString *taskID = [dic objectForKey:@"task"];
        handler(taskID, nil);
    }];
    return connection;
}

- (MDURLConnection *)createProjectWithName:(NSString *)name handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/add_project?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&title=%@", name];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSString *projectID = [dic objectForKey:@"project"];
        handler(projectID, nil);
    }];
    return connection;
}

- (MDURLConnection *)createTaskReplymentOnTaskWithTaskID:(NSString *)tID
                                                 message:(NSString *)message
                                 replyToReplymentWithRID:(NSString *)rID
                                                   image:(UIImage *)image
                                                 handler:(MDAPINSStringHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/addreply?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&r_msg=%@", message];
    if (rID && rID.length > 0)
        [urlString appendFormat:@"&r_id=%@", rID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [req setHTTPMethod:@"POST"];
    
    if (image) {
        [urlString appendFormat:@"&r_img=%@", UIImageJPEGRepresentation(image, 0.5)];
        NSString *boundary = @"-----------------MINGDAO-----------------";
        NSString *filename = @"photo.jpg";
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
        [req setValue:contentType forHTTPHeaderField:@"Content-type"];
        
        //准备数据
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        //adding the body:
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"r_img\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"Content-Type: application/octet-stream; charset=UTF-8\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:imageData];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [req setHTTPBody:postBody];
    }
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        NSDictionary *dic = [data objectFromJSONData];
        if (!dic  || ![dic isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON ERROR");
            return ;
        }
        NSDictionary *errorDic = [dic objectForKey:@"error_code"];
        if (errorDic) {
            handler(nil, [NSError errorWithDomain:MDAPIErrorDomain code:0 userInfo:errorDic]);
            return;
        }
        
        NSString *taskID = [dic objectForKey:@"replyment"];
        handler(taskID, nil);
    }];
    return connection;
}

- (MDURLConnection *)finishTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/finish?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/delete?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                                  title:(NSString *)title
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/edit_title?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&t_title=%@", title];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                                    des:(NSString *)des
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/edit_des?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&des=%@", des];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              chargerID:(NSString *)chargerID
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/edit_charge?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", chargerID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                          endDateString:(NSString *)endDateString
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/edit_expiredate?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&expiredate=%@", endDateString];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              projectID:(NSString *)projectID
                                handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/edit_project?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&p_id=%@", projectID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)addMemberToTaskWithTaskID:(NSString *)tID
                                      memberID:(NSString *)memberID
                                       handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/add_member?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", memberID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}

- (MDURLConnection *)deleteMemberFromeTaskWithTaskID:(NSString *)tID
                                            memberID:(NSString *)memberID
                                             handler:(MDAPIBoolHandler)handler
{
    NSMutableString *urlString = [self.serverAddress mutableCopy];
    [urlString appendString:@"task/delete_member?format=json"];
    [urlString appendFormat:@"&access_token=%@", self.accessToken];
    [urlString appendFormat:@"&t_id=%@", tID];
    [urlString appendFormat:@"&u_id=%@", memberID];
    
    NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(NSData *data, NSError *error){
        [self handlerBoolData:data error:error handler:handler];
    }];
    return connection;
}
@end
