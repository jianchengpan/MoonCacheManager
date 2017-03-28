//
//  MoonSqlMaker.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/3/28.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonSqlMakerProtocol.h"

@interface MoonSqlMaker : NSObject<MoonSqlMakerProtocol>

#pragma mark - tool

-(instancetype)and;

-(instancetype)with;

@end
