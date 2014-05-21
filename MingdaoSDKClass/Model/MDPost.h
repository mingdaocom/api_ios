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
@property (assign, nonatomic) int voteCount;
@property (strong, nonatomic) NSString *originalPic, *thumbnailPic;
@property (assign, nonatomic) BOOL selected;
- (MDVoteOption *)initWithDictionary:(NSDictionary *)dic;
@end

@interface MDPostDetail : NSObject
@property (assign, nonatomic) BOOL isAnonymous, isVisble;
@property (assign, nonatomic) int maxChoiceCount;
@property (strong, nonatomic) NSString *deadLineString;
@property (strong, nonatomic) NSString *postGUID;
@property (assign, nonatomic) BOOL isInCenter;
@property (strong, nonatomic) NSString *linkDes, *linkTitle, *linkURL;
@property (strong, nonatomic) NSString *middlePic, *originalPic, *fileName, *thumbnailPic, *originalDoc;
@property (strong, nonatomic) NSString *videoUrl;
@property (strong, nonatomic) NSArray *voteOptions;
@property (assign, nonatomic) BOOL isDownloadable;

@property (readonly, nonatomic) BOOL voted;
@property (readonly, nonatomic) int totalVoteCount;
- (MDPostDetail *)initWithDictionary:(NSDictionary *)dic;
@end

enum {
    MDPostShareTypeSystem = -1,
    MDPostShareTypeFollowed = 0,
    MDPostShareTypeGroups = 1,
    MDPostShareTypeFollowedAndGroups = 2,
    MDPostShareTypeSelf = 3,
    MDPostShareTypeAll = 4
};
typedef int MDPostShareType;

enum {
    MDPostTypeAll = -1,
    MDPostTypeText = 0,
    MDPostTypeLink = 1,
    MDPostTypeImage = 2,
    MDPostTypeDocument = 3,
    MDPostTypeFAQ = 4,
    MDPostTypeVote = 7,
    MDPostTypeVideoAndAudio = 8
};
typedef int MDPostType;

@interface MDPost : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *autoID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *source;
@property (assign, nonatomic) int replyCount, likeCount, repostCount;
@property (assign, nonatomic) BOOL isFavourited;
@property (assign, nonatomic) BOOL isLiked;
@property (assign, nonatomic) MDPostType type;
@property (assign, nonatomic) MDPostShareType shareType;
@property (strong, nonatomic) NSArray *details;
@property (strong, nonatomic) NSDictionary *textAttribute;
@property (strong, nonatomic) NSArray *groups;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) MDPost *repost;
@property (assign, nonatomic) BOOL isAnswerred;
@property (assign, nonatomic) int mark;

@property (readonly, nonatomic) MDPostDetail *firstDetail;

- (MDPost *)initWithDictionary:(NSDictionary *)aDic;
@end
