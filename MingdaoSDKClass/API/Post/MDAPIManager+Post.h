//
//  MDAPIManager+Post.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Post)
#pragma mark - 动态接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 按需获取动态更新列表
 @parmas:
 keywords - 关键词
 userID - 用户编号
 groupID - 群组编号
 sinceID - 若指定此参数，则只返回ID比since_id大的动态更新（即比since_id发表时间晚的动态更新）为MDPost.autoID
 maxID - 若指定此参数，则只返回ID比max_id小的动态更新（即比max_id发表时间早的动态更新) 为MDPost.autoID
 size - 指定要返回的记录条数
 handler - 包含多个MDPost的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadPostsWithTagName:(nonnull NSString *)tagName
                                          keywords:(nullable NSString *)keywords
                                             maxID:(nullable NSString *)maxID
                                          pageSize:(nullable NSNumber *)size
                                           handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadAllPostsWithKeywords:(nullable NSString *)keywords
                                              postType:(MDPostType)type
                                               sinceID:(nullable NSString *)sinceID
                                                 maxID:(nullable NSString *)maxID
                                              pagesize:(nullable NSNumber *)size
                                               handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadFavouritedPostsWithKeywords:(nullable NSString *)keywords
                                                     postType:(MDPostType)type
                                                      sinceID:(nullable NSString *)sinceID
                                                        maxID:(nullable NSString *)maxID
                                                     pagesize:(nullable NSNumber *)size
                                                      handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadReplyMePostsWithKeywords:(nullable NSString *)keywords
                                                     maxID:(nullable NSString *)maxID
                                                  pagesize:(nullable NSNumber *)size
                                                   handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadMyReplyWithKeywords:(nullable NSString *)keywords
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadAtMePostsWithKeywords:(nullable NSString *)keywords
                                               postType:(MDPostType)type
                                              pageindex:(nullable NSNumber *)pageindex
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadMyPostsWithKeywords:(nullable NSString *)keywords
                                             postType:(MDPostType)type
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadUserPostsWithUserID:(nonnull NSString *)userID
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadGroupPostsWithGroupID:(nonnull NSString *)groupID
                                               Keywords:(nullable NSString *)keywords
                                                  maxID:(nullable NSString *)maxID
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadDocumentPostsWithGroupID:(nullable NSString *)groupID
                                                  Keywords:(nullable NSString *)keywords
                                                filterType:(nullable NSNumber *)filterType
                                                   sinceID:(nullable NSString *)sinceID
                                                     maxID:(nullable NSString *)maxID
                                                  pagesize:(nullable NSNumber *)size
                                                   handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadImagePostsWithGroupID:(nullable NSString *)groupID
                                               Keywords:(nullable NSString *)keywords
                                             filterType:(nullable NSNumber *)filterType
                                                sinceID:(nullable NSString *)sinceID
                                                  maxID:(nullable NSString *)maxID
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadFAQPostsWithGroupID:(nullable NSString *)groupID
                                             Keywords:(nullable NSString *)keywords
                                           filterType:(nullable NSNumber *)filterType
                                              sinceID:(nullable NSString *)sinceID
                                                maxID:(nullable NSString *)maxID
                                             pagesize:(nullable NSNumber *)size
                                              handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadVideoPostsWithGroupID:(nullable NSString *)groupID
                                               Keywords:(nullable NSString *)keywords
                                             filterType:(nullable NSNumber *)filterType
                                                sinceID:(nullable NSString *)sinceID
                                                  maxID:(nullable NSString *)maxID
                                               pagesize:(nullable NSNumber *)size
                                                handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadToppedPostsWithHandler:(nonnull MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据动态更新编号获取单条动态更新内容
 @parmas:
 pID - 动态编号
 handler - 处理MDpost
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadPostWithPostID:(nonnull NSString *)pID handler:(nonnull MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据动态更新编号获取某条动态更新的回复列表信息
 @parmas:
 pID - 动态编号
 handler - 处理包含多个MDPostReplyment的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)loadPostReplymentsWithPostID:(nonnull NSString *)pID handler:(nonnull MDAPINSArrayHandler)handler;
- (nullable MDURLConnection *)loadFAQPostBestAnsewerCommentWithPostID:(nonnull NSString *)pID handler:(nonnull MDAPIObjectHandler)handler;


/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 按需求发布一条动态更新
 @parmas:
 text - 文字消息
 groupIDs - 接受对象编号数组
 shareType - int -1表示系统分享；2表示群内分享；3表示分享给自己；其他表示分享给关注的人
 handler - 返回创建后的编号
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (nullable MDURLConnection *)createTextPostWithText:(nonnull NSString *)text
                                            groupIDs:(nullable NSArray *)groupIDs
                                           shareType:(nullable NSNumber *)shareType
                                             handler:(nonnull MDAPINSStringHandler)handler;
- (nullable MDURLConnection *)createURLPostWithText:(nullable NSString *)text
                                           urlTitle:(nullable NSString *)title
                                            urlLink:(nullable NSString *)link
                                           groupIDs:(nullable NSArray *)groupIDs
                                          shareType:(nullable NSNumber *)shareType
                                            handler:(nonnull MDAPINSStringHandler)handler;
- (nullable MDURLConnection *)createFAQPostWithText:(nullable NSString *)text
                                           groupIDs:(nullable NSArray *)groupIDs
                                          shareType:(nullable NSNumber *)shareType
                                            handler:(nonnull MDAPINSStringHandler)handler;
- (nullable MDURLConnection *)createImagePostWithText:(nullable NSString *)text
                                               images:(nullable NSArray *)images
                                             groupIDs:(nullable NSArray *)groupIDs
                                            shareType:(int)shareType
                                             toCenter:(BOOL)toCenter
                                              handler:(nonnull MDAPINSStringHandler)handler;
- (MDURLConnection *)createFilePostWithText:(NSString *)text
                                   fileName:(NSString *)fileName
                                       file:(NSData *)fileData
                                   groupIDs:(NSArray *)groupIDs
                                  shareType:(int)shareType
                                   toCenter:(BOOL)toCenter
                                    handler:(MDAPINSStringHandler)handler;
- (MDURLConnection *)createRepostWithText:(NSString *)text
                                   images:(NSArray *)images
                                   postID:(NSString *)postID
                                 groupIDs:(NSArray *)groupIDs
                                shareType:(int)shareType
                    commentToOriginalPost:(BOOL)yesOrNo
                                  handler:(MDAPINSStringHandler)handler;


/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据动态更新编号删除一条动态更新
 @parmas:
 pID - 动态编号
 handler - 处理删除结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)deletePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 增加一条动态更新的回复
 @parmas:
 pID - 回复的动态更新编号
 rID - 回复编号（可以对别人的回复进行回复）[可选]
 msg - 回复的消息内容
 handler - 返回创建成功后的编号
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)createPostReplymentOnPostWithPostID:(NSString *)pID
                         replyToReplymentWithReplymentID:(NSString *)rID
                                                 message:(NSString *)msg
                                                  images:(NSArray *)images
                                              isReshared:(BOOL)yesOrNo
                                                groupIDs:(NSArray *)groupIDs
                                               shareType:(int)shareType
                                                 handler:(MDAPINSStringHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据回复编号删除一条回复
 @parmas:
 pID - 动态编号 必须
 rID - 回复编号 必须（必须是当前登录用户自己创建的回复）
 handler - 处理删除结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)deletePostReplymentWithPostID:(NSString *)pID
                                       replymentID:(NSString *)rID
                                           handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 增加/删除当前登录用户的一条动态更新收藏
 @parmas:
 pID - 动态编号 必须
 handler - 处理收藏结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)favouritePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)unFavouritePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 增加/删除当前登录用户喜欢的一条动态更新
 @parmas:
 pID - 动态编号 必须
 handler - 处理收藏结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)likePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)unLikePostWithPostID:(NSString *)pID handler:(MDAPIBoolHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前企业动态更新标签信息
 @parmas:
 keywords - 关键词模糊搜索
 pageindex - 指定当前的页码
 pagesize - 默认值20，最大值100 指定要返回的记录条数
 handler - 处理包含多个MDTag的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadAllTagsWithKeywords:(NSString *)keywords
                                    pagesize:(int)size
                                        page:(int)page
                                     handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 增加/删除一条动态更新的标签
 @parmas:
 pID - 动态编号 必须
 tagName - 标签名称
 handler - 处理收藏结果
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)addTagToPostWithPostID:(NSString *)pID
                                    tagName:(NSString *)tagName
                                    handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)deleteTagFromPostWithPostID:(NSString *)pID
                                         tagName:(NSString *)tagName
                                         handler:(MDAPIBoolHandler)handler;

@end
