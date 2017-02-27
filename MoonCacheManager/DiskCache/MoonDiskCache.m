//
//  MoonDiskCache.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonDiskCache.h"


#define DataBaseName @"MoonDiskCatch.db"

@interface MoonDiskCache ()

@property (nonatomic, readonly) NSString *databasePath;

@end

@implementation MoonDiskCache

#pragma mark - properties

-(NSString *)databasePath{
     return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:DataBaseName];
}

-(FMDatabaseQueue *)databaseQueue{
    static FMDatabaseQueue *singleDBQueue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleDBQueue = [FMDatabaseQueue databaseQueueWithPath:self.databasePath];
        NSLog(@"dbPath:%@",self.databasePath);
    });
    
    return singleDBQueue;
}

#pragma mark - workWith sqlMaker

-(NSArray *)queryWithSqlMaker:(MoonSqlQueryMaker *)maker andError:(NSError *__autoreleasing *)error{
    [MoonDiskCacheUtils checkTableInfoWithSqlMaker:maker withError:error];
    NSString *sql = [[maker generateSqls] firstObject];
    NSMutableArray *resultArray = [self executeQuerySql:sql withError:error];
    if(resultArray.count)
        resultArray = [maker handleQueryResult:resultArray];
    return resultArray;
}

-(void)saveWithSqlMaker:(MoonSqlSaveMaker *)maker andError:(NSError *__autoreleasing *)error{
    [MoonDiskCacheUtils checkTableInfoWithSqlMaker:maker withError:error];
    for (NSString *sql in [maker generateSqls]) {
        [self executeUpdateSql:sql withError:error];
        if(error)
            break;
    }
}

#pragma mark - execute sql

-(NSMutableArray<NSDictionary *> *)executeQuerySql:(NSString *)sql withError:(NSError *__autoreleasing *)error{
    __block NSMutableArray *resultArray = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
        rs = [db executeQuery:sql values:nil error:error];
        while ([rs next]) {
            [resultArray addObject:[rs resultDictionary]];
        }
        [rs close];
    }];
    return resultArray;
}

-(BOOL)executeUpdateSql:(NSString *)sql withError:(NSError *__autoreleasing *)error{
    __block BOOL success = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql values:nil error:error];
    }];
    return success;
}

@end
