//
//  MDProject.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-5.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"

@interface MDProject : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;

- (MDProject *)initWithDictionary:(NSDictionary *)aDic;
@end

@interface MDTaskFolder : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;

@property (strong, nonatomic) NSString *createDateString;
@property (strong, nonatomic) NSString *deadLine;

@property (assign, nonatomic) int unreadDiscussCount;
@property (assign, nonatomic) int taskInProgressCount;
@property (assign, nonatomic) int taskCompletedCount;

@property (assign, nonatomic) int colorType;

@property (strong, nonatomic) NSString *creatorID;
@property (strong, nonatomic) MDUser *charger;

@property (readonly, nonatomic) BOOL isCompleted;
- (MDTaskFolder *)initWithDictionary:(NSDictionary *)aDic;
@end
