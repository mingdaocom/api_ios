//
//  MDURLConnection.h
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import <Foundation/Foundation.h>

typedef void (^MDAPINSDataHandler)(NSData *data, NSError *error);

@interface MDURLConnection : NSObject
- (MDURLConnection *)initWithRequest:(NSURLRequest *)request handler:(MDAPINSDataHandler)handler;

- (void)start;
- (void)cancel;
@end
