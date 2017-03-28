//
//  ClubModel.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/3/28.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClubModel : NSObject<MoonDiskCacheProtocol>

@property (nonatomic, copy) NSString *clubId;
@property (nonatomic, copy) NSString *clubName;

@end
