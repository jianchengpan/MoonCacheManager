//
//  MoonCacheManager.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonCacheManager.h"
#import "MoonDiskCache.h"


@interface MoonCacheManager ()

@property (nonatomic, strong) MoonDiskCache *diskCache;

@end

@implementation MoonCacheManager

#pragma mark - init

-(instancetype)init{
    if(self = [super init]){
        self.diskCache = [MoonDiskCache new];
    }
    return self;
}

+(instancetype)shareManager{
    static MoonCacheManager *singleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleManager = [MoonCacheManager new];
    });
    
    return singleManager;
}

#pragma mark - query
+(NSArray *)queryWithSqlMaker:(void(^)(MoonSqlQueryMaker *maker))maker andError:(NSError **)error{
    MoonSqlQueryMaker *queryMaker = [MoonSqlQueryMaker new];
    maker(queryMaker);
    return [[[self shareManager] diskCache] queryWithSqlMaker:queryMaker andError:error];
}

#pragma mark - save
+(void)saveWithSqlMaker:(void (^)(MoonSqlSaveMaker *))maker andError:(NSError *__autoreleasing *)error{
    MoonSqlSaveMaker *saveMaker = [MoonSqlSaveMaker new];
    maker(saveMaker);
}

#pragma mark - delete
+(void)deleteWithSqlMaker:(void (^)(MoonSqlDeleteMaker *))maker andError:(NSError *__autoreleasing *)error{
    MoonSqlDeleteMaker *deleteMaker = [MoonSqlDeleteMaker new];
    maker(deleteMaker);
}

@end
