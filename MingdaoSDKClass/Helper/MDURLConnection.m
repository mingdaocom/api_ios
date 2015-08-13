//
//  MDURLConnection.m
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import "MDURLConnection.h"
#import "MDErrorParser.h"

NSString *MDURLConnectionErrorOccurred = @"MDURLConnectionErrorOccurred";

@interface MDURLConnection () <NSURLConnectionDataDelegate>
@property (strong, nonatomic) NSMutableURLRequest *req;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *appendingData;
@property (copy,   nonatomic) MDAPIHandler handler;
@property (assign, nonatomic) long long totalLength, currentLength;
@property (assign, nonatomic) int statusCode;
@end

@implementation MDURLConnection
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
        self.connection = [[NSURLConnection alloc] initWithRequest:self.req delegate:self startImmediately:NO];
        self.handler = handler;
        
        self.errorNotification = YES;
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.statusCode = (int)[((NSHTTPURLResponse *)response) statusCode];
    self.totalLength = [response expectedContentLength];
    self.currentLength = 0;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (error && self.errorNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MDURLConnectionErrorOccurred object:self userInfo:@{@"error":error}];
    }
    self.handler(self, nil, error);
    self.handler = nil;
    self.downloadProgressHandler = nil;
    self.uploadProgressHandler = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.currentLength += [data length];
    if (self.downloadProgressHandler) {
        self.downloadProgressHandler(self.currentLength/(float)self.totalLength);
    }
    [self.appendingData appendData:data];
}

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
                                                 totalBytesWritten:(NSInteger)totalBytesWritten
                                         totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if (self.uploadProgressHandler) {
        float progress = [[NSNumber numberWithInteger:totalBytesWritten] floatValue];
        float total = [[NSNumber numberWithInteger: totalBytesExpectedToWrite] floatValue];
        self.uploadProgressHandler(progress/total);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSData *data = self.appendingData;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    if (!jsonObject) {
        NSError *error = [MDErrorParser errorWithMDDic:nil URLString:self.req.URL.absoluteString];
        if (error && self.errorNotification) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MDURLConnectionErrorOccurred object:self userInfo:@{@"error":error}];
        }
        self.handler(self, data, error);
        self.handler = nil;
        self.downloadProgressHandler = nil;
        self.uploadProgressHandler = nil;
        return ;
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        self.handler(self, jsonObject, nil);
        return;
    } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSError *error = [MDErrorParser errorWithMDDic:jsonObject URLString:self.req.URL.absoluteString];
        if (error) {
            if (self.errorNotification) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MDURLConnectionErrorOccurred object:self userInfo:@{@"error":error}];
            }
            self.handler(self, jsonObject, error);
            self.handler = nil;
            self.downloadProgressHandler = nil;
            self.uploadProgressHandler = nil;
            return;
        }
    }
    
    self.handler(self, jsonObject, nil);
    self.handler = nil;
    self.downloadProgressHandler = nil;
    self.uploadProgressHandler = nil;
}

- (void)start
{
    if (self.connection) {

#ifdef DEBUG
        NSLog(@"%@", [self.req.URL absoluteString]);
#endif
        self.appendingData = [NSMutableData data];
        [self.connection start];
    }
}

- (void)cancel
{
    if (self.connection) {
        [self.connection cancel];
        self.handler = nil;
        self.connection = nil;
        self.appendingData = nil;
    }
}

- (NSURLRequest *)request
{
    return self.req;
}

- (void)dealloc
{
    self.req = nil;
    self.connection = nil;
    self.handler = nil;
    self.appendingData = nil;
}
@end
