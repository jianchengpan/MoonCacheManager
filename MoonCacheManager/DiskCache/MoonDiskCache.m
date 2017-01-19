//
//  MoonDiskCache.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonDiskCache.h"
#import "FMDB.h"

#define DataBaseName @"MoonDiskCatch.db"

@interface MoonDiskCache ()

@property (nonatomic, readonly) NSString *databasePath;
@property (nonatomic, readonly) FMDatabaseQueue *databaseQueue;

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


@end
