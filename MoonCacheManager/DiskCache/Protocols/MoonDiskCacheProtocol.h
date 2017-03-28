//
//  MoonDiskCacheProtocol.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonRelationModel.h"

@protocol MoonDiskCacheProtocol

@required

/**

 uniqueIdentifier of a object in table

 @return uniqueIdentifier key
 */
+(NSString *)indexKey;

@optional


/**
 the properties don't need save to disk

 @return ignoreProperties
 */
+(NSArray<NSString *> *)ignoreProperties;

/**
 customize objct data info that need save to disk, default use MoonDiskCacheUtils translateObjcToDictionary method

 @return data info
 */
-(NSMutableDictionary *)dataMap;


/**
 when you use dataMap to customize save info,you may use this function to retrieve the customized info. default use  - (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues

 @param dict query result dictionary
 */
-(void)configWithQueryResultDictionary:(NSDictionary *)dict;


/**
 you can use this method to creat relation of classes

 @return relation infos
 */
+(NSArray<MoonRelationModel *>*)relationInfo;

@end
