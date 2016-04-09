//
//  NSString+QNImageAPI.h
//  MingdaoV2
//
//  Created by Wee Tom on 16/4/6.
//  Copyright © 2016年 Mingdao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    QNImageAPIModeLongEdgeShortEdgeNoBiggerThanSize = 0,
    QNImageAPIModeShrinkToSizeCutInTheMiddle = 1,
    QNImageAPIModeWidthHeightNoBiggerThanSize = 2,
    QNImageAPIModeShrinkToSizeNoCut = 3,
    QNImageAPIModeLongEdgeShortEdgeAlwaysBiggerThanSize = 4,
    QNImageAPIModeLongEdgeShortEdgeNoBiggerThanSizeCutInTheMiddle = 5
} QNImageAPIMode;

typedef enum : NSUInteger {
    QNImageAPIQualityDefault = 75,
    QNImageAPIQualityLow = 50,
    QNImageAPIQualityHigh = 90
} QNImageAPIQuality;

@interface NSString (QNImageAPI)
- (NSString *)generateQNImageURLStringWithMode:(QNImageAPIMode)mode size:(CGSize)size format:(NSString *)format interlace:(BOOL)interlace quality:(QNImageAPIQuality)quality ignoreError:(BOOL)ignoreError;
- (NSURL *)generateQNImageURLWithMode:(QNImageAPIMode)mode size:(CGSize)size format:(NSString *)format interlace:(BOOL)interlace quality:(QNImageAPIQuality)quality ignoreError:(BOOL)ignoreError;
- (BOOL)isQNImageURLString;
@end
