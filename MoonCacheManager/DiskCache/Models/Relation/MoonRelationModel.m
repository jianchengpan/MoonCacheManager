//
//  MoonRelationModel.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/3/28.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonRelationModel.h"

@implementation MoonRelationModel

-(NSString *)relationKey{
    if(!_relationKey){
        _relationKey = [NSString stringWithFormat:@"%@_%@",NSStringFromClass(self.relationClass),[self.relationClass indexKey]];
    }
    return _relationKey;
}

-(NSString *)foreignRelationKey{
    if(!_foreignRelationKey){
        _foreignRelationKey = [NSString stringWithFormat:@"%@_%@",NSStringFromClass(self.foreignRelationClass),[self.foreignRelationClass indexKey]];
    }
    return _foreignRelationKey;
}

@end

