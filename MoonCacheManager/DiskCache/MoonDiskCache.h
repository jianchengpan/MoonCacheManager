//
//  MoonDiskCache.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MoonDiskCacheProtocol.h"

#import "MoonSqlQueryMaker.h"
#import "MoonSqlSaveMaker.h"
#import "MoonSqlDeleteMaker.h"

#import "MoonDiskCacheUtils.h"

@interface MoonDiskCache : NSObject

-(NSArray *)queryWithSqlMaker:(MoonSqlQueryMaker *)maker andError:(NSError **)error;

-(void)saveWithSqlMaker:(MoonSqlSaveMaker *)maker andError:(NSError **)error;

@end
