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
