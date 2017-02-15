//
//  MoonDiskCacheUtils.m
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/14.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonDiskCacheUtils.h"
#include <objc/runtime.h>

#define MoonDiskCacheUtilsAllPropertiesNameKey @"allProperties"
#define MoonDiskCacheUtilsValidPropertiesNameKey @"validProperties"

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
         /key(tableName) --> value-   ...
        /                           \ ...
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
#pragma mark - properties -- allPropertiesName

+(nullable NSMutableArray *)allPropertiesNameOfClassInCache:(Class)cls{
    return [self getCacheInfoOfClass:cls forKey:MoonDiskCacheUtilsAllPropertiesNameKey];
}

+(void)cacheAllPropertiesName:(NSMutableArray *)propertiesName OfClass:(Class)cls{
    [self cacheInfo:propertiesName forClass:cls forKey:MoonDiskCacheUtilsAllPropertiesNameKey];
}

+(NSMutableArray<NSString *> *)allPropertiesNameOfClass:(Class)cls{
    NSMutableArray *propertiesName = [self allPropertiesNameOfClassInCache:cls];
    if(!propertiesName){
        propertiesName = [NSMutableArray array];
        unsigned int propertiesNum = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &propertiesNum);
        for (int i = 0; i < propertiesNum; i++) {
            objc_property_t property = properties[i];
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            [propertiesName addObject:name];
        }
        [self cacheAllPropertiesName:propertiesName OfClass:cls];
    }
    return propertiesName;
}

#pragma mark - properties -- validPropertiesName

+(nullable NSMutableArray *)validPropertiesNameOfClassInCache:(Class)cls{
    return [self getCacheInfoOfClass:cls forKey:MoonDiskCacheUtilsValidPropertiesNameKey];
}

+(void)cacheValidPropertiesName:(NSMutableArray *)validPropertiesName OfClass:(Class)cls{
    [self cacheInfo:validPropertiesName forClass:cls forKey:MoonDiskCacheUtilsValidPropertiesNameKey];
}

+(NSMutableArray <NSString *>*)validPropertiesNameOfClass:(Class)cls{
    NSMutableArray *validPropertiesName = [self validPropertiesNameOfClassInCache:cls];
    if(!validPropertiesName){
        validPropertiesName = [NSMutableArray array];
        unsigned int propertiesNum = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &propertiesNum);
        for (int i = 0; i < propertiesNum; i++) {
            objc_property_t property = properties[i];
            if(property_copyAttributeValue(property, "R"))//filer readOnly properties
                continue;
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            [validPropertiesName addObject:name];
        }
        if([cls respondsToSelector:@selector(ignoreProperties)]){//filer ignore properties
            NSArray *ignoreProperties = [cls ignoreProperties];
            for (NSString *string in ignoreProperties) {
                [validPropertiesName removeObject:string];
            }
        }
        
        [self cacheValidPropertiesName:validPropertiesName OfClass:cls];
    }
    return validPropertiesName;
}

#pragma mark - translateObject

+(NSMutableDictionary *)translateObjcToDictionary:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (NSString *key in [self validPropertiesNameOfClass:[obj class]]) {
        id value = [obj valueForKey:key];
        if(value)
            [dic setObject:value forKey:key];
    }
    
    return dic;
}

@end
