//
//  NSString+QNImageAPI.m
//  MingdaoV2
//
//  Created by Wee Tom on 16/4/6.
//  Copyright © 2016年 Mingdao. All rights reserved.
//

#import "NSString+QNImageAPI.h"

@implementation NSString (QNImageAPI)
- (NSString *)generateQNImageURLStringWithMode:(QNImageAPIMode)mode size:(CGSize)size format:(NSString *)format interlace:(BOOL)interlace quality:(QNImageAPIQuality)quality ignoreError:(BOOL)ignoreError
{
    static CGFloat screenScale = 1.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            screenScale = [[UIScreen mainScreen] scale];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                screenScale = [[UIScreen mainScreen] scale];
            });
        }
    });
    
    NSString *string = [self removeExistedAPIString];
    NSMutableString *handledString = [string mutableCopy];
    [handledString appendFormat:@"?imageView2/%d", (int)mode];
    if (size.width > 0) {
        CGFloat width = size.width;
        for (int i = 1; i < 5; i++) {
            if (width < i*100) {
                width = i*100;
                break;
            }
        }
        
        [handledString appendFormat:@"/w/%.0f", width*screenScale];
    }
    if (size.height > 0) {
        CGFloat height = size.height;
        for (int i = 1; i < 5; i++) {
            if (height < i*100) {
                height = i*100;
                break;
            }
        }
        
        [handledString appendFormat:@"/h/%.0f", height*screenScale];
    }
    if (format) {
        [handledString appendFormat:@"/format/%@", format];
    }
    [handledString appendFormat:@"/interlace/%d", interlace?1:0];
    [handledString appendFormat:@"/q/%d", (int)quality];
    [handledString appendFormat:@"/ignore-error/%d", ignoreError?1:0];
    return handledString;
}

- (NSURL *)generateQNImageURLWithMode:(QNImageAPIMode)mode size:(CGSize)size format:(NSString *)format interlace:(BOOL)interlace quality:(QNImageAPIQuality)quality ignoreError:(BOOL)ignoreError
{
    return [NSURL URLWithString:[self generateQNImageURLStringWithMode:mode size:size format:format interlace:interlace quality:quality ignoreError:ignoreError]];
}

- (BOOL)isQNImageURLString
{
    NSRange range = [self rangeOfString:@".qbox.me"];
    if (range.location != NSNotFound && NSMaxRange(range) <= self.length) {
        return YES;
    }
    return NO;
}

- (NSString *)removeExistedAPIString
{
    if (![self isQNImageURLString]) {
        return self;
    }
    
    NSRange range = [self rangeOfString:@"?imageView"];
    if (range.location != NSNotFound && NSMaxRange(range) <= self.length) {
        return [self substringToIndex:range.location];
    } else {
        return self;
    }
}
@end
