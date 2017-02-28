//
//  MoonSqlDeleteMaker.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonSqlMakerProtocol.h"

@interface MoonSqlDeleteMaker : NSObject<MoonSqlMakerProtocol>

@property (nonatomic, strong) Class operatingClass;
@property (nonatomic, strong) id operatingObj;

@property (nonatomic, strong) NSMutableString *deleteCondition;

-(MoonSqlDeleteMaker *(^)(id obj))deleteObj;
-(MoonSqlDeleteMaker *(^)(Class cls))deleteClass;

-(MoonSqlDeleteMaker *(^)(NSString *))where;

@end
