//
//  CalendarViewController.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-4-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

//used to show info
@property (weak, nonatomic) IBOutlet UILabel *l_showDate;
@property (weak, nonatomic) IBOutlet UILabel *l_showWeekDay;
@property (weak, nonatomic) IBOutlet UILabel *l_showMonth;
@property (weak, nonatomic) IBOutlet UIView *v_calendarBody;
@property (weak, nonatomic) IBOutlet UIView *v_calendarHeader;
@property (weak, nonatomic) IBOutlet UIView *v_symbols;

//today date
@property (strong, nonatomic) NSString *todayDate;

//current month
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;

//date to pass to today view
@property (strong, nonatomic) NSString *selectedDate;

//date from database
@property (strong, nonatomic) NSArray *allContents;

@end

@implementation CalendarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    
}

- (void)viewWillAppear:(BOOL)animated
{

    [self setTodayDate];
    
    //get data from DB
    [self getAllContentsFromDB];
    
    //draw or re-draw
    [self showCalendar];
    
    //show symbols explanation
    [self showSymbols];
}

- (void)setTodayDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.todayDate = [formatter stringFromDate:[NSDate date]];
    
    //set UILable to show date
    self.l_showDate.text = [NSString stringWithFormat:@"%d", [[[self.todayDate componentsSeparatedByString:@"-"] objectAtIndex:2] intValue]];
//    self.l_showWeekDay.text = [TBSDate getWeedDayFromDate:[NSDate date]];
    self.l_showWeekDay.text = [[NSString alloc] initWithFormat:NSLocalizedString([TBSDate getWeedDayFromDate:[NSDate date]], @"Weekday")];
//    self.l_showMonth.text = [TBSDate getMonthFromDate:[NSDate date]];
    self.l_showMonth.text = [[NSString alloc] initWithFormat:NSLocalizedString([TBSDate getMonthFromDate:[NSDate date]], @"Month")];
    
    //set date value
    self.month = [TBSDate getMonthValueFromDate:[NSDate date]];
    self.year = [TBSDate getYearValueFromDate:[NSDate date]];
    
}

- (void)showCalendar
{
    //remove all subviews
    for(UIView *subview in self.v_calendarBody.subviews)
    {
        if([subview isKindOfClass:[CalendarDayView class]])
        {
            [subview removeFromSuperview];
        }
    }
    
    
    //draw header background
    UIImageView *iv_headerBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    iv_headerBg.image = [UIImage imageNamed:@"bg_calendarHeader"];
    [self.v_calendarHeader addSubview:iv_headerBg];
    [self.v_calendarHeader sendSubviewToBack:iv_headerBg];
    
    //draw seperators above and below calendar header
    UIImageView *septorAboveHeader = [[UIImageView alloc] initWithFrame:CGRectMake(-1, 0, 321, 3)];
    septorAboveHeader.image = [UIImage imageNamed:@"divider1"];
    [self.v_calendarHeader addSubview:septorAboveHeader];
    
    UIImageView *septorBelowHeader = [[UIImageView alloc] initWithFrame:CGRectMake(-1, 38, 321, 5)];
    septorBelowHeader.image = [UIImage imageNamed:@"divider1"];
    [self.v_calendarHeader addSubview:septorBelowHeader];
    
    //draw seperators above and below calendar body
    UIImageView *septorBelowBody = [[UIImageView alloc] initWithFrame:CGRectMake(-1, 248, 321, 5)];
    septorBelowBody.image = [UIImage imageNamed:@"divider1"];
    [self.v_calendarBody addSubview:septorBelowBody];
    
    //Calculate weekday for the first day of month
    NSString *firstDateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02d", (long)self.year, (long)self.month, 1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *firstDate = [formatter dateFromString:firstDateStr];
    
    NSInteger weekDayOfFirstDay = [TBSDate getWeedDayValueFromDate:firstDate];
    NSLog(@"weekDayOfFirstDay=%ld", weekDayOfFirstDay);

    
    //draw calendar
        //set Start column num
    NSInteger cur_column = weekDayOfFirstDay - 1;
    NSInteger cur_row = 0;
    
        //draw blankViews
    for(int i = 0; i < cur_column; i++)
    {
        CalendarDayView *blankView = [[CalendarDayView alloc] initWithBlankContent:CGRectMake(46 * i, 0, 46, 50)];
        [self.v_calendarBody addSubview:blankView];
    }
    
    NSInteger numberOfdays = [TBSDate getNumberOfDaysInMonth:self.month Year:self.year];
    NSLog(@"numberOfdays=%ld", numberOfdays);

    
    for (int i = 6; i > (6 - (35 - numberOfdays - cur_column)); i--)
    {
        CalendarDayView *blankView = [[CalendarDayView alloc] initWithBlankContent:CGRectMake(46 * i, 200, 46, 50)];
        [self.v_calendarBody addSubview:blankView];
    }
    
    
    for(int i = 1; i <= numberOfdays; i++)
    {
        NSString *dateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02d", (long)self.year, (long)self.month, i];
        
        if(![dateStr isEqual:self.todayDate])
        {
            CalendarDayView *dayView = [[CalendarDayView alloc] initWithFrame:CGRectMake(46 * cur_column, 50 * cur_row,
                                                                                     46, 50)
                                                                         Date:dateStr
                                                                   parentView:self
                                                                  AllContents:self.allContents];
            [self.v_calendarBody addSubview:dayView];
        }else
        {
            CalendarDayView *dayView = [[CalendarDayView alloc] initForTodayWithFrame:CGRectMake(46 * cur_column, 50 * cur_row,
                                                                                         46, 50)
                                                                                 Date:dateStr
                                                                           parentView:self
                                                                          AllContents:self.allContents];
            [self.v_calendarBody addSubview:dayView];
        }
        
        cur_row = cur_row + (cur_column+1) / 7;
        cur_column = (cur_column + 1) % 7;
        
        if(cur_row > 4)
        {
            cur_row = 0;
            cur_column = 0;
        }
    }

}

- (void)selectDate:(NSString*)date
{
    self.selectedDate = date;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"segue_monthToToday"])
    {
        TodayViewController *todayController = segue.destinationViewController;
        [todayController setValue:self.selectedDate forKey:@"date"];
    }
}


- (void)getAllContentsFromDB
{
    TBSDatabase *db = [[TBSDatabase alloc] init];
    self.allContents = [db queryAllContents];
}

- (void)showSymbols
{
    //remove all symbols at first
    NSArray *subviews = [self.v_symbols subviews];
    for(UIView *view in subviews)
    {
        [view removeFromSuperview];
    }
    
    
    NSMutableArray *positionsMutableAarray = [[NSMutableArray alloc] init];
    for(ContentOfDay *content in self.allContents)
    {
        if(![positionsMutableAarray containsObject:content.position])
        {
            [positionsMutableAarray addObject:content.position];
        }
    }
    

    
    int x = 40;
    int y = 20;
    for(NSString *position in positionsMutableAarray)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 15, 15)];
        NSString *imgName = [NSString stringWithFormat:@"icon_%@", position];
        icon.image = [UIImage imageNamed:imgName];
        [self.v_symbols addSubview:icon];
        
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(x+15, y, 65, 15)];
        text.text = [NSString stringWithFormat:@" - %@", [[NSString alloc] initWithFormat:NSLocalizedString(position, @"position")]];
        text.font = [UIFont systemFontOfSize:10];
        [self.v_symbols addSubview:text];
        
        x += 85;
        if(x > 255)
        {
            x = 40;
            y += 20;
        }
        
        
    }
}

- (IBAction)previousMonth:(id)sender
{
    NSString *previousMonthOfYear = [TBSDate previousMonthOfYear:self.year Month:self.month];
    NSString *previousMonthOfYearStr = [[previousMonthOfYear componentsSeparatedByString:@"-"] objectAtIndex:0];
    NSString *previousMonthStr = [[previousMonthOfYear componentsSeparatedByString:@"-"] objectAtIndex:1];
    
    self.month = [previousMonthStr integerValue];
    self.year = [previousMonthOfYearStr integerValue];
    
    NSLog(@"previous=%02ld-%02ld", self.year, self.month);
    
//    self.l_showMonth.text = [TBSDate getMonthStringFromMonth:self.month];
    self.l_showMonth.text = [[NSString alloc] initWithFormat:NSLocalizedString([TBSDate getMonthStringFromMonth:self.month], @"Month")];
    
    //draw or re-draw
    [self showCalendar];
    
}

- (IBAction)nextMonth:(id)sender
{
    NSString *nextMonthOfYear = [TBSDate nextMonthOfYear:self.year Month:self.month];
    NSString *nextMonthOfYearStr = [[nextMonthOfYear componentsSeparatedByString:@"-"] objectAtIndex:0];
    NSString *nextMonthStr = [[nextMonthOfYear componentsSeparatedByString:@"-"] objectAtIndex:1];
    
    self.month = [nextMonthStr integerValue];
    self.year = [nextMonthOfYearStr integerValue];
    
    NSLog(@"previous=%02ld-%02ld", self.year, self.month);
    
//    self.l_showMonth.text = [TBSDate getMonthStringFromMonth:self.month];
    self.l_showMonth.text = [[NSString alloc] initWithFormat:NSLocalizedString([TBSDate getMonthStringFromMonth:self.month], @"Month")];
    
    //draw or re-draw
    [self showCalendar];
    
}



@end
