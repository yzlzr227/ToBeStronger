//
//  TBSDatabase.h
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-11.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ContentOfDay.h"


@interface TBSDatabase : NSObject


/**
 *  Insert ExerciseContent in Datebase
 *
 *  @param name        name of exercise content, e.g. Push-up
 *  @param position    postion e.g. Chest
 *  @param numberOfSet number of actions per set
 *  @param sets        number of sets
 *  @param date        date with Format "YYYY-MM-DD"
 *  @param finished    YES/NO
 */
- (void)insertExerciseContentWithName:(NSString *)name
                             Position:(NSString *)position
                          NumberOfSet:(NSInteger)numberOfSet
                                 Sets:(NSInteger)sets
                                Weight:(NSInteger)weight
                                 Date:(NSString *)date
                       CountingMethod:(NSString *)countingMethod
                             Finished:(BOOL)finished;

/**
 *  Insert ExerciseContent in Datebase
 *
 *  @param name        name of exercise content, e.g. Push-up
 *  @param position    postion e.g. Chest
 *  @param numberOfSet number of actions per set
 *  @param sets        number of sets
 *  @param date        date with Format "YYYY-MM-DD"
 */
- (void)insertExerciseContentWithName:(NSString *)name
                             Position:(NSString *)position
                          NumberOfSet:(NSInteger)numberOfSet
                                 Sets:(NSInteger)sets
                                Weight:(NSInteger)weight
                                 Date:(NSString *)date
                       CountingMethod:(NSString *)countingMethod;

/**
 *  Update a content of a day to finished status
 *
 *  @param id_contentOfDay  ID of the content
*/
- (void)finishAContentOfDayByID:(NSInteger)id_contentOfDay;

/**
 *  save interval time for a certain content of day
 *
 *  @param contentId    ID of the content
 *  @param number       the sequence number of the interval
 *  @param time         the interval time string
 */
- (void)saveIntervalTimeWithContentID:(NSInteger)contentId
                               Number:(NSInteger)number
                                 Time:(NSString*)time;

/**
 *  save rest time for a certain content of day
 *
 *  @param contentId    ID of the content
 *  @param number       the sequence number of the interval
 *  @param time         the interval time string
 */
- (void)saveRestTimeWithContentID:(NSInteger)contentId
                           Number:(NSInteger)number
                             Time:(NSString*)time;

/**
 *  query exercise contents of a certain day by date
 *
 *  @param date         the date of the day
 *
 *  @return             the array of the results
 */
- (NSArray*)getContentsOfDayByDate:(NSString*)date;


/**
 *  query all exercise contents in Datebase
 *
 */

- (NSArray*)queryAllContents;

/**
 *  delete all contents that have the given name
 *
 *  @param name name of content that need to be deleted
 */
- (void)deleteContentsWithName:(NSString*)name;











@end
