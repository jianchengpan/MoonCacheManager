//
//  MoonSqlDeleteMaker.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonSqlDeleteMaker.h"

@implementation MoonSqlDeleteMaker

#pragma mark - properties

-(NSMutableString *)deleteCondition{
    if(!_deleteCondition){
        _deleteCondition = [NSMutableString string];
    }
    return _deleteCondition;
}

#pragma mark - delete 
-(MoonSqlDeleteMaker *(^)(id))deleteObj{
    return ^id(id obj){
        self.operatingObj = obj;
        self.operatingClass = nil;
        return self;
    };
}

-(MoonSqlDeleteMaker *(^)(__unsafe_unretained Class))deleteClass{
    return ^id(Class cls){
        self.operatingClass = cls;
        self.operatingObj = nil;
        return self;
    };
}

-(MoonSqlDeleteMaker *(^)(NSString *))where{
    return ^id(NSString *condition){
        if(self.deleteCondition.length)
            [self.deleteCondition appendString:@"and "];
        [self.deleteCondition appendFormat:@"%@ ",condition];
        return self;
    };
}

#pragma mark - sqlMaker protocol

-(NSArray<NSString *> *)generateSqls{
    NSMutableArray *sqls = [NSMutableArray array];
    if(self.operatingObj || self.operatingClass){
        if(self.operatingObj){
            NSString *indexKey = [[self.operatingObj class] indexKey];
            id indexValue = [self.operatingObj valueForKey:indexKey];
            if(indexValue){
                self.where([NSString stringWithFormat:@"%@='%@'",indexKey,indexValue]);
            }else{
                NSLog(@"%@-->indexKey:%@ can't be nil",NSStringFromClass([self.operatingObj class]),[[self.operatingObj class] indexKey]);
                goto end;
            }
        }
        NSMutableString *deleteSql = [NSMutableString stringWithFormat:@"delete from %@ ",NSStringFromClass(self.operatingClass ? self.operatingClass : [self.operatingObj class])];
        if(_deleteCondition){
            [deleteSql appendFormat:@"where %@ ",_deleteCondition];
        }
        [sqls addObject:deleteSql];
    }
end:
    return sqls;
}

-(NSArray<Class> *)operateTablesRelatedClass{
    NSMutableArray *classes = [NSMutableArray array];
    if(self.operatingClass)
        [classes addObject:self.operatingClass];
    if(self.operatingObj)
        [classes addObject:[self.operatingObj class]];
    
    return classes;
}
@end
