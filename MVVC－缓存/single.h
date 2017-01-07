//
//  single.h
//  MVVC－缓存
//
//  Created by wumiao on 17/1/5.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseHelper.h"
@interface single : NSObject

@property (nonatomic, strong) DatabaseHelper *databaseHelper;

+ (single *)shareInstance;

@end
