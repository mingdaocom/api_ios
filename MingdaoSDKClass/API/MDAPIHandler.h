//
//  MDAPIHandler.h
//  Mingdao
//
//  Created by Wee Tom on 13-6-3.
//  
//

#import "MDURLConnection.h"
#import "MDURLConnectionQueue.h"

#define BoolStr(BOOL) BOOL?@"true":@"false"

typedef void (^MDAPIBoolHandler)(BOOL success, NSError *error);
typedef void (^MDAPIObjectHandler)(id object, NSError *error);
typedef void (^MDAPINSIntegerHandler)(NSInteger count, NSError *error);
typedef void (^MDAPINSDictionaryHandler)(NSDictionary *dictionary, NSError *error);
typedef void (^MDAPINSArrayHandler)(NSArray *objects, NSError *error);
typedef void (^MDAPINSStringHandler)(NSString *string, NSError *error);
typedef void (^MDAPIQueueBoolHandler)(NSInteger lastFinishedIndex, float progress, BOOL succeed, NSError *error);
