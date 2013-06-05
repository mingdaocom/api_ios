//
//  MDMessage.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-4.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDMessage : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *createUserID;
@property (assign, nonatomic) BOOL read, beenRead;

- (MDMessage *)initWithDictionary:(NSDictionary *)aDic;
@end
