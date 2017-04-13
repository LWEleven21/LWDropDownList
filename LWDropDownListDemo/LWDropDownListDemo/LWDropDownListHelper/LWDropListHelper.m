//
//  LWDropListHelper.m
//  LWDropDownList
//
//  Created by LW on 2017/4/13.
//  Copyright © 2017年 LW. All rights reserved.
//

/**
 *  主屏的宽
 */
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "LWDropListHelper.h"
@interface LWDropListHelper ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat x ;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    BOOL isShow;
    int flag ;

}
@property (nonatomic, strong)UIButton * titleButton;  //标题按钮
@property(nonatomic,strong)UITableView *tableView; //列表
@property(nonatomic,strong)UIImageView *arrow;  //显示已经选中的标记
@property(nonatomic,assign)NSInteger index;    //记录选中行
@property (nonatomic, strong)UIImageView *rightImageView; //下拉箭头
@property (nonatomic, strong)UILabel *leftLable;  //按钮标题
@property(nonatomic,strong)UIView *bgView; //蒙版

@end

@implementation LWDropListHelper

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        flag = 1;
    }
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    if (flag) {
        x = self.frame.origin.x;
        y = self.frame.origin.y;
        width = self.frame.size.width;
        height = self.frame.size.height;
        flag = 0;
        [self addSubview:self.titleButton];
    }
}
#pragma mark - 加载列表
-(UITableView *)tableView {
    if (!_tableView) {
        if (y + height > KScreenHeight - _rowHeight *2) {
            [UIView animateWithDuration:0.25f animations:^{
                _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, 0) style:UITableViewStylePlain];            }];

        }else {
            [UIView animateWithDuration:0.25f animations:^{
                _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, width, 0) style:UITableViewStylePlain];
            }];

        }
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark - UITableViewDelegateAndUITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cellID%ld",(long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.index) {
        if (self.index == indexPath.row)
        {
            [cell addSubview:self.arrow];
        }
    }
    return cell;
}
#pragma mark ----------------UITableView  表的选中方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenList];
    self.index = indexPath.row;
    if (self.delegate && [self.delegate respondsToSelector:@selector(LWDrioDownList:didSelectAtIndex:)])
    {
        [self.delegate LWDrioDownList:self didSelectAtIndex:indexPath.row];
    }
    _leftLable.text = self.array[indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat DefaultRowHeight = 42;
    CGFloat  rowHeight = 0;
    if (self.rowHeight) {
        rowHeight = self.rowHeight;
    }else {
        rowHeight = DefaultRowHeight;
    }
    return rowHeight;
}
#pragma mark - 加载数据源数组
-(NSArray *)array
{
    if (!_array)
    {
        _array = [[NSArray alloc]init];
    }
    return _array;
}
#pragma mark - 记载标题按钮
-(UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.frame = CGRectMake(0, 0,width, height);
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"open"];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightImageView.frame = CGRectMake(_titleButton.frame.size.width - 15*1.1 - 5,(_titleButton.frame.size.height -9*1.1)/2.,15*1.1, 9*1.1);
        [_titleButton addSubview:_rightImageView];
        
        _leftLable = [[UILabel alloc] init];
        _leftLable.textColor =[UIColor whiteColor];
        _leftLable.font = [UIFont systemFontOfSize:16];
        _leftLable.textAlignment = NSTextAlignmentCenter;
        _leftLable.frame = CGRectMake(10, (_titleButton.frame.size.height -20)/2.,self.frame.size.width - 15*1.1 - 20 , 20);
        [_titleButton addSubview:_leftLable];
        
        NSString * DefaultTitle = @"请选择";
        NSString * titleString = self.title == nil ? DefaultTitle:self.title;
        _leftLable.text = titleString;
        UIColor * DefaultTitleColor = [UIColor whiteColor];
        UIColor * titleColor = self.titleColor == nil ? DefaultTitleColor:self.titleColor;
        _leftLable.textColor = titleColor;
        
        UIColor * DefaultBackgroundColor = [UIColor colorWithRed:50/255.0 green:85/255.0 blue:135/255.0 alpha:1];
        UIColor * buttonColor = self.buttonColor == nil ? DefaultBackgroundColor:self.buttonColor;
        _titleButton.backgroundColor = buttonColor;
        
        if (self.titleAlignment){
            _leftLable.textAlignment = self.titleAlignment;
        }else {
            //没有设置属性 显示默认属性
            _leftLable.textAlignment = NSTextAlignmentLeft;
        }
        [_titleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _titleButton;
}
#pragma mark - 按钮点击方法
-(void)buttonClick:(UIButton *)btn
{
    if (isShow) {
        [self hiddenList];

        [UIView animateWithDuration:0.3f animations:^{
            _rightImageView.transform = CGAffineTransformRotate(_rightImageView.transform, M_PI);
        }];
    }else {
        [self showList];
        [UIView animateWithDuration:0.3f animations:^{
            _rightImageView.transform = CGAffineTransformRotate(_rightImageView.transform, M_PI);
        }];
    }
}

#pragma mark - 加载标记图标
-(UIImageView *)arrow
{
    if (!_arrow)
    {
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width - 32 * 0.5 - 5, (self.rowHeight - 12)/2, 32 * 0.5, 24 * 0.5)];
        _arrow.image = [UIImage imageNamed:@"choosed"];
    }
    return _arrow;
}
#pragma mark - 显示列表
-(void)showList
{
    [self addSubview:self.tableView];
    isShow = YES;
    [self.tableView reloadData];
    _bgView = [[UIView alloc]initWithFrame:self.superview.frame];
    _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.superview addSubview:_bgView];
    [self.superview bringSubviewToFront:self];
    _bgView.alpha = 1;
    [UIView animateWithDuration:0.25f animations:^{
        //判断是不是距离屏幕下边缘太近
        if (y + height > KScreenHeight - _rowHeight *2) {
          //距离屏幕下边缘太近了 让列表在上方展示
            //列表太长超出屏幕的范围
            if (_rowHeight * _array.count > y) {
                self.frame = CGRectMake(x, _rowHeight * 0.5, width,y+height-_rowHeight * 0.5);
                self.titleButton.frame = CGRectMake(0, self.frame.size.height - height,width,height);
                self.tableView.frame = CGRectMake(0, 0, width, self.frame.size.height - height);
            }else {
                self.frame = CGRectMake(x, y - _rowHeight * _array.count, width, _rowHeight * _array.count + height);
                self.titleButton.frame = CGRectMake(0, _rowHeight * _array.count, width, height);
                self.tableView.frame = CGRectMake(0, 0, width, _rowHeight * _array.count);
            }
        }else {
        //判断列表的高度是不是超过选择按钮以下屏幕
            if ((_rowHeight * _array.count) > KScreenHeight - (y + height)) {
                self.frame = CGRectMake(x, y, width, KScreenHeight - y - _rowHeight *0.5);
                self.titleButton.frame = CGRectMake(0, 0, width, _titleButton.frame.size.height);
                self.tableView.frame = CGRectMake(0, _titleButton.frame.size.height, width, self.frame.size.height - _titleButton.frame.size.height);
            }else {
                self.frame = CGRectMake(x, y, width, height +(_rowHeight * _array.count));
                self.titleButton.frame = CGRectMake(0, 0, width, height);
                self.tableView.frame = CGRectMake(0, height, width, (_rowHeight * _array.count));
            }
        }
    }];

}
#pragma mark - 隐藏列表
-(void)hiddenList
{
    isShow = NO;
    self.bgView.alpha = 0;
    [_bgView removeFromSuperview];
    [UIView animateWithDuration:0.25f animations:^{
        //判断是不是距离屏幕下边缘太近
        if (y + height > KScreenHeight - _rowHeight *2) {
            self.frame = CGRectMake(x, y, width,height);
            self.titleButton.frame = CGRectMake(0, 0,width,height);
            self.tableView.frame = CGRectMake(0, 0, width, 0);
            
        }else {
            self.frame = CGRectMake(x, y, width,height);
            self.titleButton.frame = CGRectMake(0, 0,width,height);
            self.tableView.frame = CGRectMake(0, height, width, 0);
            
        }
    }];

    
}
@end
