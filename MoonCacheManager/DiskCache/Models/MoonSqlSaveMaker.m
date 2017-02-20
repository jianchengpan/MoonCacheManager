//
//  MoonSqlSaveMaker.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonSqlSaveMaker.h"

@implementation MoonSqlSaveMaker

#pragma mark - sqlMaker protocol

-(NSArray<NSString *> *)generateSqls{
    return nil;
}

-(NSArray<Class> *)operateTablesRelatedClass{
    return nil;
}

#pragma mark - operation

-(MoonSqlSaveMaker *(^)(id))save{
    return ^id(id obj){
        self.operatingObj = obj;
        return self;
    };
}

@end
