//
//  ViewController.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "ViewController.h"
#import "MDAPIManager.h"
#import "UIDevice+IdentifierAddition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)loginBtnPressed:(id)sender {
    [MDAPIManager setAppKey:@"935527504"];
    [MDAPIManager setAppSecret:[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]];
#warning setAppkey and setAppSecet before use
    /*
     @must
     [MDAPIManager setAppKey:@""];
     [MDAPIManager setAppSecret:@""];
     
     @optional, default http://api.mingdao.com/
     [MDAPIManager setServerAddress:@""];
     */
    MDURLConnection *c =  [[MDAPIManager sharedManager] loginWithUsername:self.usernameField.text
                                           password:self.passwordField.text
                                     projectHandler:^(NSArray *projects, NSError *error){
                                         NSLog(@"%d Projects", projects.count);
                                     }
                                            handler:^(BOOL succeed, NSError *error){
                                                if (succeed) {
                                                    NSLog(@"login succeeded");
                                                } else {
                                                    NSLog(@"%@", error.userInfo);
                                                    NSLog(@"%@", [error.userInfo objectForKey:@"error"]);
                                                }
                                                
                                                /*[[[MDAPIManager sharedManager] loadAllVotessWithPageIndex:0 pagesize:0 handler:^(NSArray *votes, NSError *error){
                                                    for (MDPost *p in votes) {
                                                        NSLog(@"%@", p.text);
                                                    }
                                                }] start];*/
                                                /*[[[MDAPIManager sharedManager] createImagePostWithText:@"API TEST" image:[UIImage imageNamed:@"Default-568h@2x.png"] groupIDs:nil shareType:3 handler:^(NSString *pID, NSError *error){
                                                    NSLog(@"%@", pID);
                                                    [[[MDAPIManager sharedManager] createRepostWithText:@"repost" postID:pID groupIDs:nil shareType:3 handler:^(NSString *rID, NSError *error){
                                                        NSLog(@"%@", rID);
                                                    }] start];
                                                }] start];*/
                                                /*[[[MDAPIManager sharedManager] createTaskWithTaskName:@"APITeST" description:nil endDateString:@"2013-6-7" chargerID:nil memberIDs:nil projectID:nil handler:^(NSString *tID, NSError *error){
                                                    NSLog(@"%@", tID);
                                                    [[[MDAPIManager sharedManager] createTaskReplymentOnTaskWithTaskID:tID message:@"test" replyToReplymentWithRID:nil image:[UIImage imageNamed:@"Default-568h@2x.png"] handler:^(NSString *trID, NSError *error){
                                                        NSLog(@"%@", trID);
                                                    }] start];
                                                }] start];*/
                                                /*[[[MDAPIManager sharedManager] loadCurrentUserJoinedTasksWithKeywords:nil allOrUnfinished:YES handler:^(NSArray *tasks, NSError *error){
                                                    for (MDTask *t in tasks) {
                                                        NSLog(@"%@", t.objectName);
                                                        [[[MDAPIManager sharedManager] loadTaskWithTaskID:t.objectID handler:^(MDTask *t, NSError *error){
                                                            for (MDUser *u in t.members) {
                                                                NSLog(@"%@", u.objectName);
                                                                [[[MDAPIManager sharedManager] loadTaskReplymentsWithTaskID:t.objectID maxID:nil pageSize:20 handler:^(NSArray *rs, NSError *error){
                                                                    for (MDTaskReplyment *r in rs) {
                                                                        NSLog(@"%@", r.text);
                                                                    }
                                                                }] start];
                                                            }
                                                        }] start];
                                                        break;
                                                    }
                                                }] start];*/
                                            }];
    // use start when you are ready to request, it will not start automatically
    [c start];
    // use cancel if you want to stop
    //[c cancel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
