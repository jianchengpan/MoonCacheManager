//
//  MoonDiskCacheTableCheckInfo.m
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/21.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonDiskCacheTableCheckInfo.h"

@implementation MoonDiskCacheTableCheckInfo

-(NSString *)description{
    return [NSString stringWithFormat:@"exist:%d correctedTable:%d checkRelation:%d",self.isTableExist,self.isCorrectedTable,self.isCheckRelationInfo];
}

@end
