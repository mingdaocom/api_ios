//
//  MDDepartment.h
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDDepartment : NSObject

@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
@property (assign, nonatomic) NSInteger membersCount;
@property (strong, nonatomic) NSString *mappingGroupName;
@property (strong, nonatomic) NSString *mappingGroupID;
@property (strong, nonatomic) NSString *comment;
@property (assign, nonatomic) NSInteger allCount;

- (MDDepartment *)initWithDictionary:(NSDictionary *)aDic;


@end
