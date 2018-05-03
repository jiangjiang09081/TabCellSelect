//
//  ViewController.m
//  TabCellSelect
//
//  Created by Mac on 2018/5/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "CheckTableViewCell.h"
#define mainWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *dataSources;
@property (nonatomic, strong)NSArray *sections;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic) NSInteger totalNum;

@property (nonatomic, strong)NSMutableArray *selectSectionArray;
@property (nonatomic, strong)NSMutableArray *selectCellArray;
@property (nonatomic, strong)NSMutableArray *sectionHeadeViewArray;

//全选
@property (nonatomic, strong)UIButton *checkButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    [self initSectionHeaderView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addSubView{
    
    _selectCellArray = [NSMutableArray arrayWithCapacity:4];
    _selectSectionArray = [NSMutableArray arrayWithCapacity:4];
    _sectionHeadeViewArray = [NSMutableArray arrayWithCapacity:4];
    _sections = @[@"1", @"2", @"3", @"4"];
    _dataSources = @[@[@"一", @"二", @"三", @"四"],
                     @[@"你", @"我", @"他"],
                     @[@"笑眯眯", @"哈哈", @"你好"],
                     @[@"hello", @"nihao", @"haha"]];
    NSInteger n = 0;
    for (int i = 0; i < _dataSources.count; i++) {
        for (int j = 0; j < [_dataSources[i] count]; j++) {
            n++;
        }
    }
    _totalNum = n;
    
    //全选按钮
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkButton.frame = CGRectMake(0, 10, 74, 40);
    [_checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_checkButton];
    
    //编辑按钮
    
    
    UIImageView *checkImage = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 20, 20)];
    checkImage.image = [UIImage imageNamed:@"Unselected"];
    checkImage.highlightedImage = [UIImage imageNamed:@"Selected"];
    checkImage.tag = 1001;
    [_checkButton addSubview:checkImage];
    
    UILabel *textlab = [[UILabel alloc] initWithFrame:CGRectMake(34, 10, 40, 20)];
    textlab.text = @"全选";
    textlab.font = [UIFont systemFontOfSize:14];
    textlab.backgroundColor = [UIColor clearColor];
    textlab.textColor = [UIColor grayColor];
    [_checkButton addSubview:textlab];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, mainWidth, mainHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.sectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}

//初始化sectionHeaderView 如果_sectionHeaderViewArr小于_sectionArr少几个初始化几个
//初始化headerView
- (void)initSectionHeaderView{
    
    if ([_sectionHeadeViewArray count] < [_sections count]) {
        
        NSInteger distance = [_sections count] - [_sectionHeadeViewArray count];
        
        for (int i = 0; i < distance; i++) {
            
            UIButton *headView = [UIButton buttonWithType:UIButtonTypeCustom];
            headView.backgroundColor = [UIColor clearColor];
            headView.frame = CGRectMake(0, 0, mainWidth, 40);
            headView.tag = 0;
            
            //headView上的checkBtn
            UIButton *checkbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
            checkbutton.backgroundColor = [UIColor clearColor];
            
            [checkbutton addTarget:self action:@selector(checkSection:) forControlEvents:UIControlEventTouchUpInside];
            checkbutton.tag = 100;
            [checkbutton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
            [checkbutton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
            [headView addSubview:checkbutton];
            
            //标题
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 20)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 101;
            [headView addSubview:label];
            
            [_sectionHeadeViewArray addObject:headView];
        }
        
    }
    
    
}
- (UIView *)getSectionHeaderView{
    
    UIView *headerView;
    for (UIView *view in _sectionHeadeViewArray) {
        if (!view.superview) {
            headerView = view;
            break;
        }
    }
    
    return headerView;
}

//全选按钮
- (void)checkAction:(UIButton *)button{
    [_selectCellArray removeAllObjects];
    
    UIImageView *checkImage = (UIImageView *)[button viewWithTag:1001];
    checkImage.highlighted = !checkImage.highlighted;
    for (int i = 0; i < [_dataSources count]; i++) {
        if (checkImage.highlighted) {
            
            NSArray *arr = [_dataSources objectAtIndex:i];
            for (int j = 0; j < [arr count]; j++) {
                
                NSString *str = [[_dataSources objectAtIndex:i] objectAtIndex:j];
                NSString *space = [NSString stringWithFormat:@"%d-%d", i, j];
                NSDictionary *dic = @{@"space":space, @"good":str};
                [_selectCellArray addObject:dic];
            }
            [_selectSectionArray addObject:[NSNumber numberWithInt:i]];
            
        }else{
            
            [_selectSectionArray removeAllObjects];
            [_selectCellArray removeAllObjects];
        }
        
    }
    [_tableView reloadData];
    
}



//更新全选按钮的状态
- (void)updateAllCheckBtnStatus{
    
    if ([_selectCellArray count] < _totalNum) {
        
        [(UIImageView *)[_checkButton viewWithTag:1001] setHighlighted:NO];
        
    }else{
        
        [(UIImageView *)[_checkButton viewWithTag:1001] setHighlighted:YES];
        for (int i = 0; i < _sections.count; i++) {
            
            [_selectSectionArray addObject:[NSNumber numberWithInt:(int) i]];
        }
    }
    [_tableView reloadData];
}

//更新组的状态
- (void)updataSectionCheckStatus{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    for (NSDictionary *dic in _selectCellArray) {
        
        NSString *space = [dic objectForKey:@"space"];
        NSArray *sapceArr = [space componentsSeparatedByString:@"-"];
        
        if ([sapceArr count] != 2) {
            continue;
            
        }else{
            
            NSInteger section = [[sapceArr objectAtIndex:0] integerValue];
            NSInteger row = [[sapceArr objectAtIndex:1] integerValue];
            
            for (NSInteger n = 0; n <= section; n++) {
                
                NSMutableArray *cellarray = [NSMutableArray arrayWithCapacity:10];
                
                if (array.count < _sections.count) {
                    
                    [array addObject:cellarray];
                }
            }
            
            [array[section] addObject:[NSNumber numberWithInteger:row]];
        }
        
    }
    for (int i = 0; i < array.count; i++) {
        
        if ([array[i] count] < [_dataSources[i] count]) {
            
            if ([_selectSectionArray containsObject:[NSNumber numberWithInt:(int)i]]) {
                
                [_selectSectionArray removeObject:[NSNumber numberWithInt:(int)i]];
                
            }else{
                continue;
            }
        }else{
            
            [_selectSectionArray addObject:[NSNumber numberWithInt:(int)i]];
        }
    }
    [_tableView reloadData];
}

//头视图点击事件 选中分类
- (void)checkSection:(UIButton *)button{
    
    NSInteger section = button.superview.tag - 1000;
    button.selected = !button.selected;
    NSInteger j = 0;
    for (NSInteger i = 0; i < [_selectCellArray count]; i++) {
        
        NSDictionary *dic = [_selectCellArray objectAtIndex:j];
        NSString *space = [dic objectForKey:@"space"];
        NSInteger spaceSection = [[[space componentsSeparatedByString:@"-"] objectAtIndex:0] integerValue];
        
        if (section == spaceSection) {
            [_selectCellArray removeObject:dic];
            i--;
            
        }else{
            
            j++;
        }
    }
    
    
    if (button.selected) {
        
        if (![_selectSectionArray containsObject:[NSNumber numberWithInt:(int)section]]) {
            NSArray *arr = [_dataSources objectAtIndex:section];
            for (NSInteger i = 0; i < [arr count]; i++) {
                NSString *str = [arr objectAtIndex:i];
                NSString *space = [NSString stringWithFormat:@"%ld-%ld",(long)section,
                                   (long)i];
                NSDictionary *dic = @{@"space":space, @"good":str};
                [_selectCellArray addObject:dic];
            }
            [_selectSectionArray addObject:[NSNumber numberWithInt:(int)section]];
        }
    }else{
        
        if ([_selectSectionArray containsObject:[NSNumber numberWithInt:(int)section]]) {
            
            [_selectSectionArray removeObject:[NSNumber numberWithInt:(int)section]];
        }
    }
    [self updateAllCheckBtnStatus];
    [_tableView reloadData];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = _dataSources[section];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    CheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[CheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    BOOL isSelect = NO;
    //对选取的含有选中cell的数组进行处理
    for (NSDictionary *dic in _selectCellArray) {
        NSString *space = [dic objectForKey:@"space"];
        NSArray *sapceArr = [space componentsSeparatedByString:@"-"];
        if ([sapceArr count] != 2) {
            continue;
        }else{
            
            NSInteger section = [[sapceArr objectAtIndex:0] integerValue];
            NSInteger row = [[sapceArr objectAtIndex:1] integerValue];
            if (section == indexPath.section && row == indexPath.row) {
                isSelect = YES;
                break;
            }
        }
    }
    cell.isChecked = isSelect;
    
    cell.label.text = _dataSources[indexPath.section][indexPath.row];
    
    cell.selectBlock = ^(BOOL selected){
        
        if (selected) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
            NSString *space = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section, (long)indexPath.row];
            [dic setObject:space forKey:@"space"];
            [self.selectCellArray addObject:dic];
            
        }else{
            
            NSString *space = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section, (long)indexPath.row];
            for (NSDictionary *dic in self.selectCellArray) {
                if ([space isEqualToString:[dic objectForKey:@"space"]]) {
                    [self.selectCellArray removeObject:dic];
                    break;
                }
            }
        }
        [self updataSectionCheckStatus];
        [self updateAllCheckBtnStatus];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BOOL isSelect = [_selectSectionArray containsObject:[NSNumber numberWithInt:(int)section]];
    
    UIView *headView = [self getSectionHeaderView];
    headView.tag = 1000 + section;
    
    NSString *str = [_sections objectAtIndex:section];
    [(UIButton *)[headView viewWithTag:100] setSelected:isSelect];
    [(UILabel *)[headView viewWithTag:101] setText:str];
    
    return headView;
}

//设置组的视图必须设组高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

