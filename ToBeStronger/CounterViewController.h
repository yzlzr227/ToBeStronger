//
//  CounterViewController.h
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-24.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentOfDay.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
#import "TimerViewController.h"

@interface CounterViewController : UIViewController

//used to stroe rest time
@property (strong, nonatomic) NSMutableArray *restTimes;

@end
