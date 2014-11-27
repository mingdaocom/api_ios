//
//  MDTaskFolderStage.h
//  MingdaoV2
//
//  Created by Wee Tom on 14/11/26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDTaskFolderStage : NSObject
@property (strong, nonatomic) NSString *objectName, *objectID;
@property (assign, nonatomic) int number;
- (MDTaskFolderStage *)initWithDictionary:(NSDictionary *)dic;
@end
