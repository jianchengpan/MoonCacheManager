//
//  MoonRelationModel.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/3/28.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonTableRelationType.h"


/**
 if key not exist in disk,it will be create.if key is null,it may be generated automatically user format 'Class_Index'
 */
@interface MoonRelationModel : NSObject

@property (nonnull, nonatomic, strong) Class relationClass;
@property (nullable, nonatomic, copy) NSString *relationKey;

@property (nonatomic, assign) MoonTableRelationType relationType;

@property (nonnull, nonatomic, strong) Class foreignRelationClass;
@property (nullable, nonatomic, copy) NSString *foreignRelationKey;

@end
