//
//  RestTime.h
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-4-14.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBSDatabase.h"

@interface RestTime : NSObject

@property (nonatomic) NSInteger contentID;
@property (nonatomic) NSInteger setNumber;
@property (strong, nonatomic) NSString *time;

- (instancetype)initWithContentID:(NSInteger)contentID
                        SetNumber:(NSInteger)setNumber
                             Time:(NSString*)time;

- (void)saveInDatabase;

@end
