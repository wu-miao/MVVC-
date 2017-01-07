//
//  TableViewCell.m
//  MVVC－缓存
//
//  Created by wumiao on 17/1/4.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(movicModel *)model{
    _model = model;
    [self.headImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.icon]]]];
    self.titleLabel.text = _model.title;
    self.detailLabel.text = _model.year;
}
@end
