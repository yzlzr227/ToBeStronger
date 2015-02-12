//
//  Plan.h
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-7.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentOfDay.h"

@interface Plan : Exercise

@property (strong, nonatomic) NSString *startDate; //format: YYYY-MM-DD
@property (nonatomic) NSInteger frequency;      //Every {frequency} days
@property (nonatomic) NSInteger duration;       //{duration} weeks
@property (nonatomic, getter = isNeedNotification) BOOL needNotification;

- (instancetype)initWithPlanName:(NSString *)name
                        Position:(NSString *)position
                       StartDate:(NSString *)startDate
                       Frequency:(NSInteger)frequency
                       NumPerSet:(NSInteger)numberPerSet
                            Sets:(NSInteger)sets
                          Weight:(NSInteger)weight
                        Duration:(NSInteger)duration
                  CountingMethod:(NSString*)countingMethod
              isNeedNotification:(BOOL)needNotification;

- (NSMutableArray*)generatePlan;

@end
