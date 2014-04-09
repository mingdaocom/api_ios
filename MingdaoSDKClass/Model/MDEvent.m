//
//  Event.m
//  Mingdao
//
//  Created by Wee Tom on 13-5-3.
//
//

#import "MDEvent.h"

@implementation MDEventEmail
- (MDEventEmail *)initWithDictionary:(NSDictionary *)aDic
{
    if (!aDic || ![aDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.memail = [aDic objectForKey:@"memail"];
        self.status = [[aDic objectForKey:@"status"] intValue];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MDEventEmail class]]) {
        MDEventEmail *mail = (MDEventEmail *)object;
        if ([mail.memail isEqualToString:self.memail]) {
            return YES;
        }
    }
    return NO;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDEventEmail *copyObject = object;
    copyObject.memail = [self.memail copy];
    copyObject.status = self.status;
    return copyObject;
}
@end

@interface MDEvent ()
@end

@implementation MDEvent
- (MDEvent *)initWithDictionary:(NSDictionary *)aDic
{
    if (!aDic || ![aDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.objectID = [aDic objectForKey:@"id"];
        self.objectName = [aDic objectForKey:@"title"];
        self.startDateString = [aDic objectForKey:@"start_time"];
        self.endDateString = [aDic objectForKey:@"end_time"];
        self.isAllday = [[aDic objectForKey:@"allday"] boolValue];
        self.des = [aDic objectForKey:@"des"];
        self.address = [aDic objectForKey:@"address"];
        self.isPrivate = ![[aDic objectForKey:@"private"] boolValue];
        if (![aDic objectForKey:@"private"]) {
            self.isPrivate = 0;
        }
        
        self.isRecur = [[aDic objectForKey:@"is_recur"] boolValue];
        if (self.isRecur) {
            NSDictionary *dic = [aDic objectForKey:@"recur"];
            
            self.frequency = [[dic objectForKey:@"frequency"] intValue];
            self.interval = [[dic objectForKey:@"interval"] intValue];
            
//          NSArray *weekdayNames = [[[NSDateFormatter alloc] init] shortWeekdaySymbols];
//          weekdayNames starts on Sunday witch from server goes with @"7"

            self.weekDay = [[dic objectForKey:@"week_day"] stringByReplacingOccurrencesOfString:@"7" withString:@"0"];
            
            self.recurCount = [[dic objectForKey:@"recur_count"] intValue];
            self.untilDateString = [dic objectForKey:@"until_date"];
        }

        
        NSMutableArray *memebers = [NSMutableArray array];
        NSDictionary *joinedDic = [aDic objectForKey:@"joined"];
        NSArray *users = [joinedDic objectForKey:@"users"];
        for (NSDictionary *userDic in users) {
            if ([userDic isKindOfClass:[NSDictionary class]]) {
                MDUser *aUser = [[MDUser alloc] initWithDictionary:userDic];
                [memebers addObject:aUser];
            }
        }
        
        NSMutableArray *emailMembers = [NSMutableArray array];
        NSArray *eUsers = [joinedDic objectForKey:@"emails"];
        if ([eUsers isKindOfClass:[NSArray class]]) {
            for (NSDictionary *userDic in eUsers) {
                if ([userDic isKindOfClass:[NSDictionary class]]) {
                    MDEventEmail *aUser = [[MDEventEmail alloc] initWithDictionary:userDic];
                    [emailMembers addObject:aUser];
                }
            }
        }

        self.members = memebers;
        self.eventMails = emailMembers;
        
        NSDictionary *creatorDic = [aDic objectForKey:@"user"];
        if ([creatorDic isKindOfClass:[NSDictionary class]]) {
            self.creator = [[MDUser alloc] initWithDictionary:creatorDic];
        } else {
            if (self.members.count > 0) {
                self.creator = [self.members objectAtIndex:0];
            }
        }
    }
    return self;
}

- (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [formatter dateFromString:dateString];
    if (!date) {
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        date = [formatter dateFromString:dateString];
    }
    return date;
}

- (void)setObjectID:(NSString *)objectID
{
    if (!objectID) {
        return;
    }
    
    _objectID = [objectID uppercaseString];
}

- (void)setDes:(NSString *)c_des
{
    if (!c_des) {
        _des = @"";
        return;
    }
    
    _des = c_des;
}

- (void)setAddress:(NSString *)c_address
{
    if (!c_address) {
        _address = @"";
        return;
    }
    
    _address = c_address;
}

- (void)setObjectName:(NSString *)c_name
{
    if (!c_name) {
        _objectName = @"";
        return;
    }
    
    _objectName = c_name;
}

- (BOOL)isInOneDay
{
    if (self.startDateComponents.year == self.endDateComponents.year
        && self.startDateComponents.month == self.endDateComponents.month
        && self.startDateComponents.day == self.endDateComponents.day) {
        return YES;
    }
    return NO;
}

- (NSDate *)startDate
{
    return [self dateFromString:self.startDateString];
}

- (NSDate *)endDate
{
    return [self dateFromString:self.endDateString];
}

- (NSDateComponents *)startDateComponents
{
    return [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self.startDate];
}

- (NSDateComponents *)endDateComponents
{
    return [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self.endDate];
}

- (NSArray *)memberIDs
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.members.count];
    if (ma) {
        for (MDUser *u in self.members) {
            [ma addObject:u.objectID];
        }
    }
    return ma;
}

- (NSArray *)memberEmails
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.members.count];
    if (ma) {
        for (MDEventEmail *u in self.eventMails) {
            [ma addObject:u.memail];
        }
    }
    return ma;
}

- (NSArray *)accetpedMembers
{
    return [self sortUserWithStatus:1];
}

- (NSArray *)rejectedMembers
{
    return [self sortUserWithStatus:2];
}

- (NSArray *)penddingMembers
{
    return [self sortUserWithStatus:0];
}

- (NSArray *)sortUserWithStatus:(int)status
{
    NSMutableArray *array = [NSMutableArray array];
    for (MDUser *aUser in self.members) {
        if (aUser.status == status) {
            [array addObject:aUser];
        }
    }
    return array;
}

- (NSArray *)accetpedEmails
{
    return [self sortEmailWithStatus:1];
}

- (NSArray *)rejectedEmails
{
    return [self sortEmailWithStatus:2];
}

- (NSArray *)penddingEmails
{
    return [self sortEmailWithStatus:0];
}

- (NSArray *)sortEmailWithStatus:(int)status
{
    NSMutableArray *array = [NSMutableArray array];
    for (MDEventEmail *aUser in self.eventMails) {
        if (aUser.status == status) {
            [array addObject:aUser];
        }
    }
    return array;
}

- (NSString *)escapedDuration
{
    NSDate *startDate = self.startDate;
    NSDate *endDate = self.endDate;
    
    if (!startDate || !endDate) {
        return @"";
    }
    
    NSDateComponents *sComp = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:startDate];
    NSDateComponents *eComp = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:endDate];
    
    NSMutableString *string = [NSMutableString string];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    if (!self.isAllday) {
        [fm setDateFormat:@"yyyy-MM-dd EEEE HH:mm"];
        [string appendString:[fm stringFromDate:startDate]];
        if ((sComp.year != eComp.year) || (sComp.day != eComp.day)) {
        } else if (sComp.month != eComp.month) {
            [fm setDateFormat:@"MM-dd EEEE HH:mm"];
        } else {
            [fm setDateFormat:@"HH:mm"];
        }
        [string appendFormat:@" - %@", [fm stringFromDate:endDate]];
    } else {
        [fm setDateFormat:@"yyyy-MM-dd EEEE"];
        [string appendString:[fm stringFromDate:startDate]];
        if (sComp.year != eComp.year) {
            [string appendFormat:@" - %@", [fm stringFromDate:endDate]];
        } else if ((sComp.year != eComp.year) || (sComp.day != eComp.day)) {
            [fm setDateFormat:@"MM-dd EEEE"];
            [string appendFormat:@" - %@", [fm stringFromDate:endDate]];
        }
        [string appendString:@" 全天"];
    }
    return string;
}

- (NSString *)repeatDetail
{
    NSMutableString *string = [NSMutableString string];
    
    switch (self.frequency) {
        case 1: {
            // daily
            if (self.interval == 1) {
                [string appendString:@"每天"];
            } else {
                [string appendFormat:@"每%ld天", (long)self.interval];
            }
            if (self.untilDateString.length > 0) {
                [string appendFormat:@" 截止到%@", self.untilDateString];
            } else if (self.recurCount > 0) {
                [string appendFormat:@" 共%ld次", (long)self.recurCount];
            }
            break;
        }
        case 2:{
            // by week
            NSArray *weekdayNames = [[[NSDateFormatter alloc] init] shortWeekdaySymbols];
            
            NSArray *days = [self.weekDay componentsSeparatedByString:@","];
            
            if (self.interval == 1) {
                [string appendString:@"每周"];
            } else {
                [string appendFormat:@"每%ld周", (long)self.interval];
            }
            
            for (int i = 0; i < days.count; i++) {
                [string appendFormat:@" %@", weekdayNames[[days[i] intValue]]];
            }
            
            if (self.untilDateString.length > 0) {
                [string appendFormat:@" 截止到 %@", self.untilDateString];
            } else if (self.recurCount > 0) {
                [string appendFormat:@" 共%ld次", (long)self.recurCount];
            }
            break;
        }
        case 3:{
            // by month
            if (self.interval == 1) {
                [string appendString:@"每月"];
            } else {
                [string appendFormat:@"每%ld个月", (long)self.interval];
            }
            if (self.untilDateString.length > 0) {
                [string appendFormat:@" 截止到%@", self.untilDateString];
            } else if (self.recurCount > 0) {
                [string appendFormat:@" 共%ld次", (long)self.recurCount];
            }
            break;
        }
        case 4:{
            // by year
            if (self.interval == 1) {
                [string appendString:@"每年"];
            } else {
                [string appendFormat:@"每%ld年", (long)self.interval];
            }
            if (self.untilDateString.length > 0) {
                [string appendFormat:@" 截止到%@", self.untilDateString];
            } else if (self.recurCount > 0) {
                [string appendFormat:@" 共%ld次", (long)self.recurCount];
            }
            break;
        }
        default:
            break;
    }
    
    return string;
}

- (NSArray *)selectedWeekdays
{
    NSArray *weekdayNames = [[[NSDateFormatter alloc] init] shortWeekdaySymbols];
    NSMutableArray *array = [NSMutableArray array];
    NSArray *oArray = [self.weekDay componentsSeparatedByString:@","];
    for (NSString *s in oArray) {
        [array addObject:[weekdayNames objectAtIndex:[s intValue]]];
    }
    return array;
}

- (id)copy
{
    id object = [[[self class] alloc] init];
    MDEvent *copyObject = object;
    copyObject.objectID = [self.objectID copy];
    copyObject.objectName = [self.objectName copy];
    copyObject.creator = [self.creator copy];
    copyObject.address = [self.address copy];
    copyObject.startDateString = [self.startDateString copy];
    copyObject.endDateString = [self.endDateString copy];
    copyObject.des = [self.des copy];
    copyObject.isAllday = self.isAllday;
    copyObject.isPrivate = self.isPrivate;
    copyObject.members = [self.members copy];
    copyObject.eventMails = [self.eventMails copy];
    copyObject.isRecur = self.isRecur;
    copyObject.frequency = self.frequency;
    copyObject.interval = self.interval;
    copyObject.recurCount = self.recurCount;
    copyObject.untilDateString = [self.untilDateString copy];
    copyObject.weekDay = [self.weekDay copy];
    return copyObject;
}
@end
