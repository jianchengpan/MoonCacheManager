//
//  MoonDiskCacheTableCheckInfo.h
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/21.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoonDiskCacheTableCheckInfo : NSObject

@property (nonatomic, assign) BOOL isTableExist;

@property (nonatomic, assign) BOOL isCorrectedTable;

@property (nonatomic, assign) BOOL isCheckRelationInfo;

@end
