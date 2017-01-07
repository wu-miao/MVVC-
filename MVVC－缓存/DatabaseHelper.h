//
//  DatabaseHelper.h
//  MVVC－缓存
//
//  Created by wumiao on 17/1/5.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "movicModel.h"
@interface DatabaseHelper : NSObject
@property (nonatomic, strong)FMDatabase *db;
/*
 创建数据库与表
 */
- (BOOL)cretaeDatabase;
/*
 添加一部电影信息
 */
- (BOOL)insertMovic:(movicModel *)movic;
/*
 查询所有电影信息
 */
- (NSArray *)getAllMovic;
/*
 删除所有电影
 */
- (BOOL)deleteAllMovic;
@end
