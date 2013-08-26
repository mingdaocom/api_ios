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
@property (assign, nonatomic) NSInteger status;
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

@property (readonly ,nonatomic) BOOL isInOneDay;
@property (readonly, nonatomic) NSArray *memberIDs;
@property (readonly, nonatomic) NSArray *memberEmails;
@property (readonly, nonatomic) NSDate *startDate;
@property (readonly, nonatomic) NSDate *endDate;
@property (readonly, nonatomic) NSDateComponents *startDateComponents, *endDateComponents;
@property (readonly, nonatomic) NSArray *accetpedMembers, *rejectedMembers, *penddingMembers;
@property (readonly, nonatomic) NSArray *accetpedEmails, *rejectedEmails, *penddingEmails;

@property (assign, nonatomic) BOOL isRecur;
@property (assign, nonatomic) NSInteger frequency, interval, weekDay, recurCount;
@property (strong, nonatomic) NSString *untilDate;

- (MDEvent *)initWithDictionary:(NSDictionary *)aDic;
- (NSString *)escapedDuration;
@end
