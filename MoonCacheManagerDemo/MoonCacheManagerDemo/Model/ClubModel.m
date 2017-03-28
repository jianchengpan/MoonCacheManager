//
//  ClubModel.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/3/28.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "ClubModel.h"

@implementation ClubModel

+(NSString *)indexKey{
    return @"clubId";
}

+(NSArray<MoonRelationModel *> *)relationInfo{
    MoonRelationModel *relation1 = [MoonRelationModel new];
    relation1.relationClass = [self class];
    relation1.relationType = MoonTableRelationTypeManyToMany;
    relation1.foreignRelationClass = NSClassFromString(@"StudentModel");
    return @[relation1];
}

@end
