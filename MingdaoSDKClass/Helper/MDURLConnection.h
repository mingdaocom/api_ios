//
//  MDURLConnection.h
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//  Refactored by Wee Tom on 15-9-30
//

#import <Foundation/Foundation.h>

extern NSString *MDURLConnectionErrorOccurred;

@class MDURLConnection;
typedef void (^MDAPIHandler)(MDURLConnection *theConnection, id jsonObjectOrRawDataIfError, NSError *error);

@interface MDURLConnection : NSObject
- (MDURLConnection *)initWithRequest:(NSURLRequest *)request handler:(MDAPIHandler)handler;

/**
 *  use custom session to change task rule, set before call start or else use [NSURLSession sharedSession]
 */
@property (strong, nonatomic) NSURLSession *session;

/**
 *  post notification when error occur, default to YES
 */
@property (assign, nonatomic) BOOL errorNotification;

/**
 *  current request
 */
@property (readonly, nonatomic) NSURLRequest *request;

/**
 *  timeout default to 30
 */
@property (assign, nonatomic) NSTimeInterval timeOut;

/**
 * start the task, call the handler when completion or error occurred
 */
- (void)start;

/**
 *  cancel the task without calling the handler
 */
- (void)cancel;
@end
