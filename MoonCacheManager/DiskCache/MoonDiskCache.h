//
//  MoonDiskCache.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"

#import "MoonDiskCacheProtocol.h"

#import "MoonSqlQueryMaker.h"
#import "MoonSqlSaveMaker.h"
#import "MoonSqlDeleteMaker.h"

#import "MoonDiskCacheUtils.h"

@interface MoonDiskCache : NSObject

@property (nonatomic, readonly) FMDatabaseQueue *databaseQueue;

#pragma mark - workWith sqlMaker

-(NSArray *)queryWithSqlMaker:(MoonSqlQueryMaker *)maker andError:(NSError **)error;

-(void)saveWithSqlMaker:(MoonSqlSaveMaker *)maker andError:(NSError **)error;

#pragma mark - execute sql


/**
 execute query sql string,

 @param sql query sql
 @param error an error object pointer
 @return query result that is an array contain all query result,every result has been convert into a dictionary
 */
-(NSMutableArray<NSDictionary *>*)executeQuerySql:(NSString *)sql withError:(NSError **)error;

/**
 excute update sql string

 @param sql update sql
 @param error an error object pointer
 @return update result
 */
-(BOOL)executeUpdateSql:(NSString *)sql withError:(NSError **)error;

@end
