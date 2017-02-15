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

@end
