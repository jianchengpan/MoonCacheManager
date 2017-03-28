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

/** default is YES , just readOnly proeprties , ignore properties(define in MoonDiskCacheProtocol) and addtionalProperty is NO */
@property (nonatomic, assign) BOOL isValidProperties;

/** the property create by system to construct relation should be addtionan property*/
@property (nonatomic, assign) BOOL isAddtionalProperty;

@property (nonatomic ,readonly) NSString *sqlType;

-(instancetype)initWithName:(NSString *)name andEncodedType:(NSString *)encodedType;

@end
