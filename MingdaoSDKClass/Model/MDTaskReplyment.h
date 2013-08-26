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
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createDateString, *source;
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSString *original_file, *original_pic, *thumbnail_pic;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) MDUser *replyTo;

- (MDTaskReplyment *)initWithDictionary:(NSDictionary *)aDic;
@end
