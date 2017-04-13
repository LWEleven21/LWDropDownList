# LWDropDownList
简单易用的下拉列表


使用方法：#import "LWDropListHelper.h"

    _listHelper = [[LWDropListHelper alloc]init]; 
    _listHelper.frame = CGRectMake(30, 50, KScreenWidth - 60, 30);
    _listHelper.backgroundColor = [UIColor clearColor];
    _listHelper.array = array;
    _listHelper.rowHeight = 40;
    _listHelper.delegate = self;
    _listHelper.titleAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_listHelper];
