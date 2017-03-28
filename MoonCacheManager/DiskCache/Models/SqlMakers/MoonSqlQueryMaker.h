//
//  MoonSqlQueryMaker.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonSqlMaker.h"
#import "MoonSqlMakerOrderType.h"

@interface MoonSqlQueryMaker : MoonSqlMaker

@property (nonatomic, strong) Class operatingClass;

@property (nonatomic, strong) NSMutableString *queryCondition;
@property (nonatomic, strong) NSMutableString *orderCondition;

@property (nonatomic, assign) NSInteger resultStartIndex;
@property (nonatomic, assign) NSInteger resultNum;

-(MoonSqlQueryMaker*(^)(Class))query;

-(MoonSqlQueryMaker*(^)(NSString *))where;

-(MoonSqlQueryMaker*(^)(NSString *,MoonSqlMakerOrderType))orderBy;

/**
 first param will save into 'resultStartIndex',and it's start from 1,sencond param will save into 'resultNum'.
 */
-(MoonSqlQueryMaker*(^)(NSInteger,NSInteger))limit;

@end
