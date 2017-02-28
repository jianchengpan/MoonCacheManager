//
//  MoonSqlQueryMaker.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonSqlQueryMaker.h"

@implementation MoonSqlQueryMaker

#pragma mark - init

-(instancetype)init{
    if(self = [super init]){
        self.resultStartIndex = -1;
        self.resultNum = -1;
    }
    return self;
}

#pragma mark - properties
-(NSMutableString *)queryCondition{
    if(!_queryCondition){
        _queryCondition = [NSMutableString string];
    }
    return _queryCondition;
}

-(NSMutableString *)orderCondition{
    if(!_orderCondition){
        _orderCondition = [NSMutableString string];
    }
    return _orderCondition;
}

#pragma mark - query

-(MoonSqlQueryMaker *(^)(__unsafe_unretained Class))query{
    return ^id(Class operationClass){
        self.operatingClass = operationClass;
        return self;
    };
}

-(MoonSqlQueryMaker *(^)(NSString *))where{
    return ^id(NSString *condition){
        if(self.queryCondition.length)
            [self.queryCondition appendString:@"and "];
        [self.queryCondition appendString:condition];
        return self;
    };
}

-(MoonSqlQueryMaker *(^)(NSString *, MoonSqlMakerOrderType))orderBy{
    return ^id(NSString *orderCondition,MoonSqlMakerOrderType orderType){
        if(self.orderCondition.length)
            [self.orderCondition appendString:@", "];
        [self.orderCondition appendFormat:@"%@ ",orderCondition];
        [self.orderCondition appendFormat:@"%@ ",orderType?@"desc ":@"asc "];
        return self;
    };
}

-(MoonSqlQueryMaker *(^)(NSInteger, NSInteger))limit{
    return ^id(NSInteger startIndex,NSInteger count){
        self.resultStartIndex = startIndex - 1;
        self.resultNum = count;
        return self;
    };
}

#pragma mark - sqlMaker protocol

-(NSArray<NSString *> *)generateSqls{
    NSMutableArray *sqls = [NSMutableArray array];
    if(self.operatingClass){
        NSMutableString *querySql = [NSMutableString stringWithFormat:@"select * from %@ ",NSStringFromClass(self.operatingClass)];
        if(_queryCondition.length)
            [querySql appendFormat:@"where %@ ",self.queryCondition];
        if(_orderCondition.length){
            [querySql appendFormat:@"order by %@ ",self.orderCondition];
        }
        
        [querySql appendFormat:@"limit %ld,%ld ",self.resultStartIndex,self.resultNum];
    
        [sqls addObject:querySql];
    }
    return sqls;
}

-(NSArray<Class> *)operateTablesRelatedClass{
    NSMutableArray *classes = [NSMutableArray array];
    if(self.operatingClass)
        [classes addObject:self.operatingClass];
    return classes;
}

-(NSMutableArray *)handleQueryResult:(NSArray<NSDictionary *> *)result{
    NSMutableArray *handleArray = [NSMutableArray array];
    for (NSDictionary *dic in result) {
        id obj = [[self.operatingClass alloc] init];
        [obj respondsToSelector:@selector(configWithQueryResultDictionary:)] ? [obj configWithQueryResultDictionary:dic] :[obj setValuesForKeysWithDictionary:dic];
        [handleArray addObject:obj];
    }
    return handleArray;
}

@end
