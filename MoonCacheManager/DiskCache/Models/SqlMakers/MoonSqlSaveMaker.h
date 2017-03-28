//
//  MoonSqlSaveMaker.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonSqlMaker.h"

@interface MoonSqlSaveMaker : MoonSqlMaker

@property (nonatomic, strong) id operatingObj;
@property (nonatomic, strong) NSDictionary *extraInfoDic;
@property (nonatomic, strong) NSMutableArray *relationobjs;

-(MoonSqlSaveMaker *(^)(id))save;

-(MoonSqlSaveMaker *(^)(NSDictionary *))extraInfo;

-(MoonSqlSaveMaker *(^)(id))relationObj;

@end
