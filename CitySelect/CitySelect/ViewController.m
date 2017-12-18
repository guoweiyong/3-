//
//  ViewController.m
//  CitySelect
//
//  Created by x on 2017/12/18.
//  Copyright © 2017年 HLB. All rights reserved.
//

#import "ViewController.h"
#import "CitySelectView.h"

@interface ViewController ()

/** 显示标签 */
@property (nonatomic, weak) UILabel *lable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
    [self.view addSubview:lable];
    self.lable = lable;
}

- (void)setupUI {
    CitySelectView *cityView = [[CitySelectView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    cityView.cachesResultStr = @"贵州省-安顺市-平坝县";
    cityView.finishCallBack = ^(NSString *result) {
        self.lable.text = result;
    };
    [self.view addSubview:cityView];
}

@end
