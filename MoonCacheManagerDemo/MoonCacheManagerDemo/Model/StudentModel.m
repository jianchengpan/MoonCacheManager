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

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+(NSArray<MoonRelationModel *> *)relationInfo{
    MoonRelationModel *relation1 = [MoonRelationModel new];
    relation1.relationClass = [self class];
    relation1.relationType = MoonTableRelationTypeBelongsTo;
    relation1.foreignRelationClass = NSClassFromString(@"ClassModel");
    
    return @[relation1];
}

@end
