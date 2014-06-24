//
//  MDProject.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-5.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    MDProjectWithColor = 0,
    MDProjectBlueColor = 1,
    MDProjectPurpleColor = 2,
    MDProjectRedColor = 3,
    MDProjectOrangeColor = 4,
    MDProjectYellowColor = 5
};
typedef int MDProjectColor;

@interface MDProject : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;

@property (strong, nonatomic) NSString *deadLine;
@property (strong, nonatomic) NSString *completedDate;
@property (assign, nonatomic) int taskInProgressCount;
@property (assign, nonatomic) int taskCompletedCount;

@property (assign, nonatomic) int projectColor;

@property (assign, nonatomic) BOOL isCompleted;
- (MDProject *)initWithDictionary:(NSDictionary *)aDic;
@end
