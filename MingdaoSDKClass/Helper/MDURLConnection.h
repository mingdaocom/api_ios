//
//  MDURLConnection.h
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import <Foundation/Foundation.h>

extern NSString *MDURLConnectionErrorOccurred;

@class MDURLConnection;
typedef void (^MDAPIHandler)(MDURLConnection *theConnection, id jsonObjectOrRawDataIfError, NSError *error);
typedef void (^MDAPICGFloatHandler)(float fValue);

@interface MDURLConnection : NSObject
- (MDURLConnection *)initWithRequest:(NSURLRequest *)request handler:(MDAPIHandler)handler;
@property (assign, nonatomic) BOOL errorNotification; // default: Yes
@property (readonly, nonatomic) NSURLRequest *request;
@property (assign, nonatomic) NSTimeInterval timeOut;
@property (copy, nonatomic) MDAPICGFloatHandler downloadProgressHandler, uploadProgressHandler;
- (void)start;
- (void)cancel;
@end
