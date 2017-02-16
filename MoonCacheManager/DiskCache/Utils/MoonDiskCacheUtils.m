//
//  MoonDiskCacheUtils.m
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/14.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#include <objc/runtime.h>
#import "MoonDiskCacheUtils.h"

#define MoonDiskCacheUtilsAllPropertiesNameKey @"allProperties"
#define MoonDiskCacheUtilsValidPropertiesNameKey @"validProperties"

#define MoonDiskCacheUtilsPropertiesInfoKey @"propertiesInfo"

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
        [createTableSql appendFormat:@"%@ %@,",propertyInfo.propertyName,propertyInfo.sqlType];
    }
    
    [createTableSql replaceCharactersInRange:NSMakeRange(createTableSql.length - 1, 1) withString:@""];
    
    [createTableSql appendString:@")"];
    
    return createTableSql;
}

@end
