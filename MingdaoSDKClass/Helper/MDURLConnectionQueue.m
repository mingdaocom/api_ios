//
//  MDURLConnectionQueue.m
//  MingdaoV2
//
//  Created by Wee Tom on 13-8-28.
//  Copyright (c) 2013年 Mingdao. All rights reserved.
//

#import "MDURLConnectionQueue.h"

@interface MDURLConnectionQueue () <NSURLConnectionDataDelegate>
@property (strong, nonatomic) NSArray *requests;
@property (copy, nonatomic) MDAPIConnectionQueueHandler handler;
@property (assign, nonatomic) NSInteger currentQueue;
@property (strong, nonatomic) NSURLConnection *currentConnection;
@property (strong, nonatomic) NSMutableData *currentAppendingData;
@end

@implementation MDURLConnectionQueue
- (MDURLConnectionQueue *)initWithRequest:(NSArray *)requests handler:(MDAPIConnectionQueueHandler)handler
{
    self = [super init];
    if (self) {
        self.requests = requests;
        self.handler = handler;
        self.currentQueue = 0;
        self.currentConnection = nil;
    }
    return self;
}

- (void)start
{
    [self startNextConnection];
}

- (void)startNextConnection
{    
    if (self.currentQueue == self.requests.count) {
        return;
    }
    
    NSMutableURLRequest *req = (NSMutableURLRequest *)[self.requests[self.currentQueue] mutableCopy];
    if (self.timeOut > 0) {
        req.timeoutInterval = self.timeOut;
    } else
        req.timeoutInterval = 60;
    NSLog(@"%@", [req.URL absoluteString]);
    
    self.currentAppendingData = [NSMutableData data];
    self.currentConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    self.currentQueue ++;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.currentAppendingData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.handler(self.currentQueue - 1, [self progress], nil, error);
    if (self.stopWhenError) {
        [self cancel];
        return;
    }
    [self startNextConnection];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.handler(self.currentQueue - 1, [self progress], self.currentAppendingData, nil);
    [self startNextConnection];
}


- (CGFloat)progress
{
    CGFloat queue = self.currentQueue;
    CGFloat count = self.requests.count;
    return queue/count;
}

- (void)cancel
{
    if (self.currentConnection) {
        [self.currentConnection cancel];
    }
    [self exit];
}

- (void)exit
{
    self.currentConnection = nil;
    self.requests = nil;
    self.currentAppendingData = nil;
    self.handler = nil;
}
@end
