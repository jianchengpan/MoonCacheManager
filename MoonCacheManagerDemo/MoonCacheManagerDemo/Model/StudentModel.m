//
//  StudentModel.m
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/14.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "StudentModel.h"

@implementation StudentModel

+(NSString *)indexKey{
    return @"sID";
}

+(NSArray<NSString *> *)ignoreProperties{
    return @[@"ignoreProperties"];
}

@end
