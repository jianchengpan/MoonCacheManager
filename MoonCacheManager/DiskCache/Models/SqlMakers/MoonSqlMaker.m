//
//  MoonSqlMaker.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/3/28.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonSqlMaker.h"

@implementation MoonSqlMaker

#pragma mark - moonSqlMaker protocol

-(NSArray<NSString *> *)generateSqls{
    return nil;
}

-(NSArray<Class> *)operateTablesRelatedClass{
    return nil;
}

-(instancetype)and{
    return self;
}

-(instancetype)with{
    return self;
}

@end
