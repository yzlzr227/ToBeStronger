//
//  TBSViewController.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "TodayViewController.h"


@interface TodayViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tv_showDetail;
@property (strong, nonatomic) NSArray *contentIDs;
@property (strong, nonatomic) NSArray *contentsArray;
@property (strong, nonatomic) NSMutableDictionary *positionsDic;
@property (weak, nonatomic) IBOutlet UILabel *l_showDate;
@property (weak, nonatomic) IBOutlet UILabel *l_showWeekDay;


//receive from calendar view
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSDate *dateObj;

//For test
@property (strong, nonatomic) ContentOfDay *testContent1;
@property (strong, nonatomic) ContentOfDay *testContent2;
@property (strong, nonatomic) ContentOfDay *testContent3;

//For past value to counter
@property (strong, nonatomic) ContentOfDay *selectedContent;

//name of content to be deleted
@property (strong, nonatomic) NSString *nameOfContentToBeDeleted;

@end

@implementation TodayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //For test
//    self.date = @"2014-04-07";
    
    //init dateObj using date string getting from Calendar view, and set UILable to show date
    [self setTodayDate];

    //set table views
    [self prepareContentData];
    [self.tv_showDetail setDelegate:self];
    [self.tv_showDetail setDataSource:self];
    [self.tv_showDetail setSeparatorColor:[UIColor whiteColor]];
    
        
}

//init dateObj using date string getting from Calendar view, and set UILable to show date
- (void)setTodayDate
{
    //For test, using today date
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    self.date = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.dateObj = [formatter dateFromString:self.date];
    
    //set UILable to show date
    self.l_showDate.text = [NSString stringWithFormat:@"%d", [[[self.date componentsSeparatedByString:@"-"] objectAtIndex:2] intValue]];
    //    NSLog(@"Weekday=%@", [self getWeedDayFromDate:[NSDate date]]);
//    self.l_showWeekDay.text = [TBSDate getWeedDayFromDate:self.dateObj];
    self.l_showWeekDay.text = [NSString stringWithFormat:NSLocalizedString([TBSDate getWeedDayFromDate:self.dateObj], @"Weekday")];

}


- (void)prepareContentData
{
    TBSDatabase *db = [[TBSDatabase alloc] init];
    self.contentsArray = [db getContentsOfDayByDate:self.date];
    

    self.positionsDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    for(ContentOfDay *content in self.contentsArray)
    {
        if(![[self.positionsDic allKeys] containsObject:content.position]) //if position does not exsit in dictionary
        {
            NSMutableArray *contentOfPostionArray = [[NSMutableArray alloc] init];
            [contentOfPostionArray addObject:content];
            [self.positionsDic setObject:contentOfPostionArray forKey:content.position];
        }else                                                              //if position exsits in dictionary
        {
            [[self.positionsDic objectForKey:content.position] addObject:content];
        }
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSection=%ld", (long)[[self.positionsDic allKeys] count]);
    return [[self.positionsDic allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = (NSString *)[[self.positionsDic allKeys] objectAtIndex:section];
    return [[self.positionsDic objectForKey:key] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    //set UILable for showing position Name
    UILabel *positionLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 20)];
//    positionLable.text = [[self.positionsDic allKeys] objectAtIndex:section];
    positionLable.text = [NSString stringWithFormat:NSLocalizedString([[self.positionsDic allKeys] objectAtIndex:section], @"Position")];
    
    positionLable.font = [UIFont systemFontOfSize:16];
    positionLable.adjustsFontSizeToFitWidth = NO;
    positionLable.textAlignment = NSTextAlignmentLeft;
    [sectionHeaderView addSubview:positionLable];
    
    //set UILable for showing weight hint
    UILabel *weightLable = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 50, 20)];
//    weightLable.text = @"Weight";
    weightLable.text = [NSString stringWithFormat:NSLocalizedString(@"WeightLabel", @"Weight Label")];
    weightLable.font = [UIFont systemFontOfSize:13];
    weightLable.adjustsFontSizeToFitWidth = NO;
    weightLable.textAlignment = NSTextAlignmentCenter;
    [sectionHeaderView addSubview:weightLable];
    
    //set UILable for Num. hint
    UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 50, 20)];
//    numberLable.text = @"Num.";
    numberLable.text = [NSString stringWithFormat:NSLocalizedString(@"NumberLabel", @"Number Label")];
    numberLable.font = [UIFont systemFontOfSize:13];
    numberLable.adjustsFontSizeToFitWidth = NO;
    numberLable.textAlignment = NSTextAlignmentCenter;
    [sectionHeaderView addSubview:numberLable];
    
    //set UILable for Set hint
    UILabel *setsLable = [[UILabel alloc] initWithFrame:CGRectMake(260, 0, 50, 20)];
//    setsLable.text = @"Sets";
    setsLable.text = [NSString stringWithFormat:NSLocalizedString(@"SetsLabel", @"Sets Label")];
    setsLable.font = [UIFont systemFontOfSize:13];
    setsLable.adjustsFontSizeToFitWidth = NO;
    setsLable.textAlignment = NSTextAlignmentCenter;
    [sectionHeaderView addSubview:setsLable];
    
    //set divider
    UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 17, 320, 3)];
    divider.image = [UIImage imageNamed:@"divider1"];
    [sectionHeaderView addSubview:divider];
    
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get content data
    NSString *key = (NSString *)[[self.positionsDic allKeys] objectAtIndex:indexPath.section];
    ContentOfDay *content = [[self.positionsDic objectForKey:key] objectAtIndex:indexPath.row];

    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tv_showDetail dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    }
    
    //set UILable to show content name
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 140, 30)];
    nameLable.text = content.name;
    nameLable.font = [UIFont systemFontOfSize:18];
    nameLable.adjustsFontSizeToFitWidth = NO;
    nameLable.textAlignment = NSTextAlignmentLeft;
    if(content.isFinished)
    {
        nameLable.textColor = [UIColor lightGrayColor];
    }
    [cell addSubview:nameLable];
    
    //set UILable to show weight value
    UILabel *weightLable = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 50, 30)];
    if(content.weight==0)
    {
        weightLable.text = @"";
    }else
    {
        weightLable.text = [NSString stringWithFormat:@"%ld", content.weight];
    }
    weightLable.font = [UIFont systemFontOfSize:15];
    weightLable.adjustsFontSizeToFitWidth = NO;
    weightLable.textAlignment = NSTextAlignmentCenter;
    if(content.isFinished)
    {
        weightLable.textColor = [UIColor lightGrayColor];
    }
    [cell addSubview:weightLable];
    
    //set UILable to show number value
    UILabel *numLable = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 50, 30)];
    numLable.text = [NSString stringWithFormat:@"%ld", content.numberPerSet];
    numLable.font = [UIFont systemFontOfSize:15];
    numLable.adjustsFontSizeToFitWidth = NO;
    numLable.textAlignment = NSTextAlignmentCenter;
    if(content.isFinished)
    {
        numLable.textColor = [UIColor lightGrayColor];
    }
    [cell addSubview:numLable];

    //set UILable to show sets value
    UILabel *setsLable = [[UILabel alloc] initWithFrame:CGRectMake(260, 0, 50, 30)];
    setsLable.text = [NSString stringWithFormat:@"%ld", content.sets];
    setsLable.font = [UIFont systemFontOfSize:15];
    setsLable.adjustsFontSizeToFitWidth = NO;
    setsLable.textAlignment = NSTextAlignmentCenter;
    if(content.isFinished)
    {
        setsLable.textColor = [UIColor lightGrayColor];
    }
    [cell addSubview:setsLable];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get today date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *todaydate = [formatter stringFromDate:[NSDate date]];
    if([todaydate isEqual:self.date])
    {
        //get content data
        NSString *key = (NSString *)[[self.positionsDic allKeys] objectAtIndex:indexPath.section];
        ContentOfDay *content = [[self.positionsDic objectForKey:key] objectAtIndex:indexPath.row];
        self.selectedContent = content;
        
        if(!content.isFinished)
        {
            [self performSegueWithIdentifier:@"segue_todayToCounter" sender:self];
            
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"You are only able to complete today's plan" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];

    }
    
//    //get content data
//    NSString *key = (NSString *)[[self.positionsDic allKeys] objectAtIndex:indexPath.section];
//    ContentOfDay *content = [[self.positionsDic objectForKey:key] objectAtIndex:indexPath.row];
//    self.selectedContent = content;
//    
//    if(!content.isFinished)
//    {
//        [self performSegueWithIdentifier:@"segue_todayToCounter" sender:self];
//        
//    }
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"segue_todayToCounter"])
    {
    CounterViewController *counterController = segue.destinationViewController;
    [counterController setValue:self.selectedContent forKey:@"exerciseContent"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prepareContentData];
    [self.tv_showDetail reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = (NSString *)[[self.positionsDic allKeys] objectAtIndex:indexPath.section];
    ContentOfDay *content = [[self.positionsDic objectForKey:key] objectAtIndex:indexPath.row];
    self.nameOfContentToBeDeleted = content.name;
    
    NSString *deleteConfirmMsg = [NSString stringWithFormat:NSLocalizedString(@"DeleteConfirmation", @"Delete Confirmation")];
    NSString *cancel = [NSString stringWithFormat:NSLocalizedString(@"Cancel", @"Cancel")];
    NSString *confirm = [NSString stringWithFormat:NSLocalizedString(@"Confirm", @"confirm")];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:deleteConfirmMsg
                                                   delegate:self
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:confirm, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSLog(@"click confirm");
        TBSDatabase *db = [[TBSDatabase alloc] init];
        [db deleteContentsWithName:self.nameOfContentToBeDeleted];
        self.nameOfContentToBeDeleted = nil;
        
        //reload
        [self prepareContentData];
        [self.tv_showDetail reloadData];
    }
}












@end
