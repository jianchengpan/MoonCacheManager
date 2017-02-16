//
//  MoonDiskCachePropertyInfo.h
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/16.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoonDiskCachePropertyInfo : NSObject

@property (nonatomic ,copy) NSString *propertyName;
@property (nonatomic ,copy) NSString *encodedType;

/** default is YES , just readOnly proeprties and ignore properties(define in MoonDiskCacheProtocol) is NO */
@property (nonatomic, assign) BOOL isValidProperties;

@property (nonatomic ,readonly) NSString *sqlType;

-(instancetype)initWithName:(NSString *)name andEncodedType:(NSString *)encodedType;

@end
