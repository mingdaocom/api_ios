//
//  NSURLRequest+MDURLRequestGenerator.m
//  MingdaoV2
//
//  Created by Wee Tom on 16/1/22.
//  Copyright © 2016年 Mingdao. All rights reserved.
//

#import "NSURLRequest+MDURLRequestGenerator.h"

@implementation NSURLRequest (MDURLRequestGenerator)
+ (NSURLRequest *)postWithHost:(NSString *)host api:(NSString *)api parameters:(NSArray *)parameters
{
    NSMutableString *urlString = [[NSMutableString alloc] init];
    [urlString appendString:host];
    [urlString appendString:api];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [req setHTTPMethod:@"POST"];
    
    NSString *boundary = @"__MINGDAO__";
    NSString *boundaryPrefix = @"--";
    
    NSMutableData *postBody = [NSMutableData data];
    
    for (NSDictionary *dic in parameters) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        id object = dic[@"object"];
        NSString *key = dic[@"key"];
        NSString *fileName = dic[@"fileName"];
        
        if ([object isKindOfClass:[NSString class]]) {
            NSString *text = object;
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", text] dataUsingEncoding:NSUTF8StringEncoding]];
        } else if ([object isKindOfClass:[NSNumber class]]) {
            NSString *text = [object stringValue];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", text] dataUsingEncoding:NSUTF8StringEncoding]];
        } else if ([object isKindOfClass:[UIImage class]]) {
            UIImage *image = object;
            
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\";\r\n\r\n", key, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [postBody appendData:imageData];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        } else if ([object isKindOfClass:[NSData class]]) {
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\";\r\n\r\n", key, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:object];
            [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundaryPrefix] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@", boundary];
    [req setValue:contentType forHTTPHeaderField:@"Content-type"];
    [req setHTTPBody:postBody];
    return req;
}

+ (NSURLRequest *)getWithHost:(NSString *)host api:(NSString *)api parameters:(NSArray *)parameters
{
    NSMutableString *urlString = [[NSMutableString alloc] init];
    [urlString appendString:host];
    [urlString appendString:api];
    [urlString appendString:@"?"];
    for (int i = 0; i < parameters.count; i++) {
        NSDictionary *paraDic = parameters[i];
        NSString *key = paraDic[@"key"];
        NSString *object = paraDic[@"object"];
        if (![object isKindOfClass:[NSString class]]) {
            //            NSLog(@"error paramters");
            continue;
        }
        [urlString appendFormat:@"%@=%@", key, object];
        [urlString appendString:@"&"];
    }
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    return req;
}
@end
