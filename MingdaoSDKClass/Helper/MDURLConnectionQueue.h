//
//  MDURLConnectionQueue.h
//  MingdaoV2
//
//  Created by Wee Tom on 13-8-28.
//  Copyright (c) 2013年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MDAPIConnectionQueueHandler)(NSInteger lastFinishedIndex, CGFloat progress, NSData *data, NSError *error);

@interface MDURLConnectionQueue : NSObject
- (MDURLConnectionQueue *)initWithRequest:(NSArray *)requests handler:(MDAPIConnectionQueueHandler)handler;
@property (assign, nonatomic) BOOL stopWhenError;
@property (assign, nonatomic) NSTimeInterval timeOut;
- (void)start;
- (void)cancel;
@end
