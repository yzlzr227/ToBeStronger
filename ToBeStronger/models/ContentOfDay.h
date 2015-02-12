//
//  ContentOfDay.h
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exercise.h"
#import "TBSDatabase.h"

@interface ContentOfDay : Exercise

@property (nonatomic) NSInteger idNumber;
@property (strong, nonatomic) NSString *date;
@property (nonatomic, getter = isFinished) BOOL finished;
@property (strong, nonatomic) NSMutableArray *intervalTimes;
@property (strong, nonatomic) NSMutableArray *restTimes;

- (instancetype)initWithName:(NSString *)name
                    Position:(NSString *)position
                nubmerPerSet:(NSInteger)numberPerSet
                        Sets:(NSInteger)sets
                      Weight:(NSInteger)weight
                        Date:(NSString *)date
              CountingMethod:(NSString *)countingMethod;

- (instancetype)initWithName:(NSString *)name
                    Position:(NSString *)position
                nubmerPerSet:(NSInteger)numberPerSet
                        Sets:(NSInteger)sets
                      Weight:(NSInteger)weight
                        Date:(NSString *)date
              CountingMethod:(NSString *)countingMethod
                  isFinished:(BOOL)finished
               intervalTimes:(NSMutableArray*)intervalTimes
                   RestTimes:(NSMutableArray*)RestTimes;

- (instancetype)initWithID:(NSInteger)idNumber
                      Name:(NSString *)name
                  Position:(NSString *)position
              nubmerPerSet:(NSInteger)numberPerSet
                      Sets:(NSInteger)sets
                    Weight:(NSInteger)weight
                      Date:(NSString *)date
            CountingMethod:(NSString *)countingMethod
                isFinished:(BOOL)finished;

- (void)finishPlan;

- (void)storeIntoDateBase;

@end
