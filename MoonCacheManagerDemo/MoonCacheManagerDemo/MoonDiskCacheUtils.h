//
//  MoonDiskCacheUtils.h
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/14.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoonDiskCacheUtils : NSObject

/**
 get all the properties define in the class

 @param cls operating class
 @return properties name
 */
+(NSMutableArray <NSString *>*)allPropertiesNameOfClass:(Class) cls;


/**
 get all properties of class,except readOnly proeprties and ignore properties(define in MoonDiskCacheProtocol)

 @param cls operating class
 @return valid properties name
 */
+(NSMutableArray <NSString *>*)validPropertiesNameOfClass:(Class)cls;


/**
 translate a object to dictionary, dictionary's keys is subset of valid properties, and the property value is nil will not translate into dictionary

 @param obj operating obj
 @return dictionary contain poperty's key and value
 */
+(NSMutableDictionary *)translateObjcToDictionary:(id)obj;

@end
