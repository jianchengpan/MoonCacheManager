//
//  ClassModel.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/3/28.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject<MoonDiskCacheProtocol>

@property (nonatomic, copy) NSString *CId;

@property (nonatomic, copy) NSString *CName;

@end
