//
//  TimerPics.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-9.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "TimerPics.h"

@interface TimerPics ()

@property (strong, nonatomic) NSArray *timerPics;

@end

@implementation TimerPics

- (instancetype)init
{
    self = [super init];
    
    NSMutableArray *timerPicMutableAry = [[NSMutableArray alloc] init];
    
    for(int i = 0; i <= 60; i++)
    {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"timerPic_%d", i]];
//        NSLog(@"ImageName: timerPic_%d", i);
        
        [timerPicMutableAry addObject:faceImage];
    }
    
    self.timerPics = [timerPicMutableAry copy];
    
    return self;
}

- (UIImage *)getTimerImage:(NSInteger)sec
{
    return self.timerPics[sec];
}

@end
