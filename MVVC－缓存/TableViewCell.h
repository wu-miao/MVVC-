//
//  TableViewCell.h
//  MVVC－缓存
//
//  Created by wumiao on 17/1/4.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "movicModel.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) movicModel *model;
@end
