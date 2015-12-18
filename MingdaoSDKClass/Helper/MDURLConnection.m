//
//  MDURLConnection.m
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//  Refactored by Wee Tom on 15-9-30
//

#import "MDURLConnection.h"
#import "MDErrorParser.h"

NSString *MDURLConnectionErrorOccurred = @"MDURLConnectionErrorOccurred";

@interface MDURLConnection ()
@property (strong, nonatomic) NSMutableURLRequest *req;
@property (strong, nonatomic) NSURLSessionDataTask *task;
@property (copy,   nonatomic) MDAPIHandler handler;
@end

@implementation MDURLConnection
- (void)dealloc
{
    _req = nil;
    _task = nil;
    _handler = nil;
}

- (MDURLConnection *)initWithRequest:(NSURLRequest *)request handler:(MDAPIHandler)handler
{
    self = [super init];
    if (self) {
        self.req = [request mutableCopy];
        if (self.timeOut > 0) {
            self.req.timeoutInterval = self.timeOut;
        } else {
            self.req.timeoutInterval = 30;
        }
        self.handler = handler;
        self.errorNotification = YES;
    }
    return self;
}

- (void)start
{
    NSURLSession *session = self.session;
    if (!session) {
        session = [NSURLSession sharedSession];
    }
    
    self.task = [session dataTaskWithRequest:self.req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_queue_t    mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if (error) {
                if (error && self.errorNotification) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:MDURLConnectionErrorOccurred object:self userInfo:@{@"error":error}];
                }
                if (_handler) {
                    _handler(self, nil, error);
                    _handler = nil;
                }
            }
            else {
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
                if (!jsonObject) {
                    NSError *error = [MDErrorParser errorWithMDDic:nil URLString:self.req.URL.absoluteString];
                    if (error && self.errorNotification) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:MDURLConnectionErrorOccurred object:self userInfo:@{@"error":error}];
                    }
                    if (_handler) {
                        _handler(self, data, error);
                        _handler = nil;
                    }
                    return ;
                }
                
                if ([jsonObject isKindOfClass:[NSArray class]]) {
                    if (_handler) {
                        _handler(self, jsonObject, error);
                        _handler = nil;
                    }
                    return;
                }
                else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                    NSError *error = [MDErrorParser errorWithMDDic:jsonObject URLString:self.req.URL.absoluteString];
                    if (error) {
                        if (self.errorNotification) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:MDURLConnectionErrorOccurred object:self userInfo:@{@"error":error}];
                        }
                        if (_handler) {
                            _handler(self, jsonObject, error);
                            _handler = nil;
                        }
                        return;
                    }
                }
                
                if (_handler) {
                    _handler(self, jsonObject, error);
                    _handler = nil;
                }
            }
        });
    }];
    if (self.task) {
#ifdef DEBUG
        NSLog(@"%@", [self.req.URL absoluteString]);
#endif
        
#pragma mark Test for API
        if ([self.req.HTTPMethod isEqualToString:@"POST"]) {
            NSLog(@"%@",[[NSString alloc] initWithData:self.req.HTTPBody encoding:NSUTF8StringEncoding]);
        }
        [self.task resume];
    }
}

- (void)cancel
{
    if (self.task) {
        [self.task cancel];
        self.handler = nil;
        self.task = nil;
    }
}

- (NSURLRequest *)request
{
    return self.req;
}
@end
