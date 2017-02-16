//
//  MoonDiskCacheProtocol.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
