//
//  MoonCacheManager.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MoonDiskCache.h"

@interface MoonCacheManager : NSObject

@property (nonatomic, strong) MoonDiskCache *diskCache;

+(instancetype)shareManager;

+(NSArray *)queryWithSqlMaker:(void(^)(MoonSqlQueryMaker *maker))maker andError:(NSError **)error;

+(void)saveWithSqlMaker:(void(^)(MoonSqlSaveMaker *maker))maker andError:(NSError **)error;

+(void)deleteWithSqlMaker:(void(^)(MoonSqlDeleteMaker *maker))maker andError:(NSError **)error;

@end
