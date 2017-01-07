//
//  movicViewModel.m
//  MVVC－缓存
//
//  Created by wumiao on 17/1/4.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import "movicViewModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation movicViewModel

- (void)getData:(NSString *)urlString{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSArray *dataArray = dic[@"subjects"];
        NSLog(@"%@",dic[@"subjects"][0]);
        NSMutableArray *data = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArray) {
            movicModel *model = [[movicModel alloc] init];
            model.year = dataDic[@"year"];
            model.title = dataDic[@"title"];
            model.icon = dataDic[@"images"][@"large"];
            //model.next = dataDic[@"directors"][@"alt"];
            [data addObject:model];
        }
        self.returnValueBlock(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.errorValueBlock(error);
    }];
}

- (void)movicDetail:(movicModel *)model WithViewController:(UIViewController *)superController{
    
}

@end
