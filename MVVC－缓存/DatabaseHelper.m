//
//  DatabaseHelper.m
//  MVVC－缓存
//
//  Created by wumiao on 17/1/5.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper
@synthesize db;

- (id)init{
    if ([super init]) {
        [self cretaeDatabase];
    }
    return self;
}
- (BOOL)cretaeDatabase{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"testDB.sqlite"];
    NSLog(@"数据库路径为 = %@",dbpath);
    db = [FMDatabase databaseWithPath:dbpath];
    if ([db open]) {
        //电影表
        NSString *movic = @"create table IF NOT EXISTS movic (id integer primary key autoincrement,title text,year text,icon text);";
        if ([db executeUpdate:movic]) {
            NSLog(@"创建数据库和表成功");
        }else{
            NSLog(@"创建失败");
        }
        [db close];
        return YES;
    }
    return NO;
}

- (BOOL)insertMovic:(movicModel *)movic{
    if([db open]){
        FMResultSet *s = [db executeQuery:@"select title from movic where title = ?",movic.title];
        if ([s next]) {
            NSLog(@"电影名不能重复");
            [db close];
            return NO;
        }
        
        BOOL flag = [db executeUpdate:@"insert into movic (title,year,icon) values (?,?,?)",movic.title,movic.year,movic.icon];
        if(flag == NO){
            NSLog(@"插入数据出错");
        }
    }
    [db close];
    return YES;
}
- (NSArray *)getAllMovic{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if([self.db open]){
        FMResultSet *s = [self.db executeQuery:@"select id,title,year,icon from movic"];
        while ([s next]) {
            movicModel *movic = [[movicModel alloc] init];
            movic.title              = [s stringForColumn:@"title"];
            movic.year               = [s stringForColumn:@"year"];
            movic.icon               = [s stringForColumn:@"icon"];
            //movic.next      = [s stringForColumn:@"photoString"];
            [arr addObject:movic];
        }
    }else{
        NSLog(@"数据库打开出错");
        [self.db close];
        return nil;
    }
    [self.db close];
    return (NSArray *)arr;
}
- (BOOL)deleteAllMovic{
    if([db open]){
        BOOL flag = [db executeUpdate:@"delete from movic"];
        if (flag) {
            NSLog(@"数据删除成功");
            [db close];
            return YES;
        }
    }
    NSLog(@"数据删除失败");
    [db close];
    return NO;
}
@end
