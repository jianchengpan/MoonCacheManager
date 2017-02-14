//
//  StudentModel.h
//  MoonCacheManagerDemo
//
//  Created by jiancheng pan on 2017/2/14.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject<MoonDiskCacheProtocol>

@property (nonatomic, copy) NSString *sID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
