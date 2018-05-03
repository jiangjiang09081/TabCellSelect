//
//  CheckTableViewCell.m
//  仿购物车
//
//  Created by jiang on 16/6/15.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "CheckTableViewCell.h"

@implementation CheckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubView];
    }
    return self;
}

- (void)addSubView{

    _label = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:14];
    [self addSubview:_label];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
    [_button addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}

- (void)check:(UIButton *)button{
    
    button.selected = !button.selected;
    self.selectBlock(button.selected);
}

- (void)setIsChecked:(BOOL)isChecked{

    _isChecked = isChecked;
    _button.selected = _isChecked;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
