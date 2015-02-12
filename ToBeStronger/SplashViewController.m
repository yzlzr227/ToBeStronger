//
//  SplashViewController.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-4-18.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [NSThread sleepForTimeInterval:2];
    
    [self performSegueWithIdentifier:@"segue_splashToCalendar" sender:self];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
