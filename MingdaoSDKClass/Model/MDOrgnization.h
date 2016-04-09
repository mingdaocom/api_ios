//
//  MDProject.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MDOrgnizationTypeFree = 0,
    MDOrgnizationTypeTrial = 1,
    MDOrgnizationTypePremium = 2
} MDOrgnizationType;

@interface MDOrgnization : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
@property (strong, nonatomic) NSString *nameEn, *logo;
@property (assign, nonatomic) MDOrgnizationType type;
@property (strong, nonatomic) NSString *expireDays;
- (MDOrgnization *)initWithDictionary:(NSDictionary *)aDic;
@end
