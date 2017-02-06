//
//  MoonSqlMakerProtocol.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/2/6.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MoonSqlMakerProtocol <NSObject>

-(NSArray<NSString *> *)generateSqls;

@end
