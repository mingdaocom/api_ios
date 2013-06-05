//
//  MDProject.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCompany : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
- (MDCompany *)initWithDictionary:(NSDictionary *)aDic;
@end
