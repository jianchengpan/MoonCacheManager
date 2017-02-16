//
//  MoonSqlMakerProtocol.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/2/6.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MoonSqlMakerProtocol <NSObject>


/**
 generate sql for operation, There may be more than one sql string,so return an array

 @return sql string array
 */
-(NSArray<NSString *> *)generateSqls;


/**
 the classes that generated sql operated table related class,related class must implementation protocol MoonDiskCacheProtocol

 @return related class name array
 */
-(NSArray<NSString *> *)operateTablesRelatedClassName;

@end
