//
//  TBSDate.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-4-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "TBSDate.h"

@interface TBSDate ()

@end

@implementation TBSDate

+ (NSString *)getWeedDayFromDate:(NSDate *)date
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit
                                                                              fromDate:date];
    
    NSInteger weekday = [componets weekday];
    
    switch (weekday)
    {
        case 1:
            return @"Sunday";
            break;
            
        case 2:
            return @"Monday";
            break;
            
        case 3:
            return @"Tuesday";
            break;
            
        case 4:
            return @"Wednesday";
            break;
            
        case 5:
            return @"Thursday";
            break;
            
        case 6:
            return @"Friday";
            break;
            
        case 7:
            return @"Saturday";
            break;
            
        default:
            return @"Error";
            break;
    }
    
    
}

+ (NSInteger)getWeedDayValueFromDate:(NSDate *)date
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit
                                                                              fromDate:date];
    
    NSInteger weekday = [componets weekday];
    return weekday;
}

+ (NSInteger)getMonthValueFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    NSInteger month = [component month];
    
    return month;
}

+ (NSInteger)getYearValueFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    NSInteger year = [component year];
    
    return year;
}

+ (NSString *)getMonthFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *component = [calendar components:unitFlags fromDate:date];
    NSInteger month = [component month];
    NSLog(@"month=%ld", month);
    
    switch (month)
    {
        case 1:
            return @"January";
            break;
            
        case 2:
            return @"Feburary";
            break;
            
        case 3:
            return @"March";
            break;
            
        case 4:
            return @"April";
            break;
            
        case 5:
            return @"May";
            break;
            
        case 6:
            return @"June";
            break;
            
        case 7:
            return @"July";
            break;
            
        case 8:
            return @"August";
            break;
            
        case 9:
            return @"September";
            break;
            
        case 10:
            return @"October";
            break;
            
        case 11:
            return @"November";
            break;
            
        case 12:
            return @"December";
            break;
            
        default:
            return @"Error";
            break;
    }
    
    
}

+ (NSInteger)getNumberOfDaysInMonth:(NSInteger)month
                               Year:(NSInteger)year
{
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    {
        return 31;
    }else if(month == 4 || month == 6 || month == 9 || month == 11)
    {
        return 30;
    }else if(month == 2 && [self isLeapYear:year])
    {
        return 29;
    }else if(month == 2 && ![self isLeapYear:year])
    {
        return 28;
    }else
    {
        return -1;
    }
}

+ (BOOL)isLeapYear:(NSInteger)year
{
    if ((year % 4  == 0 && year % 100 != 0) || (year % 400 == 0))
        return YES;
    else
        return NO;
    
}

+ (NSString*)previousMonthOfYear:(NSInteger)year
                       Month:(NSInteger)month
{
    month--;
    if(month == 0)
    {
        month = 12;
        year--;
    }
    
    return [NSString stringWithFormat:@"%02ld-%02ld", year, month];
}

+ (NSString*)nextMonthOfYear:(NSInteger)year
                           Month:(NSInteger)month
{
    month++;
    if(month == 13)
    {
        month = 1;
        year++;
    }
    
    return [NSString stringWithFormat:@"%02ld-%02ld", year, month];
}

+ (NSString*)getMonthStringFromMonth:(NSInteger)month
{
    switch (month)
    {
        case 1:
            return @"January";
            break;
            
        case 2:
            return @"Feburary";
            break;
            
        case 3:
            return @"March";
            break;
            
        case 4:
            return @"April";
            break;
            
        case 5:
            return @"May";
            break;
            
        case 6:
            return @"June";
            break;
            
        case 7:
            return @"July";
            break;
            
        case 8:
            return @"August";
            break;
            
        case 9:
            return @"September";
            break;
            
        case 10:
            return @"October";
            break;
            
        case 11:
            return @"November";
            break;
            
        case 12:
            return @"December";
            break;
            
        default:
            return @"Error";
            break;
    }

}











@end
