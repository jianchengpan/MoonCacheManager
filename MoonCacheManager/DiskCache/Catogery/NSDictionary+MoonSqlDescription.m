//
//  NSDictionary+MoonSqlDescription.m
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/23.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "NSDictionary+MoonSqlDescription.h"

@implementation NSDictionary (MoonSqlDescription)

-(NSMutableString *)insertDescription{
   
    
    NSMutableString *keysString = [NSMutableString stringWithFormat:@"("];
    NSMutableString *valuesString = [NSMutableString stringWithFormat:@"("];
    for (NSString *key in self.allKeys) {
        [keysString appendFormat:@"%@,",key];
        [valuesString appendFormat:@"'%@',",[self objectForKey:key]];
    }
    
    if(keysString.length > 2){
        [keysString replaceCharactersInRange:NSMakeRange(keysString.length -1 , 1) withString:@""];
        [valuesString replaceCharactersInRange:NSMakeRange(valuesString.length -1 , 1) withString:@""];
    }
    
    [keysString appendString:@")"];
    [valuesString appendString:@")"];
    
    NSMutableString *insertString = [NSMutableString stringWithFormat:@"%@ values %@",keysString,valuesString];
    
    return insertString;
}

-(NSMutableString *)updateDescription{
    NSMutableString *updateString = [NSMutableString string];
    
    for (NSString *key in self.allKeys) {
        [updateString appendFormat:@"%@='%@',",key,[self objectForKey:key]];
    }
    
    if(updateString.length)
        [updateString replaceCharactersInRange:NSMakeRange(updateString.length - 1, 1) withString:@""];
    
    return updateString;
}

@end
