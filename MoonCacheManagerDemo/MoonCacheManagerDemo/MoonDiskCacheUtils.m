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
 get all the properties of class from cache,when no cache info ,it will return nil;

 @param cls operating class
 @return properies array
 */
+(nullable NSMutableArray *)allPropertiesNameOfClassInCache:(Class)cls{
    return [[[self shareUtils].classCacheInfo objectForKey:NSStringFromClass(cls)] objectForKey:MoonDiskCacheUtilsAllPropertiesNameKey];
}


/**
 cache all properties name of class

 @param propertiesName properties name value,when value is nil,it won't change old info
 @param cls cache target
 */
+(void)cacheAllPropertiesName:(NSMutableArray *)propertiesName OfClass:(Class)cls{
    NSMutableDictionary *classInfo = [[self shareUtils].classCacheInfo objectForKey:NSStringFromClass(cls)];
    if(!classInfo){
        classInfo = [NSMutableDictionary dictionary];
        [[[self shareUtils] classCacheInfo] setValue:classInfo forKey:NSStringFromClass(cls)];
    }
    if(propertiesName)
        [classInfo setObject:propertiesName forKey:MoonDiskCacheUtilsAllPropertiesNameKey];
}

#pragma mark - properties

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

@end
