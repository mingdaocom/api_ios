//
//  MDPost.h
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-6.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUser.h"
#import "MDGroup.h"
#import "MDTag.h"

@interface MDVoteOption : NSObject
@property (strong, nonatomic) NSArray *members;
@property (strong, nonatomic) NSString *objectName;
@property (assign, nonatomic) NSInteger voteCount;
- (MDVoteOption *)initWithDictionary:(NSDictionary *)dic;
@end

@interface MDPostDetail : NSObject
@property (assign, nonatomic) BOOL isAnonymous, isVisble;
@property (assign, nonatomic) NSInteger maxChoiceCount;
@property (strong, nonatomic) NSString *deadLineString;
@property (strong, nonatomic) NSString *postGUID;
@property (assign, nonatomic) BOOL isInCenter;
@property (strong, nonatomic) NSString *linkDes, *linkTitle, *linkURL;
@property (strong, nonatomic) NSString *middlePic, *originalPic, *thumbnailPic, *originalDoc;
@property (strong, nonatomic) NSArray *voteOptions;
- (MDPostDetail *)initWithDictionary:(NSDictionary *)dic;
@end

@interface MDPost : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *autoID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *source;
@property (assign, nonatomic) NSInteger replyCount;
@property (assign, nonatomic) NSInteger likeCount;
@property (assign, nonatomic) BOOL isFavourited;
@property (assign, nonatomic) BOOL isLiked;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger shareType;
@property (assign, nonatomic) NSArray *details; // not done
@property (strong, nonatomic) NSDictionary *textAttribute;
@property (strong, nonatomic) NSArray *groups;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) MDPost *repost;
- (MDPost *)initWithDictionary:(NSDictionary *)aDic;
@end
