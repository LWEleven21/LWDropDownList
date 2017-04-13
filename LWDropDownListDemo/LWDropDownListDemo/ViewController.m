//
//  ViewController.m
//  LWDropDownListDemo
//
//  Created by LW on 2017/4/13.
//  Copyright © 2017年 LW. All rights reserved.
//
/**
 *  屏幕的宽
 */
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width

/**
 *  屏幕的高
 */
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height


#import "ViewController.h"
#import "LWDropListHelper.h"

@interface ViewController ()<LWDropDownListHelperDelegate>
@property (nonatomic, strong)LWDropListHelper * listHelper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    NSArray * array = [NSArray arrayWithObjects:@"😄",@"😀",@"😁",@"🤣",@"😂",@"😆",@"😇",@"😉",@"😊",@"🙃",@"😋",@"😜",nil];
    _listHelper = [[LWDropListHelper alloc]init];
    _listHelper.frame = CGRectMake(30, 50, KScreenWidth - 60, 30);
    _listHelper.backgroundColor = [UIColor clearColor];
    _listHelper.array = array;
    _listHelper.rowHeight = 40;
    _listHelper.delegate = self;
    _listHelper.titleAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_listHelper];
}

-(void)LWDrioDownList:(LWDropListHelper *)list didSelectAtIndex:(NSInteger)index {
    if (list == _listHelper) {
        NSLog(@"点击了第%ld行",(long)index);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
