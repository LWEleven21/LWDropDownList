//
//  LWDropListHelper.h
//  LWDropDownList
//
//  Created by LW on 2017/4/13.
//  Copyright © 2017年 LW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWDropListHelper;
@protocol LWDropDownListHelperDelegate <NSObject>
/**
 *  代理方法 选中之后的回调
 */
-(void)LWDrioDownList:(LWDropListHelper*)list didSelectAtIndex:(NSInteger)index;
@end

@interface LWDropListHelper : UIView

/**
 *  设置代理
 */
@property(nonatomic,assign)id<LWDropDownListHelperDelegate>delegate;

/**
 传入的列表数组  数据源数组
 */
@property (nonatomic, strong)NSArray * array;
/**
 选择框的标题  默认是"请选择" 根据具体需求修改
 */
@property (nonatomic, strong)NSString * title;
/**
 字体的颜色  默认是白色 根据具体需求修改
 */
@property (nonatomic, strong)UIColor * titleColor;
/**
 选择框的颜色 默认 colorWithRed:50/255.0 green:85/255.0 blue:135/255.0  根据具体需求修改
 */
@property (nonatomic, strong)UIColor * buttonColor;
/**
 列表的行高 默认是42 建议最低为30 根据具体需求修改
 */
@property (nonatomic, assign)CGFloat rowHeight;
/**
 标题对齐方式  默认是居左 根据具体需求修改
 */
@property (nonatomic, assign)NSTextAlignment titleAlignment;

@end
