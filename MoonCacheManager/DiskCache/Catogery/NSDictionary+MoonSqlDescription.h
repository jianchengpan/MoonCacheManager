//
//  NSDictionary+MoonSqlDescription.h
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/23.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MoonSqlDescription)

/**
 translate dictionary into a string that can be use to create insert sql

 @return compent of insert sql string
 */
-(NSMutableString *)insertDescription;


/**
 translate dictionary into a string that can be use to create update string

 @return compent of update sql string
 */
-(NSMutableString *)updateDescription;

@end
