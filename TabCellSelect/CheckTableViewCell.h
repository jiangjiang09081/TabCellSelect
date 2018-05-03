//
//  CheckTableViewCell.h
//  仿购物车
//
//  Created by jiang on 16/6/15.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckTableViewCell : UITableViewCell

@property (nonatomic) BOOL isChecked;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) void (^selectBlock)(BOOL isSelect);

@end
