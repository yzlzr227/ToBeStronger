//
//  Counter.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "Counter.h"

@implementation Counter

-(instancetype)initWithPlanedNumber:(NSInteger)planedNumber
{
    self = [super init];
    
    if(self)
    {
        self.planedNumber = planedNumber;
        self.currentNumber = 0;
        self.finished = NO;
    }
    
    return self;
}

-(void)count
{
    if(!self.isFinished && self.currentNumber < self.planedNumber)
    {
        self.currentNumber++;
    }else
    {
        self.finished = YES;
    }
    
}

@end