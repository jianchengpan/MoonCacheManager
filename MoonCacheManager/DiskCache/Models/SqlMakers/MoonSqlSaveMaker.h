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

-(MoonSqlSaveMaker *(^)(id))save;

@end
