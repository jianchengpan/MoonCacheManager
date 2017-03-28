//
//  MoonTableRelationType.h
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#ifndef MoonTableRelationType_h
#define MoonTableRelationType_h

typedef NS_ENUM(NSUInteger, MoonTableRelationType) {
    MoonTableRelationTypeUnknown    = 0,
    MoonTableRelationTypeHasOne     = 1,
    MoonTableRelationTypeHasMany    = 2,
    MoonTableRelationTypeBelongsTo  = 3,
    MoonTableRelationTypeManyToMany = 4,
};

#endif /* MoonTableRelationType_h */
