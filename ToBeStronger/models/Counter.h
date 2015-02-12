//
//  Counter.h
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Counter : NSObject

@property (nonatomic) NSInteger planedNumber;
@property (nonatomic) NSInteger currentNumber;
@property (nonatomic, getter = isFinished) BOOL finished;

- (instancetype)initWithPlanedNumber:(NSInteger)planedNumber;
- (void)count;

@end

