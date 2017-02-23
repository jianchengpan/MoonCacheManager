//
//  MoonDiskCacheUtils.m
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/14.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#include <objc/runtime.h>
#import "MoonDiskCacheUtils.h"

#import "MoonCacheManager.h"

#define MoonDiskCacheUtilsPropertiesInfoKey @"propertiesInfo"
#define MoonDiskCacheUtilsTableCheckInfoKey @"tableCheckInfo"

@interface MoonDiskCacheUtils ()

@property (nonatomic , strong) NSMutableDictionary *classCacheInfo;

@end

@implementation MoonDiskCacheUtils

#pragma mark - init
-(instancetype)init{
    if(self = [super init]){
        _classCacheInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

/**
 share Utils ,it main include some class struct cache info, cache info map as follow:
 
                                              / key-->value
         /key(className) --> value(class info)-   ...
        /                                     \ ...
 cache -  ...
        \
         \...
 
 @return share utils
 */
+(MoonDiskCacheUtils *)shareUtils{
    static MoonDiskCacheUtils *singleUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleUtils = [[MoonDiskCacheUtils alloc] init];
    });
    return singleUtils;
}

#pragma mark - class cache info


/**
 get info of class from cache,when no cache info ,it will return nil;

 @param cls operating class
 @param key detail info of class
 @return class info
 */
+(id)getCacheInfoOfClass:(Class)cls forKey:(NSString *)key{
    return [[[self shareUtils].classCacheInfo objectForKey:NSStringFromClass(cls)] objectForKey:key];
}

/**
 cache info of class

 @param info class info
 @param cls cache target
 @param key detail info's key
 */
+(void)cacheInfo:(id)info forClass:(Class) cls forKey:(NSString *)key{
    NSMutableDictionary *classInfo = [[self shareUtils].classCacheInfo objectForKey:NSStringFromClass(cls)];
    if(!classInfo){
        classInfo = [NSMutableDictionary dictionary];
        [[[self shareUtils] classCacheInfo] setValue:classInfo forKey:NSStringFromClass(cls)];
    }
    if(info)
        [classInfo setObject:info forKey:key];
}

#pragma mark - properties

+(nullable NSMutableArray *)propertiesInfoOfClassInCache:(Class)cls{
    return [self getCacheInfoOfClass:cls forKey:MoonDiskCacheUtilsPropertiesInfoKey];
}

+(void)cachePropertiesInfo:(NSMutableArray *)propertiesInfo OfClass:(Class)cls{
    [self cacheInfo:propertiesInfo forClass:cls forKey:MoonDiskCacheUtilsPropertiesInfoKey];
}

+(NSMutableArray<MoonDiskCachePropertyInfo *> *)propertiesInfoOfClass:(Class)cls{
    NSMutableArray *propertiesInfo = [self propertiesInfoOfClassInCache:cls];
    if(!propertiesInfo){
        
        unsigned int propertiesNum = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &propertiesNum);
        
        propertiesInfo = [NSMutableArray arrayWithCapacity:propertiesNum];
        NSArray *ignoreProperties = nil;
        if([cls respondsToSelector:@selector(ignoreProperties)])
            ignoreProperties = [cls ignoreProperties];
        
        for (int i = 0; i < propertiesNum; i++) {
            objc_property_t property = properties[i];
            
            MoonDiskCachePropertyInfo *propertyInfo = [[MoonDiskCachePropertyInfo alloc] initWithName:[NSString stringWithUTF8String:property_getName(property)] andEncodedType:[NSString stringWithUTF8String:property_copyAttributeValue(property, "T")]];
            
            if(property_copyAttributeValue(property, "R") || [ignoreProperties containsObject:propertyInfo.propertyName])
                propertyInfo.isValidProperties = NO;
            
            [propertiesInfo addObject:propertyInfo];
        }
        
        [self cachePropertiesInfo:propertiesInfo OfClass:cls];
    }
    return propertiesInfo;
}

#pragma mark - translateObject

+(NSMutableDictionary *)translateObjcToDictionary:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (MoonDiskCachePropertyInfo *propertyInfo in [self propertiesInfoOfClass:[obj class]]) {
        if(propertyInfo.isValidProperties){
            id value = [obj valueForKey:propertyInfo.propertyName];
            if(value)
                [dic setObject:value forKey:propertyInfo.propertyName];
        }
    }
    
    return dic;
}

#pragma mark - sql

+(NSString *)generateCreateTableSqlForClass:(Class)cls{

    NSMutableString *createTableSql = [NSMutableString stringWithFormat:@"create table %@ ( id integer primary key autoincrement ,",NSStringFromClass(cls)];
    
    for (MoonDiskCachePropertyInfo *propertyInfo in [self propertiesInfoOfClass:cls]) {
        if(!propertyInfo.isValidProperties)
            continue;
        if([[cls indexKey] isEqualToString:propertyInfo.propertyName])
            [createTableSql appendFormat:@" %@ %@ unique,",propertyInfo.propertyName,propertyInfo.sqlType];
        else
            [createTableSql appendFormat:@" %@ %@,",propertyInfo.propertyName,propertyInfo.sqlType];
    }
    
    [createTableSql replaceCharactersInRange:NSMakeRange(createTableSql.length - 1, 1) withString:@""];
    
    [createTableSql appendString:@")"];
    
    return createTableSql;
}

#pragma mark - check table  tool

+(BOOL)existTableInDisk:(NSString *)tableName{
    __block BOOL exist = NO;
    NSError *error = nil;
    
    NSString *sql = [NSString stringWithFormat:@"select name from sqlite_master where name = '%@'",tableName];
    NSMutableArray *result = [[MoonCacheManager shareManager].diskCache executeQuerySql:sql withError:&error];
    exist = !error && [result count];
    return exist;
}

+(BOOL)correctTableOfClass:(Class)cls{
    BOOL success = NO;
    NSError *error = nil;
    NSString *sql = [NSString stringWithFormat:@"select sql from sqlite_master where name = '%@'",NSStringFromClass(cls)];
    NSMutableArray *result = [[MoonCacheManager shareManager].diskCache executeQuerySql:sql withError:&error];
    
    if(error)
        return NO;
    
    sql = [[result firstObject] objectForKey:@"sql"];
    
    //get all properties save in disk
    NSMutableArray *compents = [[sql componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",)"]] mutableCopy];
    [compents removeObjectAtIndex:0];
    [compents removeLastObject];
    
    NSMutableDictionary *allPropertyKeyInDisk = [NSMutableDictionary dictionary];
    for (NSString *tempString in compents) {
        [allPropertyKeyInDisk setObject:[[tempString componentsSeparatedByString:@" "] objectAtIndex:2] forKey:[[tempString componentsSeparatedByString:@" "] objectAtIndex:1]];
    }
    
    for (MoonDiskCachePropertyInfo *info in [self propertiesInfoOfClass:cls]) {
        if(![allPropertyKeyInDisk objectForKey:info.propertyName] && info.isValidProperties){
            NSString *correctSql = [NSString stringWithFormat:@"alter table %@ add column %@ %@",NSStringFromClass(cls),info.propertyName,info.sqlType];
            [[MoonCacheManager shareManager].diskCache executeUpdateSql:correctSql withError:&error];
            if(error)
                break;
        }
    }
    success = error ? NO : YES;
    return success;
}

+(BOOL)isExistTableOfClass:(Class)cls andCreateIfNotExist:(BOOL)needCreate andError:(NSError **)error{
    MoonDiskCacheTableCheckInfo *info = [self tableCheckInfoOfclass:cls];
    if(!info){
        info = [MoonDiskCacheTableCheckInfo new];
        info.isTableExist = [self existTableInDisk:NSStringFromClass(cls)];
        if(info.isTableExist)
           info.isCorrectedTable = [self correctTableOfClass:cls];
        [self cacheTableCheckInfo:info forClass:cls];
    }
    
    if(!info.isTableExist && needCreate){
        NSString *sql = [self generateCreateTableSqlForClass:cls];
        [[MoonCacheManager shareManager].diskCache executeUpdateSql:sql withError:error];
        NSAssert(!error, @"create table %@ failed",*error);
        info.isTableExist = YES;
        info.isCorrectedTable = YES;
    }
    return info.isTableExist;
}

#pragma mark - check table info

+(MoonDiskCacheTableCheckInfo *)tableCheckInfoOfclass:(Class)cls{
    return [self getCacheInfoOfClass:cls forKey:MoonDiskCacheUtilsTableCheckInfoKey];
}

+(void)cacheTableCheckInfo:(MoonDiskCacheTableCheckInfo *)info forClass:(Class)cls{
    [self cacheInfo:info forClass:cls forKey:MoonDiskCacheUtilsTableCheckInfoKey];
}

+(void)checkTableInfoWithSqlMaker:(id<MoonSqlMakerProtocol>) sqlMaker withError:(NSError *__autoreleasing *)error{
    for (Class cls in [sqlMaker operateTablesRelatedClass]) {
        [self isExistTableOfClass:cls andCreateIfNotExist:YES andError:error];
    }
}



@end
