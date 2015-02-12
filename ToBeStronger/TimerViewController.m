//
//  TimerViewController.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lable_showTime;
@property (nonatomic) NSInteger timeInt;
@property (strong, nonatomic) NSTimer *mTimer;
@property (weak, nonatomic) IBOutlet UIImageView *timerimage;
@property (strong, nonatomic) TimerPics *timerPics;
@property (strong, nonatomic) AVAudioPlayer *clockSoundPlayer;

@property (strong, nonatomic) NSString *timeStr;

//get from CounterView
@property (nonatomic) NSInteger set;
@property (nonatomic) NSInteger contentID;

@end

@implementation TimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"SET=%d, ID=%d", self.set, self.contentID);
    
    self.timerPics = [[TimerPics alloc] init];
    
    self.timeInt = 0;
    self.mTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(updateTime)
                                            userInfo:nil
                                             repeats:YES];
    
    [self initClockSoundPlayer];
    if(self.clockSoundPlayer)
    {
        [self.clockSoundPlayer play];
    }
    
    [self.navigationItem setHidesBackButton:YES];
    
}

- (void)initClockSoundPlayer
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"clock" ofType:@"mp3"];
    if(soundPath)
    {
        self.clockSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:soundPath]
                                                                   error:nil];
        
        [self.clockSoundPlayer prepareToPlay];
        [self.clockSoundPlayer setNumberOfLoops:-1];
        [self.clockSoundPlayer setVolume:1];
    }
}

- (void)updateTime
{
    self.timeInt += 1;
    NSInteger time_sec = self.timeInt - (60 * (int)(self.timeInt / 60));
    NSInteger time_min = (int)self.timeInt / 60;
    self.timeStr = [NSString stringWithFormat:@"%02ld:%02ld", time_min, time_sec];
    
    [self.lable_showTime setText:self.timeStr];
    
    [self.timerimage setImage:[self.timerPics getTimerImage:time_sec]];
}

- (IBAction)continueExercise:(id)sender
{
    [self.clockSoundPlayer stop];
    //store rest time in DB
//    TBSDatabase *db = [[TBSDatabase alloc] init];
//    [db saveRestTimeWithContentID:self.contentID Number:self.set Time:self.timeStr];
    
    RestTime *restTime = [[RestTime alloc] initWithContentID:self.contentID SetNumber:self.set Time:self.timeStr];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    CounterViewController *cvc = [viewControllers objectAtIndex:[viewControllers count] - 2];
    [cvc.restTimes addObject:restTime];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
