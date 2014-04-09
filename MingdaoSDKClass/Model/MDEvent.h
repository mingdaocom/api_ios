//
//  Event.h
//  Mingdao
//
//  Created by Wee Tom on 13-5-3.
//
//

#import <Foundation/Foundation.h>
#import "MDUser.h"

@interface MDEventEmail : NSObject
@property (strong, nonatomic) NSString *memail;
@property (assign, nonatomic) int status;
- (MDEventEmail *)initWithDictionary:(NSDictionary *)aDic;
@end

@interface MDEvent : NSObject
@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) NSString *objectName;
@property (strong, nonatomic) MDUser *creator;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *startDateString;
@property (strong, nonatomic) NSString *endDateString;


@property (strong, nonatomic) NSString *des;
@property (assign, nonatomic) BOOL isAllday;
@property (assign, nonatomic) BOOL isPrivate;
@property (strong, nonatomic) NSArray *members;
@property (strong, nonatomic) NSArray *eventMails;

@property (assign, nonatomic) BOOL isRecur;
@property (assign, nonatomic) int frequency, interval, recurCount;
@property (strong, nonatomic) NSString *untilDateString, *weekDay;

@property (readonly ,nonatomic) BOOL isInOneDay;
@property (readonly, nonatomic) NSArray *memberIDs;
@property (readonly, nonatomic) NSArray *memberEmails;
@property (readonly, nonatomic) NSDate *startDate;
@property (readonly, nonatomic) NSDate *endDate;
@property (readonly, nonatomic) NSDateComponents *startDateComponents, *endDateComponents;
@property (readonly, nonatomic) NSArray *accetpedMembers, *rejectedMembers, *penddingMembers;
@property (readonly, nonatomic) NSArray *accetpedEmails, *rejectedEmails, *penddingEmails;
@property (readonly, nonatomic) NSString *repeatDetail;
@property (readonly, nonatomic) NSArray *selectedWeekdays;

- (MDEvent *)initWithDictionary:(NSDictionary *)aDic;
- (NSString *)escapedDuration;
@end
