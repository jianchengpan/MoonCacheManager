//
//  MoonDiskCachePropertyInfo.m
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/16.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "MoonDiskCachePropertyInfo.h"

@implementation MoonDiskCachePropertyInfo

-(instancetype)initWithName:(NSString *)name andEncodedType:(NSString *)encodedType{
    if(self = [super init]){
        self.propertyName = name;
        self.encodedType = encodedType;
        self.isValidProperties = YES;
    }
    return self;
}

-(NSString *)sqlType{
    NSString *type = nil;
    
    if([self.encodedType hasPrefix:@"@"] || [self.encodedType hasPrefix:@"*"]){// oc object Type and c string
        type = @"text";
    }else if ([self.encodedType isEqualToString:@"?"]){//unknow type, ignore
        
    }else {//number
        type = @"integer";
    }
    return type;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@:%@--->%@ %d",self.propertyName,self.encodedType,self.sqlType,self.isValidProperties];
}

@end
