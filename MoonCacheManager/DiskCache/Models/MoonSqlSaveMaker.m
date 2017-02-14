//
//  MoonSqlSaveMaker.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonSqlSaveMaker.h"

@implementation MoonSqlSaveMaker

-(NSArray<NSString *> *)generateSqls{
    return nil;
}

-(MoonSqlSaveMaker *(^)(id))save{
    return ^id(id obj){
        self.operatingObj = obj;
        return self;
    };
}

@end
