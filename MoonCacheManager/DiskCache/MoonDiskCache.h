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

-(FMResultSet *)executeQuerySql:(NSString *)sql withError:(NSError **)error;

-(BOOL)executeUpdateSql:(NSString *)sql withError:(NSError **)error;



@end
