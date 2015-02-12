//
//  CounterViewController.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-24.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//


#import "CounterViewController.h"

@interface CounterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *l_currentNumber;
@property (weak, nonatomic) IBOutlet UILabel *l_planedNumber;
@property (weak, nonatomic) IBOutlet UILabel *l_setNumber;
@property (weak, nonatomic) IBOutlet UILabel *l_countingMethod;

@property (strong, nonatomic) ContentOfDay *exerciseContent;
@property (nonatomic) NSInteger setNumber;
@property (nonatomic) NSInteger curNumber;

//used for counting by Accelorometer
@property (nonatomic) BOOL isActivated;
@property (strong, nonatomic) NSMutableArray *fiveRecords;
@property (strong, nonatomic) NSMutableArray *thirtyRecords;
@property (nonatomic) BOOL haveOneCountInThirtyRecordFlag;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;

@property (atomic) NSInteger dynamicWindowsCount;
@property (atomic) double dynamicMax;
@property (atomic) double dynamicMin;
@property (atomic) double dynamicThreshold;

//used for playing counting voice
@property (strong, nonatomic) AVAudioPlayer *countingVoicePlayer;

@end

@implementation CounterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"msg rec:%@", self.exerciseContent.name);
    
    self.restTimes = [[NSMutableArray alloc] init];
    
    self.dynamicWindowsCount = 0;
    self.dynamicMax = 0;
    self.dynamicMin = 0;
    
    //    //new a ContentOfDay object for test
    //    self.exerciseContent = [[ContentOfDay alloc] initWithID:1
    //                                                       Name:@"Pushups"
    //                                                   Position:@"Chest"
    //                                               nubmerPerSet:12
    //                                                       Sets:4
    //                                                     Weight:0
    //                                                       Date:@"2014-3-24"
    //                                             CountingMethod:@"Accelorometer"
    //                                                 isFinished:NO];
    
    //initial view
    
    self.setNumber = 1;
//    self.l_setNumber.text = [NSString stringWithFormat:@"Set %ld", (long)self.setNumber];
    self.l_setNumber.text = [NSString stringWithFormat:NSLocalizedString(@"SetNumber", @"Set Number"), (long)self.setNumber];
    
    NSString *iCountingMethod = [NSString stringWithFormat:NSLocalizedString(self.exerciseContent.countingMethod, @"Counting Method")];
    NSString *iCountingMethodHint = [NSString stringWithFormat:NSLocalizedString(@"CountingMethodHint", @"Counting Method Hint"),iCountingMethod];
    
//    self.l_countingMethod.text = [NSString stringWithFormat:@"CountingMethod: %@", self.exerciseContent.countingMethod];
    self.l_countingMethod.text = iCountingMethodHint;
    
    self.l_currentNumber.font = [UIFont fontWithName:@"Farrington-7B-Qiqi" size:70];
    self.l_currentNumber.text = [NSString stringWithFormat:@"00"];
    
    self.l_planedNumber.font = [UIFont fontWithName:@"Farrington-7B-Qiqi" size:70];
    self.l_planedNumber.text = [NSString stringWithFormat:@"%02ld", (long)self.exerciseContent.numberPerSet];
    
    //    if([self.exerciseContent.countingMethod  isEqual: @"Accelorometer"])
    //    {
    //        [self startCountingByAccelorometer];
    //    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.curNumber = 0;
    self.l_currentNumber.text = @"00";
    self.isActivated = YES;
    
    if([self.exerciseContent.countingMethod  isEqual: @"Accelorometer"])
    {
        [self startCountingByAccelorometer];
    }
    
    
    //for test
    NSLog(@"RestTime Count = %d", [self.restTimes count]);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.motionManager stopDeviceMotionUpdates];
    NSLog(@"stop updating");
}

- (void)startCountingByAccelorometer
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    self.fiveRecords = [[NSMutableArray alloc] init];
    self.thirtyRecords = [[NSMutableArray alloc] init];
    self.haveOneCountInThirtyRecordFlag = NO;
    
    if(self.motionManager.deviceMotionAvailable)
    {
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        
        [self.motionManager startDeviceMotionUpdatesToQueue:self.queue
                                                withHandler:^(CMDeviceMotion *motion, NSError *error)
         {
             double x = motion.userAcceleration.x;
             double y = motion.userAcceleration.y;
             double z = motion.userAcceleration.z;
             
             NSNumber *sum = [NSNumber numberWithDouble:sqrt(x*x + y*y + z*z)];
             
             if(self.isActivated)
             {
                 if(self.dynamicWindowsCount < 50)
                 {
                     if([sum integerValue] > self.dynamicMax)
                         self.dynamicMax = [sum doubleValue];
                     if([sum integerValue] < self.dynamicMin)
                         self.dynamicMin = [sum doubleValue];
                     
                     self.dynamicWindowsCount++;
                 }else
                 {
                     self.dynamicThreshold = (self.dynamicMax + self.dynamicMin) / 2;
                     
                     self.dynamicWindowsCount = 0;
                     self.dynamicMax = 0;
                     self.dynamicMin = 0;
                 }
                 
                 
                 if([self.thirtyRecords count] < 90)
                 {
                     [self.thirtyRecords addObject:sum];
                 }else
                 {
                     [self.thirtyRecords removeAllObjects];
                     self.haveOneCountInThirtyRecordFlag = NO;
                 }
                 
                 if([self.fiveRecords count] < 5)
                 {
                     [self.fiveRecords addObject:sum];
                 }else
                 {
                     [self.fiveRecords removeObjectAtIndex:0];
                     [self.fiveRecords addObject:sum];
                     
                     
                     double n1 = [[self.fiveRecords objectAtIndex:0] doubleValue];
                     double n2 = [[self.fiveRecords objectAtIndex:1] doubleValue];
                     double n3 = [[self.fiveRecords objectAtIndex:2] doubleValue];
                     double n4 = [[self.fiveRecords objectAtIndex:3] doubleValue];
                     double n5 = [[self.fiveRecords objectAtIndex:4] doubleValue];
                     
                     double avg = (n1 + n2 + n3 + n4 + n5) / 5;
                     
                     
//                     if((n2 > n1) && (n3 > n2) && (n4 < n3) && (n5 < n4))
                     if((avg > (self.dynamicThreshold * 1.3)) && avg > 0.5)
                     {
   
                         if(self.haveOneCountInThirtyRecordFlag == NO)
                         {
                             self.curNumber++;
                             self.haveOneCountInThirtyRecordFlag = YES;
                             [self.thirtyRecords removeAllObjects];
                             NSLog(@"count=%ld", self.curNumber);
                             
                             [self performSelectorOnMainThread:@selector(changeCountingNum) withObject:nil waitUntilDone:NO];
                             
                         }
                     }
                 }
             }
         }];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self.exerciseContent.countingMethod  isEqual:@"Touch"])
    {
        self.curNumber++;
        [self.countingVoicePlayer stop];
        [self performSelectorOnMainThread:@selector(changeCountingNum) withObject:nil waitUntilDone:NO];
        
    }
    
}

- (void)changeCountingNum
{
    if(self.curNumber < self.exerciseContent.numberPerSet)
    {
        self.l_currentNumber.text = [NSString stringWithFormat:@"%02ld", self.curNumber];
    }else
    {
        self.l_currentNumber.text = [NSString stringWithFormat:@"%02ld", self.curNumber];
        
        self.setNumber++;
        
        if(self.setNumber <= self.exerciseContent.sets)
        {
            self.isActivated = NO;
            [self performSegueWithIdentifier:@"segue_CounterToTimer" sender:self];
//            self.l_setNumber.text = [NSString stringWithFormat:@"Set %ld", self.setNumber];
            self.l_setNumber.text = [NSString stringWithFormat:NSLocalizedString(@"SetNumber", @"Set Number"), (long)self.setNumber];
        }else //plan finished
        {
            NSLog(@"Set Finished");
            
            //store rest times
            for(RestTime *restime in self.restTimes)
            {
                [restime saveInDatabase];
            }
            
            [self.exerciseContent finishPlan];
            [self.navigationController popViewControllerAnimated:YES];
        }
//        self.curNumber = 0;
        self.l_currentNumber.text = [NSString stringWithFormat:@"%02ld", self.curNumber];
    }
    
    //play counting voice
    if(self.curNumber < 20)
    {
        NSString *resourceStr = [NSString stringWithFormat:@"voice_%ld", (long)self.curNumber];
        NSString *voicePath = [[NSBundle mainBundle] pathForResource:resourceStr ofType:@"mp3"];
        NSLog(@"path=%@", voicePath);
        self.countingVoicePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:voicePath]
                                                                   fileTypeHint:@"mp3"
                                    
                                                                          error:nil];
        
        [self.countingVoicePlayer prepareToPlay];
        [self.countingVoicePlayer setNumberOfLoops:0];
        [self.countingVoicePlayer setVolume:1];
        [self.countingVoicePlayer play];
        
    }else
    {
        NSString *resourceStr = [NSString stringWithFormat:@"voice_%ldx", self.curNumber / 10];
        NSString *voicePath = [[NSBundle mainBundle] pathForResource:resourceStr ofType:@"mp3"];
        NSLog(@"path1=%@", voicePath);
        self.countingVoicePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:voicePath]
                                                                   fileTypeHint:@"mp3"
                                    
                                                                          error:nil];
        
        [self.countingVoicePlayer prepareToPlay];
        [self.countingVoicePlayer setNumberOfLoops:0];
        [self.countingVoicePlayer setVolume:1];
        [self.countingVoicePlayer play];
        
        while([self.countingVoicePlayer isPlaying])
        {
            
        }
        
        if((self.curNumber % 10) != 0)
        {
            resourceStr = [NSString stringWithFormat:@"voice_%ld", self.curNumber % 10];
            NSLog(@"resourceStr1=%@", resourceStr);
            voicePath = [[NSBundle mainBundle] pathForResource:NSLocalizedString(resourceStr, nil) ofType:@"mp3"];
            NSLog(@"path1=%@", voicePath);
            self.countingVoicePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:voicePath]
                                                                       fileTypeHint:@"mp3"
                                        
                                                                              error:nil];
            
            [self.countingVoicePlayer prepareToPlay];
            [self.countingVoicePlayer setNumberOfLoops:1];
            [self.countingVoicePlayer setVolume:1];
            [self.countingVoicePlayer play];
        }
    }
    
    
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
    if([segue.identifier isEqual:@"segue_CounterToTimer"])
    {
        TimerViewController *dstTimerViewController = segue.destinationViewController;
        
        [dstTimerViewController setValue:[NSNumber numberWithInteger:self.exerciseContent.idNumber] forKeyPath:@"contentID"];
        [dstTimerViewController setValue:[NSNumber numberWithInteger:self.setNumber - 1] forKeyPath:@"set"];
    }
     
 }


@end
