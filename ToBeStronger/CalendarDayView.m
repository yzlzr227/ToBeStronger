//
//  CalendarDayView.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-4-4.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "CalendarDayView.h"

@interface CalendarDayView()

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSArray *contents;
@property (strong, nonatomic) UIViewController *parentView;
@property (strong, nonatomic) NSArray *allContents;

@end

@implementation CalendarDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                         Date:(NSString *)date
                   parentView:(UIViewController *)parentView
                  AllContents:(NSArray *)allContents
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.date = date;
        self.parentView = parentView;
        self.allContents = allContents;
        
        NSString *dayStr = [[date componentsSeparatedByString:@"-"] objectAtIndex:2];
        UILabel *l_showDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 46, 15)];
        l_showDate.text = [NSString stringWithFormat:@"    %@", dayStr];
        l_showDate.font = [UIFont systemFontOfSize:11];
        l_showDate.textAlignment = NSTextAlignmentLeft;
        l_showDate.backgroundColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:0.5];
        [self addSubview:l_showDate];
        
        UIImageView *seperator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 46, 2)];
        seperator.image = [UIImage imageNamed:@"divider1"];
        [self addSubview:seperator];
        
        [self addContentIcons];
  
        
    }

    return self;
}

- (instancetype)initForTodayWithFrame:(CGRect)frame
                                 Date:(NSString *)date
                           parentView:(UIViewController *)parentView
                         AllContents:(NSArray *)allContents
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.date = date;
        self.parentView = parentView;
        self.allContents = allContents;
        
        NSString *dayStr = [[date componentsSeparatedByString:@"-"] objectAtIndex:2];
        UILabel *l_showDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 46, 15)];
        l_showDate.text = [NSString stringWithFormat:@"    %@", dayStr];
        l_showDate.font = [UIFont systemFontOfSize:12];
        l_showDate.textAlignment = NSTextAlignmentLeft;
        l_showDate.backgroundColor = [UIColor colorWithRed:0.96 green:0.65 blue:0.14 alpha:1];
        [self addSubview:l_showDate];
        
        UIImageView *seperator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 46, 2)];
        seperator.image = [UIImage imageNamed:@"divider1"];
        [self addSubview:seperator];
        
        [self addContentIcons];
        
        
    }
    
    return self;
}

- (instancetype)initWithBlankContent:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel *l_showDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 46, 15)];
        l_showDate.backgroundColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:0.5];
        [self addSubview:l_showDate];
        
        UIImageView *seperator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 46, 2)];
        seperator.image = [UIImage imageNamed:@"divider1"];
        [self addSubview:seperator];
    }
    
    return self;
}

- (void)addContentIcons
{
    NSMutableArray *contentsMutableArray = [[NSMutableArray alloc] init];
    for(ContentOfDay *content in self.allContents)
    {
        if([content.date isEqual:self.date])
        {
            [contentsMutableArray addObject:content];
        }
    }
    NSArray *contents = [contentsMutableArray copy];
    
    NSMutableArray *positions = [[NSMutableArray alloc] init];
    for(ContentOfDay *content in contents)
    {
        if(![positions containsObject:content.position])
        {
            [positions addObject:content.position];
        }
    }
    
    switch ([positions count])
    {
        case 0:
            break;
        case 1:
        {
            UIImageView *iconview = [[UIImageView alloc] initWithFrame:CGRectMake(12, 17, 15, 15)];
            iconview.image = [self getIconForPosition:[positions objectAtIndex:0]];
            [self addSubview:iconview];
            break;
        }
        case 2:
        {
            UIImageView *iconview1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 17, 15, 15)];
            iconview1.image = [self getIconForPosition:[positions objectAtIndex:0]];
            [self addSubview:iconview1];
            UIImageView *iconview2 = [[UIImageView alloc] initWithFrame:CGRectMake(27, 17, 15, 15)];
            iconview2.image = [self getIconForPosition:[positions objectAtIndex:1]];
            [self addSubview:iconview2];
            break;
        }
        case 3:
        {
            UIImageView *iconview1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 17, 15, 15)];
            iconview1.image = [self getIconForPosition:[positions objectAtIndex:0]];
            [self addSubview:iconview1];
            UIImageView *iconview2 = [[UIImageView alloc] initWithFrame:CGRectMake(27, 17, 15, 15)];
            iconview2.image = [self getIconForPosition:[positions objectAtIndex:1]];
            [self addSubview:iconview2];
            UIImageView *iconview3 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 33, 15, 15)];
            iconview3.image = [self getIconForPosition:[positions objectAtIndex:2]];
            [self addSubview:iconview3];
            break;
        }
        case 4:
        {
            UIImageView *iconview1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 17, 15, 15)];
            iconview1.image = [self getIconForPosition:[positions objectAtIndex:0]];
            [self addSubview:iconview1];
            UIImageView *iconview2 = [[UIImageView alloc] initWithFrame:CGRectMake(27, 17, 15, 15)];
            iconview2.image = [self getIconForPosition:[positions objectAtIndex:1]];
            [self addSubview:iconview2];
            UIImageView *iconview3 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 33, 15, 15)];
            iconview3.image = [self getIconForPosition:[positions objectAtIndex:2]];
            [self addSubview:iconview3];
            UIImageView *iconview4 = [[UIImageView alloc] initWithFrame:CGRectMake(27, 33, 15, 15)];
            iconview4.image = [self getIconForPosition:[positions objectAtIndex:3]];
            [self addSubview:iconview4];
            break;
        }
        default:
        {
            UIImageView *iconview1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 17, 15, 15)];
            iconview1.image = [self getIconForPosition:[positions objectAtIndex:0]];
            [self addSubview:iconview1];
            UIImageView *iconview2 = [[UIImageView alloc] initWithFrame:CGRectMake(27, 17, 15, 15)];
            iconview2.image = [self getIconForPosition:[positions objectAtIndex:1]];
            [self addSubview:iconview2];
            UIImageView *iconview3 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 33, 15, 15)];
            iconview3.image = [self getIconForPosition:[positions objectAtIndex:2]];
            [self addSubview:iconview3];
            UILabel *iconview4 = [[UILabel alloc] initWithFrame:CGRectMake(27, 33, 15, 15)];
            iconview4.text = @"...";
            iconview4.textAlignment = NSTextAlignmentCenter;
            iconview4.font = [UIFont boldSystemFontOfSize:8];
            [self addSubview:iconview4];
            break;
        }
    }
}


//need modify
- (UIImage *)getIconForPosition:(NSString *)position
{
//    NSLog(@"position=%@", position);
    NSString *imgName = [NSString stringWithFormat:@"icon_%@", position];
//    NSLog(imgName);
    return [UIImage imageNamed:imgName];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor colorWithRed:0.96 green:0.65 blue:0.14 alpha:1];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CalendarViewController *calendarView = (CalendarViewController *) self.parentView;
    
    [calendarView selectDate:self.date];
    [calendarView performSegueWithIdentifier:@"segue_monthToToday" sender:self.parentView];
    
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];

}



@end
