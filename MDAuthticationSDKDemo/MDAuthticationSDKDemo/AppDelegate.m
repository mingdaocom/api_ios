//
//  AppDelegate.m
//  MDAuthticationSDKDemo
//
//  Created by Wee Tom on 14-1-15.
//  Copyright (c) 2014年 Mingdao. All rights reserved.
//

#import "AppDelegate.h"
#import "MDAuthenticator.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSDictionary *result = [MDAuthenticator mingdaoAppDidFinishAuthenticationWithURL:url];
    if (result) {
#ifdef DEBUG
        NSLog(@"%@", result);
#endif
        NSString *errorStirng= result[MDAuthErrorKey];
        if (errorStirng) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failed!" message:errorStirng delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
            [alertView show];
            return YES;
        }
        
        NSString *accessToken = result[MDAuthAccessTokenKey];
        //    NSString *refeshToken = result[MDAuthRefreshTokenKey];
        //    NSString *expireTime = result[MDAuthExpiresTimeKey];
        [MDAPIManager sharedManager].accessToken = accessToken;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Succeed!" message:[NSString stringWithFormat:@"token = %@", accessToken] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
        [alertView show];
    }
    return YES;
}
@end
