//
//  movicViewModel.h
//  MVVC－缓存
//
//  Created by wumiao on 17/1/4.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "movicModel.h"
@interface movicViewModel : NSObject
@property (nonatomic, strong) void (^returnValueBlock)(id returnBlock);
@property (nonatomic, strong) void (^errorValueBlock)(id errorBlock);
//获取数据
- (void)getData:(NSString *)urlString;
//跳转详情界面
- (void)movicDetail: (movicModel *)model WithViewController: (UIViewController *)superController;

@end
