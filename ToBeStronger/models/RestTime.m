//
//  RestTime.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-4-14.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "RestTime.h"

@implementation RestTime

- (instancetype)initWithContentID:(NSInteger)contentID
                        SetNumber:(NSInteger)setNumber
                             Time:(NSString*)time
{
    self = [super init];
    
    if(self)
    {
        self.contentID = contentID;
        self.setNumber = setNumber;
        self.time = time;
    }
    
    return self;
}

- (void)saveInDatabase
{
    TBSDatabase *db = [[TBSDatabase alloc] init];
    [db saveRestTimeWithContentID:self.contentID Number:self.setNumber Time:self.time];
}

@end
