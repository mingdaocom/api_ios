//
//  MDTaskReplyment.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"

@interface MDTaskReplyment : NSObject
@property (strong, nonatomic) NSString *objectID, *autoID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createDateString, *source;
@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSString *original_file;
@property (assign, nonatomic) BOOL isDownloadAble;
@property (strong, nonatomic) NSArray *thumbnailPics, *originalPics;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) MDUser *replyTo;
@property (strong, nonatomic) NSString *fileName;

- (MDTaskReplyment *)initWithDictionary:(NSDictionary *)aDic;
@end
