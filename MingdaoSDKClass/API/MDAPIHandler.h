//
//  MDAPIHandler.h
//  Mingdao
//
//  Created by Wee Tom on 13-6-3.
//  
//

#import "MDURLConnection.h"
#import "MDURLConnectionQueue.h"
#import "MDCompany.h"
#import "MDUser.h"
#import "MDMessageAll.h"
#import "MDMessage.h"
#import "MDGroup.h"
#import "MDEvent.h"
#import "MDTask.h"
#import "MDTaskReplyment.h"
#import "MDTaskMessage.h"
#import "MDTaskSystemMessage.h"
#import "MDTaskReplyMessage.h"
#import "MDTaskMentionedMessage.h"
#import "MDPost.h"
#import "MDPostReplyment.h"
#import "MDTag.h"
#import "MDPostAt.h"

typedef void (^MDAPIBoolHandler)(BOOL success, NSError *error);
typedef void (^MDAPIObjectHandler)(id object, NSError *error);
typedef void (^MDAPINSIntegerHandler)(NSInteger count, NSError *error);
typedef void (^MDAPINSDictionaryHandler)(NSDictionary *dictionary, NSError *error);
typedef void (^MDAPINSArrayHandler)(NSArray *objects, NSError *error);
typedef void (^MDAPINSStringHandler)(NSString *string, NSError *error);
typedef void (^MDAPIQueueBoolHandler)(NSInteger lastFinishedIndex, CGFloat progress, BOOL succeed, NSError *error);