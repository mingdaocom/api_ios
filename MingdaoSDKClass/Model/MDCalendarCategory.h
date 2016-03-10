//
//  MDCalendarCategory.h
//  MingdaoV2
//
//  Created by yyp on 14/12/11.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCalendarCategory : NSObject

@property (strong, nonatomic) NSString *catID;
@property (strong, nonatomic) NSString *catName;
@property (assign, nonatomic) NSInteger displayOrder;
@property (assign, nonatomic) int color;

- (MDCalendarCategory *)initWithDictionary:(NSDictionary *)aDic;

@end
