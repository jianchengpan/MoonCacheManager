//
//  MoonDiskCacheUtils.h
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/14.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MoonDiskCachePropertyInfo.h"

@interface MoonDiskCacheUtils : NSObject

#pragma mark - properties

/**
 get properties info , each property was reorganized as MoonDiskCachePropertyInfo

 @param cls quering class
 @return properties info array
 */
+(NSMutableArray <MoonDiskCachePropertyInfo *> *)propertiesInfoOfClass:(Class)cls;

#pragma mark - object to dictionary

/**
 translate a object to dictionary, dictionary's keys is subset of valid properties, and the property value is nil will not translate into dictionary

 @param obj operating obj
 @return dictionary contain poperty's key and value
 */
+(NSMutableDictionary *)translateObjcToDictionary:(id)obj;

#pragma mark - sql

/**
 generate create table sql for class, 'id' is a increased integer and primary key of table, so you need avoid use 'id' as a property direct,and all the valid properties of class will be a column of of table , the properties type is number will be as 'integer' in database, and other will be 'text'

 @param cls operating class
 @return create table sql of class
 */
+(NSString *)generateCreateTableSqlForClass:(Class)cls;

@end
