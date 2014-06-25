//
//  MDProject.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-5.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MDProject : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;

@property (strong, nonatomic) NSString *deadLine;
@property (strong, nonatomic) NSString *completedDate;
@property (assign, nonatomic) int taskInProgressCount;
@property (assign, nonatomic) int taskCompletedCount;

@property (assign, nonatomic) int colorType;

@property (assign, nonatomic) BOOL isCompleted;
- (MDProject *)initWithDictionary:(NSDictionary *)aDic;
@end
