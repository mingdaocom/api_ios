//
//  MDTaskActivity.h
//  MingdaoV2
//
//  Created by yyp on 15/6/19.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDTaskActivity : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *avatar;
@property (assign, nonatomic) NSInteger actType;
@property (strong, nonatomic) NSString *msg;


- (MDTaskActivity *)initWithDictionary:(NSDictionary *)aDic;

@end
