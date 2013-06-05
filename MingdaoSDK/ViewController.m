//
//  ViewController.m
//  MingdaoSDK
//
//  Created by Wee Tom on 13-6-3.
//  Copyright (c) 2013年 WeeTomProduct. All rights reserved.
//

#import "ViewController.h"
#import "MDAPIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)loginBtnPressed:(id)sender {
    [[[MDAPIManager sharedManager] loginWithUsername:@"weetom.wang@meihua.info"
                                           password:@"882825"
                                     projectHandler:^(NSArray *projects, NSError *error){
                                         NSLog(@"%d Projects", projects.count);
                                     }
                                            handler:^(BOOL succeed, NSError *error){
                                                NSLog(@"login succeeded");
                                                [[[MDAPIManager sharedManager] loadCurrentUserJoinedTasksWithKeywords:nil allOrUnfinished:YES handler:^(NSArray *tasks, NSError *error){
                                                    for (MDTask *t in tasks) {
                                                        NSLog(@"%@", t.objectName);
                                                        [[[MDAPIManager sharedManager] loadTaskWithTaskID:t.objectID handler:^(MDTask *t, NSError *error){
                                                            for (MDUser *u in t.members) {
                                                                NSLog(@"%@", u.objectName);
                                                            }
                                                        }] start];
                                                        break;
                                                    }
                                                }] start];
                                            }] start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
