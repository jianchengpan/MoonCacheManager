//
//  MoonSqlSaveMaker.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonSqlSaveMaker.h"
#import "NSDictionary+MoonSqlDescription.h"

@implementation MoonSqlSaveMaker

#pragma mark - sqlMaker protocol

-(NSArray<NSString *> *)generateSqls{
    NSMutableArray *sqls = [NSMutableArray array];
    
    if(self.operatingObj){
        Class operatingClass = [self.operatingObj class];
        NSString *tableName = NSStringFromClass(operatingClass);
        NSString *indexKey = [operatingClass indexKey];
        NSMutableDictionary *dataDic = [self.operatingObj respondsToSelector:@selector(dataMap)] ? [self.operatingObj dataMap] : [MoonDiskCacheUtils translateObjcToDictionary:self.operatingObj];
        
        if(![dataDic objectForKey:indexKey]){
            NSLog(@"indexKey \"%@\" cann't be nil",indexKey);
            goto end;
        }
        
        NSMutableString *insertSql = [NSMutableString stringWithFormat:@"insert or ignore into %@ %@",tableName,dataDic.insertDescription];
        [sqls addObject:insertSql];
        
        NSMutableString *updateSql = [NSMutableString stringWithFormat:@"update %@ set %@ where %@='%@'",tableName,dataDic.updateDescription,indexKey,[dataDic objectForKey:[operatingClass indexKey]]];
        [sqls addObject:updateSql];
    }
end:
    return sqls;
}

-(NSArray<Class> *)operateTablesRelatedClass{
    NSMutableArray *classesArray = [NSMutableArray array];
    
    if(self.operatingObj)
        [classesArray addObject:[self.operatingObj class]];
    
    return classesArray;
}

#pragma mark - operation

-(MoonSqlSaveMaker *(^)(id))save{
    return ^id(id obj){
        self.operatingObj = obj;
        return self;
    };
}

@end
