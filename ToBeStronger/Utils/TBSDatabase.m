//
//  TBSDatabase.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-11.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "TBSDatabase.h"

@interface TBSDatabase ()

//@property (nonatomic) sqlite3 *db;

@end

@implementation TBSDatabase

#define DBNAME    @"tbs_database.sqlite"

//Define the column name of ExerciseContent Table
#define TABLE_NAME_EXERCISE_CONTENT @"ExerciseContent"
#define COLUMN_NAME_EXERCISE_CONTEN_ID @"id"
#define COLUMN_NAME_EXERCISE_CONTEN_NAME @"name"
#define COLUMN_NAME_EXERCISE_CONTEN_POSITION @"position"
#define COLUMN_NAME_EXERCISE_CONTEN_NUMBER_PER_SET @"numberPerSet"
#define COLUMN_NAME_EXERCISE_CONTEN_SETS @"sets"
#define COLUMN_NAME_EXERCISE_CONTEN_WEIGHT @"weight"
#define COLUMN_NAME_EXERCISE_CONTEN_DATE @"date"
#define COLUMN_NAME_EXERCISE_CONTEN_COUNTING_METHOD @"countingMethod"
#define COLUMN_NAME_EXERCISE_CONTEN_FINISHED @"finished"

//Define the column name of IntervalTimes Table
#define TABLE_NAME_INTERVAL_TIMES @"IntervalTimes"
#define COLUMN_NAME_INTERVAL_TIMES_ID @"id"
#define COLUMN_NAME_INTERVAL_TIMES_NO @"No"
#define COLUMN_NAME_INTERVAL_TIMES_TIME @"time"
#define COLUMN_NAME_INTERVAL_TIMES_OFCONTENT @"ofContent"

//Define the column name of RestTimes Table
#define TABLE_NAME_REST_TIMES @"RestTimes"
#define COLUMN_NAME_REST_TIMES_ID @"id"
#define COLUMN_NAME_REST_TIMES_OFCONTENT @"ofContent"
#define COLUMN_NAME_REST_TIMES_NO @"No"
#define COLUMN_NAME_REST_TIMES_TIME @"time"


/**
 *  Open the datebase file, if not exists, create one
 */
- (instancetype)init
{
    self = [super init];
    
    [self createTables];
    
    return self;
}

- (void) createTables
{
    sqlite3 *db;
    //Open datebase
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    int result = sqlite3_open([database_path UTF8String], &db);
    if (result != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败: %d", result);
    }

    //Create Exercise Conetent Table
    NSString *sqlToCreateECTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT, %@ BOOL)", TABLE_NAME_EXERCISE_CONTENT, COLUMN_NAME_EXERCISE_CONTEN_ID, COLUMN_NAME_EXERCISE_CONTEN_NAME, COLUMN_NAME_EXERCISE_CONTEN_POSITION, COLUMN_NAME_EXERCISE_CONTEN_NUMBER_PER_SET, COLUMN_NAME_EXERCISE_CONTEN_SETS, COLUMN_NAME_EXERCISE_CONTEN_WEIGHT, COLUMN_NAME_EXERCISE_CONTEN_DATE, COLUMN_NAME_EXERCISE_CONTEN_COUNTING_METHOD, COLUMN_NAME_EXERCISE_CONTEN_FINISHED];
    NSLog(@"sqlToCreateECTable=%@", sqlToCreateECTable);
    
    [self execSql:sqlToCreateECTable];
    
    //Create Inverval Times Table
    NSString *sqlToCreateITTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ INTEGER, %@ INTEGER, %@ TEXT, FOREIGN KEY (%@) REFERENCES %@ (%@))", TABLE_NAME_INTERVAL_TIMES, COLUMN_NAME_INTERVAL_TIMES_ID, COLUMN_NAME_INTERVAL_TIMES_OFCONTENT, COLUMN_NAME_INTERVAL_TIMES_NO, COLUMN_NAME_INTERVAL_TIMES_TIME, COLUMN_NAME_INTERVAL_TIMES_OFCONTENT, TABLE_NAME_EXERCISE_CONTENT, COLUMN_NAME_EXERCISE_CONTEN_ID];
    NSLog(@"sqlToCrrateITTable=%@", sqlToCreateITTable);
    
    [self execSql:sqlToCreateITTable];
    
    //Create Rest Times Table
    
    NSString *sqlToCreateRTTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ INTEGER, %@ INTEGER, %@ TEXT, FOREIGN KEY (%@) REFERENCES %@ (%@))", TABLE_NAME_REST_TIMES, COLUMN_NAME_REST_TIMES_ID, COLUMN_NAME_REST_TIMES_OFCONTENT, COLUMN_NAME_REST_TIMES_NO, COLUMN_NAME_REST_TIMES_TIME, COLUMN_NAME_REST_TIMES_OFCONTENT, TABLE_NAME_EXERCISE_CONTENT, COLUMN_NAME_EXERCISE_CONTEN_ID];
    NSLog(@"sqlToCreateRTTable=%@", sqlToCreateRTTable);
    
    [self execSql:sqlToCreateRTTable];
    
    
}

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
                             Finished:(BOOL)finished
{
    NSString *sqlToInsertECRecord = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', %ld, %ld, %ld, '%@', '%@', %d)"               ,TABLE_NAME_EXERCISE_CONTENT, COLUMN_NAME_EXERCISE_CONTEN_NAME, COLUMN_NAME_EXERCISE_CONTEN_POSITION, COLUMN_NAME_EXERCISE_CONTEN_NUMBER_PER_SET, COLUMN_NAME_EXERCISE_CONTEN_SETS, COLUMN_NAME_EXERCISE_CONTEN_WEIGHT, COLUMN_NAME_EXERCISE_CONTEN_DATE, COLUMN_NAME_EXERCISE_CONTEN_COUNTING_METHOD, COLUMN_NAME_EXERCISE_CONTEN_FINISHED, name, position, numberOfSet, sets, weight, date, countingMethod, finished];
    NSLog(@"sqlToInsertECRecord=%@", sqlToInsertECRecord);
    
    [self execSql:sqlToInsertECRecord];
    
}

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
                       CountingMethod:(NSString *)countingMethod
{
    [self insertExerciseContentWithName:name
                               Position:position NumberOfSet:numberOfSet
                                   Sets:sets
                                  Weight:weight
                                   Date:date
                         CountingMethod:countingMethod
                               Finished:NO];
}


- (void)execSql:(NSString *)sql
{
    sqlite3 *db;
    //Open datebase
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    int result = sqlite3_open([database_path UTF8String], &db);
    if (result != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败: %d", result);
    }

    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
    {
        NSLog(@"database error:%s", err);
    }
    
    sqlite3_close(db);
}

/**
 *  Update a content of a day to finished status
 *
 *  @param id_contentOfDay  ID of the content
*/
- (void)finishAContentOfDayByID:(NSInteger)id_contentOfDay
{
    NSString *sqlToFinishAContentOfDay = [NSString stringWithFormat:@"UPDATE %@ SET %@ = %d WHERE %@ = %ld", TABLE_NAME_EXERCISE_CONTENT, COLUMN_NAME_EXERCISE_CONTEN_FINISHED, YES, COLUMN_NAME_EXERCISE_CONTEN_ID, id_contentOfDay];
    NSLog(@"sqlToFinishAContentOfDay=%@", sqlToFinishAContentOfDay);
    
    [self execSql:sqlToFinishAContentOfDay];
}

/**
 *  save interval time for a certain content of day
 *
 *  @param contentId    ID of the content
 *  @param number       the sequence number of the interval
 *  @param time         the interval time string
 */
- (void)saveIntervalTimeWithContentID:(NSInteger)contentId
                               Number:(NSInteger)number
                                 Time:(NSString*)time
{
    NSString *sqlToInsertIntervalTime = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (%ld, %ld, '%@')", TABLE_NAME_INTERVAL_TIMES, COLUMN_NAME_INTERVAL_TIMES_OFCONTENT, COLUMN_NAME_INTERVAL_TIMES_NO, COLUMN_NAME_INTERVAL_TIMES_TIME, contentId, number, time];
    NSLog(@"sqlToInsertIntervalTime=%@", sqlToInsertIntervalTime);
    [self execSql:sqlToInsertIntervalTime];
}

/**
 *  save rest time for a certain content of day
 *
 *  @param contentId    ID of the content
 *  @param number       the sequence number of the interval
 *  @param time         the interval time string
 */
- (void)saveRestTimeWithContentID:(NSInteger)contentId
                               Number:(NSInteger)number
                                 Time:(NSString*)time
{
    NSString *sqlToInsertRestTime = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (%ld, %ld, '%@')", TABLE_NAME_REST_TIMES, COLUMN_NAME_REST_TIMES_OFCONTENT, COLUMN_NAME_REST_TIMES_NO, COLUMN_NAME_REST_TIMES_TIME, contentId, number, time];
    NSLog(@"sqlToInsertIntervalTime=%@", sqlToInsertRestTime);
    [self execSql:sqlToInsertRestTime];
}

- (NSArray*)getContentsOfDayByDate:(NSString*)date
{
    sqlite3 *db;
    //Open datebase
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    int result = sqlite3_open([database_path UTF8String], &db);
    if (result != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败: %d", result);
    }

    
    NSString *sqlToQueryContentsOfDay = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'", TABLE_NAME_EXERCISE_CONTENT, COLUMN_NAME_EXERCISE_CONTEN_DATE, date];
    NSLog(@"sqlToQueryContentsOfDay=%@\n", sqlToQueryContentsOfDay);
    
    sqlite3_stmt *statement;
    
    NSMutableArray *contentsMutableArray = [[NSMutableArray alloc] init];
    
    if(sqlite3_prepare_v2(db, [sqlToQueryContentsOfDay UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            NSInteger idNumber = sqlite3_column_int(statement, 0);
            
            char *nameChars = (char*)sqlite3_column_text(statement, 1);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            
            char *positionChars = (char*)sqlite3_column_text(statement, 2);
            NSString *position = [[NSString alloc] initWithUTF8String:positionChars];
            
            NSInteger numberPerSet = sqlite3_column_int(statement, 3);
            
            NSInteger sets = sqlite3_column_int(statement, 4);
            
            NSInteger weight = sqlite3_column_int(statement, 5);
            
            char *dateChars = (char*)sqlite3_column_text(statement, 6);
            NSString *date = [[NSString alloc] initWithUTF8String:dateChars];
            
            char *countingMethodChars = (char*)sqlite3_column_text(statement, 7);
            NSString *countingMethod = [[NSString alloc] initWithUTF8String:countingMethodChars];
            
            BOOL finished = sqlite3_column_int(statement, 8);
            
            ContentOfDay *contentOfDay = [[ContentOfDay alloc] initWithID:idNumber
                                                                     Name:name
                                                                 Position:position
                                                             nubmerPerSet:numberPerSet
                                                                     Sets:sets
                                                                   Weight:weight
                                                                     Date:date
                                                           CountingMethod:countingMethod
                                                               isFinished:finished];
            
            [contentsMutableArray addObject:contentOfDay];
        }
    }
    
    NSArray *contentsArray = [contentsMutableArray copy];

    
    sqlite3_close(db);
    
    return contentsArray;
}

- (NSArray*)queryAllContents
{
    sqlite3 *db;
    //Open datebase
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    int result = sqlite3_open([database_path UTF8String], &db);
    if (result != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败: %d", result);
    }
    
    
    NSString *sqlToQueryAllContents = [NSString stringWithFormat:@"SELECT * FROM %@", TABLE_NAME_EXERCISE_CONTENT];
    NSLog(@"sqlToQueryAllContents=%@\n", sqlToQueryAllContents);
    
    sqlite3_stmt *statement;
    
    NSMutableArray *contentsMutableArray = [[NSMutableArray alloc] init];
    
    if(sqlite3_prepare_v2(db, [sqlToQueryAllContents UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            NSInteger idNumber = sqlite3_column_int(statement, 0);
            
            char *nameChars = (char*)sqlite3_column_text(statement, 1);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            
            char *positionChars = (char*)sqlite3_column_text(statement, 2);
            NSString *position = [[NSString alloc] initWithUTF8String:positionChars];
            
            NSInteger numberPerSet = sqlite3_column_int(statement, 3);
            
            NSInteger sets = sqlite3_column_int(statement, 4);
            
            NSInteger weight = sqlite3_column_int(statement, 5);
            
            char *dateChars = (char*)sqlite3_column_text(statement, 6);
            NSString *date = [[NSString alloc] initWithUTF8String:dateChars];
            
            char *countingMethodChars = (char*)sqlite3_column_text(statement, 7);
            NSString *countingMethod = [[NSString alloc] initWithUTF8String:countingMethodChars];
            
            BOOL finished = sqlite3_column_int(statement, 8);
            
            ContentOfDay *contentOfDay = [[ContentOfDay alloc] initWithID:idNumber
                                                                     Name:name
                                                                 Position:position
                                                             nubmerPerSet:numberPerSet
                                                                     Sets:sets
                                                                   Weight:weight
                                                                     Date:date
                                                           CountingMethod:countingMethod
                                                               isFinished:finished];
            
            [contentsMutableArray addObject:contentOfDay];
        }
    }
    
    NSArray *contentsArray = [contentsMutableArray copy];
    
    
    sqlite3_close(db);
    
    return contentsArray;
}


- (void)deleteContentsWithName:(NSString*)name
{
    NSString *sqlToDelteContents = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'", TABLE_NAME_EXERCISE_CONTENT, COLUMN_NAME_EXERCISE_CONTEN_NAME, name];
    NSLog(@"sqlToDelteContents=%@", sqlToDelteContents);
    [self execSql:sqlToDelteContents];
}















@end
