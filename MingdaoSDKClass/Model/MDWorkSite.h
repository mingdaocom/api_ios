//
//  MDWorkSite.h
//  MingdaoV2
//
//  Created by yyp on 15/1/28.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDWorkSite : NSObject

@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
@property (assign, nonatomic) NSInteger userCount;
@property (assign, nonatomic) NSArray *members;

- (MDWorkSite *)initWithDictionary:(NSDictionary *)aDic;

@end
