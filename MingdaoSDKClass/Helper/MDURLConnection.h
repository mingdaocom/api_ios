//
//  MDURLConnection.h
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import <Foundation/Foundation.h>

typedef void (^MDAPINSDataHandler)(NSData *data, NSError *error);
typedef void (^MDAPICGFloatHandler)(CGFloat fValue);

@interface MDURLConnection : NSObject
- (MDURLConnection *)initWithRequest:(NSURLRequest *)request handler:(MDAPINSDataHandler)handler;
@property (readonly, nonatomic) NSURLRequest *request;
@property (assign, nonatomic) NSTimeInterval timeOut;
@property (copy, nonatomic) MDAPICGFloatHandler downloadProgressHandler, uploadProgressHandler;
- (void)start;
- (void)cancel;
@end
