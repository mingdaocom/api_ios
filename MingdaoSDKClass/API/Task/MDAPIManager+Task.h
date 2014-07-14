//
//  MDAPIManager+Task.h
//  MingdaoV2
//
//  Created by WeeTom on 14-5-26.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "MDAPIManager.h"

@interface MDAPIManager (Task)
#pragma mark - 任务接口

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前登录用户参与/参与且已完成/托付/托付且已完成/负责/负责且已完成的任务列表
 @parmas:
 keywords - 任务中包含的关键词
 allOrUnfinished  - YES加载全部任务 NO加载未完成的任务
 size - 没次加载获取的任务书
 page - 任务所在页数
 handler - 包含多个MDTask的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadCurrentUserJoinedTasksWithKeywords:(NSString *)keywords allOrUnfinished:(BOOL)allOrUnFinished handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadCurrentUserJoinedFinishedTasksWithPageSize:(NSInteger)size
                                                               page:(NSInteger)page
                                                            handler:(MDAPINSArrayHandler)handler;

- (MDURLConnection *)loadCurrentUserAssignedTasksWithKeywords:(NSString *)keywords allOrUnfinished:(BOOL)allOrUnFinished handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadCurrentUserAssignedFinishedTasksWithPageSize:(NSInteger)size
                                                                 page:(NSInteger)page
                                                              handler:(MDAPINSArrayHandler)handler;

- (MDURLConnection *)loadCurrentUserChargedTasksWithKeywords:(NSString *)keywords allOrUnfinished:(BOOL)allOrUnFinished handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadCurrentUserChargedFinishedTasksWithPageSize:(NSInteger)size
                                                                page:(NSInteger)page
                                                             handler:(MDAPINSArrayHandler)handler;

- (MDURLConnection *)loadCurrentUserObservedTasksWithKeywords:(NSString *)keywords allOrUnfinished:(BOOL)allOrUnFinished handler:(MDAPINSArrayHandler)handler;
- (MDURLConnection *)loadCurrentUserObservedFinishedTasksWithPageSize:(NSInteger)size
                                                                 page:(NSInteger)page
                                                              handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 获取当前网络所有任务隶属的项目
 @parmas:
 keywords - 任务中包含的关键词
 handler - 包含多个MDProject的NSArray
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadProjectsWithKeywords:(NSString *)keywords handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据任务编号获取单条任务内容
 @parmas:
 tID - 任务编号
 handler - 处理MDTask
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadTaskWithTaskID:(NSString *)tID handler:(MDAPIObjectHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 根据任务编号获取单条任务的讨论列表信息
 @parmas:
 tID - 任务编号
 maxTID - 若指定此参数，则只返回ID比max_id小的动态更新（即比max_id发表时间早的动态更新）
 size - 指定要返回的记录条数 int默认值20，最大值100
 handler - 处理MDTask
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)loadTaskReplymentsWithTaskID:(NSString *)tID
                                         onlyFile:(BOOL)onlyFile
                                            maxID:(NSString *)maxTID
                                         pageSize:(NSInteger)size
                                          handler:(MDAPINSArrayHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 创建一个新的任务
 @parmas:
 name    - 任务名称 必须
 eDateString - 任务截止日期，yyyy-MM-dd形式 必须
 des - 任务描述
 chargerID - 指定的任务负责人
 memberIDs - 指定的任务成员 (多个成员用逗号隔开)
 handler - 创建成功返回任务编号
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)createTaskWithTaskName:(NSString *)name
                                description:(NSString *)des
                              endDateString:(NSString *)endDateString
                                  chargerID:(NSString *)chargerID
                                  memberIDs:(NSArray *)memberIDs
                                  projectID:(NSString *)projectID
                                   parentID:(NSString *)parentID
                                    handler:(MDAPINSStringHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 创建一个新的任务隶属的项目
 @parmas:
 name    - 项目名称 必须
 handler - 创建成功返回任务编号
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)createProjectWithName:(NSString *)name
                                   handler:(MDAPINSStringHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 增加一个任务的讨论
 @parmas:
 tID    -  回复的任务ID 必须
 rID    -  回复某条回复的ID 可选
 message - 回复内容 必须
 image   - 附带回复图片 可选
 handler - 创建成功返回回复编号
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)createTaskReplymentOnTaskWithTaskID:(NSString *)tID
                                                 message:(NSString *)message
                                 replyToReplymentWithRID:(NSString *)rID
                                                  images:(NSArray *)images
                                                 handler:(MDAPINSStringHandler)handler;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 完成/删除/编辑任务
 @parmas:
 tID    -  回复的任务ID 必须
 handler - 创建成功返回回复编号
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)finishTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)unfinishTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)deleteTaskWithTaskID:(NSString *)tID handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                                  title:(NSString *)title
                                handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                                    des:(NSString *)des
                                handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              chargerID:(NSString *)chargerID
                                handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                          endDateString:(NSString *)endDateString
                                handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              projectID:(NSString *)projectID
                                handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)addMemberToTaskWithTaskID:(NSString *)tID
                                      memberID:(NSString *)memberID
                                       handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)deleteMemberFromeTaskWithTaskID:(NSString *)tID
                                            memberID:(NSString *)memberID
                                             handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)applyTaskMemberWithTaskID:(NSString *)tID
                                       handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)agreeToTaskWithTaskID:(NSString *)tID
                                  memberID:(NSString *)memberID
                                   handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)refuseToTaskWithTaskID:(NSString *)tID
                                  memberID:(NSString *)memberID
                                   handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)saveTaskWitTaskID:(NSString *)tID
                             colorType:(int)colorType
                               handler:(MDAPIBoolHandler)handler;
- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                              lockState:(BOOL)lockedOrNot
                                handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                               parentID:(NSString *)parentID
                                handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)copyTaskWithTaskID:(NSString *)tID
                              chargerID:(NSString *)chargerID
                                  title:(NSString *)title
                                options:(NSArray *)options
                                handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)saveTaskWithTaskID:(NSString *)tID
                            noticeState:(BOOL)noticeState
                                handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)createTaskV2WithTaskName:(NSString *)title
                                 description:(NSString *)description
                               endDateString:(NSString *)endDateString
                                   chargerID:(NSString *)chargerID
                                   memberIDs:(NSArray *)memberIDs
                                   projectID:(NSString *)projectID
                                    parentID:(NSString *)parentID
                                   colorType:(int)colorType
                                     handler:(MDAPINSStringHandler)handler;

- (MDURLConnection *)loadFoldersWithKeywords:(NSString *)keywords
                                  filterType:(int)type
                                   colorType:(int)colorType
                                   orderType:(int)orderType
                           isShowEmptyFolder:(BOOL)isShowEmptyFolder
                       isShowCompletedFolder:(BOOL)isShowCompletedFolder
                                    pageSize:(int)pageSize
                                   pageIndex:(int)pageIndex
                                     handler:(void(^)(NSArray *folders, MDTaskFolder *noFolderTaskInfo, NSError *error))handler;

- (MDURLConnection *)loadTasksWithKeywords:(NSString *)keywords
                                  folderID:(NSString *)folderID
                                filterType:(int)filterType
                                 colorType:(int)colorType
                                  finished:(BOOL)finished
                               categortIDs:(NSString *)categortIDs
                                    userID:(NSString *)userID
                                 pageIndex:(int)pageIndex
                                  pageSize:(int)pageSize
                                   handler:(MDAPINSArrayHandler)handler;

- (MDURLConnection *)loadTaskDetailWithTaskID:(NSString *)taskID
                                       handler:(MDAPIObjectHandler)handler;

- (MDURLConnection *)loadSubTasksWithParentID:(NSString *)parentID
                                    pageIndex:(int)pageIndex
                                     pageSize:(int)pageSize
                                      handler:(MDAPINSArrayHandler)handler;

- (MDURLConnection *)loadCanBeRelatedTasksWithTaskID:(NSString *)taskID
                                              keywords:(NSString *)keywords
                                               handler:(MDAPINSArrayHandler)handler;

- (MDURLConnection *)loadAllTaskMessagesWithKeyWords:(NSString *)keywords
                                         messageType:(int)messageType
                                          isFavorite:(BOOL)isFavorite
                                            isUnread:(BOOL)isUnread
                                           pageIndex:(int)pageIndex
                                            pageSize:(int)pageSize
                                             handler:(MDAPINSArrayHandler)handler;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-
 @usage:
 完成/删除/编辑项目
 @parmas:
 tID    -  回复的任务ID 必须
 handler - 创建成功返回状态
 -*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*/
- (MDURLConnection *)validateFolderWithName:(NSString *)folderName
                                                handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)createFolderWithName:(NSString *)folderName
                             chargeUserID:(NSString *)userID
                                colorType:(int)colorType
                                 deadLine:(NSString *)deadLine
                                  handler:(MDAPINSStringHandler)handler;

- (MDURLConnection *)saveFolderWithFolderID:(NSString *)folderID
                                 folderName:(NSString *)folderName
                                 chargeUser:(NSString *)chargeUser
                                  colorType:(int)colorType
                                   deadLine:(NSString *)deadLine
                                    handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)saveFolderWithFolderID:(NSString *)folderID
                                  colorType:(int)colorType
                                    handler:(MDAPIBoolHandler)handler;

- (MDURLConnection *)deleteFolderWithFolderID:(NSString *)folderID
                                isDeleteTasks:(BOOL)isDeleteTasks
                                      handler:(MDAPIBoolHandler)handler;
@end
