//
//  MDPostAt.h
//  MingdaoV2
//
//  Created by Wee Tom on 13-10-18.
//  Copyright (c) 2013年 Mingdao. All rights reserved.
//

#import "MDPost.h"
#import "MDPostReplyment.h"

@interface MDPostAt : MDPost
@property (assign, nonatomic) BOOL mentionedInPost;
@property (strong, nonatomic) NSArray *replyments;
@end
