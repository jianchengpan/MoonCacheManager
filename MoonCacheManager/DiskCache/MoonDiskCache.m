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
    });
    
    return singleDBQueue;
}

#pragma mark - workWith sqlMaker

-(NSArray *)queryWithSqlMaker:(MoonSqlQueryMaker *)maker andError:(NSError *__autoreleasing *)error{
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
    }];
    return nil;
}

-(void)saveWithSqlMaker:(MoonSqlSaveMaker *)maker andError:(NSError *__autoreleasing *)error{
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
    }];
}

#pragma mark - execute sql

-(FMResultSet *)executeQuerySql:(NSString *)sql withError:(NSError *__autoreleasing *)error{
    __block FMResultSet *rs = nil;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        rs = [db executeQuery:sql values:nil error:error];
        [db close];
    }];
    return rs;
}

-(BOOL)executeUpdateSql:(NSString *)sql withError:(NSError *__autoreleasing *)error{
    __block BOOL success = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql values:nil error:error];
        [db close];
    }];
    return success;
}

@end
