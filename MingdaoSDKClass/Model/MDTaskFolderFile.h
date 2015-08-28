//
//  MDTaskFolderFile.h
//  MingdaoV2
//
//  Created by yyp on 15/8/25.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDTaskFolderFile : NSObject

@property (strong, nonatomic) NSString *objectName, *objectID;
@property (assign, nonatomic) NSInteger sort;
@property (strong, nonatomic) NSMutableArray *folders;

- (MDTaskFolderFile *)initWithDictionary:(NSDictionary *)dic;

@end
