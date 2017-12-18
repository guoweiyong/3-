//
//  CitySelectView.m
//  CitySelect
//
//  Created by x on 2017/12/18.
//  Copyright © 2017年 HLB. All rights reserved.
//

#import "CitySelectView.h"
#import "UIColor+Color.h"
#import "XMGProvince.h"
#import "XMGCity.h"
#import "XMGArea.h"

@interface CitySelectView () <UIPickerViewDelegate,UIPickerViewDataSource>

/** UIPickerView选择器 */
@property (nonatomic, strong) UIPickerView *cityPickerView;

/** 所有省市 */
@property (nonatomic, strong) NSArray *provinces;

/** 城市下所有城市 */
@property (nonatomic, strong) NSArray *citys;

/** 城市下面所有市区 */
@property (nonatomic, strong) NSArray *areas;

/** 结果字符串 */
@property (nonatomic, strong) NSString *resultStr;

@end

@implementation CitySelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        
        //初始化选择器
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
        [self setupView];
        [self setupPickerView];
    }
    return self;
}

- (void)setupPickerView {
    self.cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, self.bounds.size.width, self.bounds.size.height-30)];
    self.cityPickerView.delegate = self;
    self.cityPickerView.dataSource = self;
    [self addSubview:self.cityPickerView];
    
    //[self.cityPickerView selectRow:0 inComponent:0 animated:YES];
}

- (void)setupView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    bgView.backgroundColor = [UIColor randomColor];
    
    //1.添加取消按钮
    UIButton *cancelBtu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtu addTarget:self action:@selector(cancelBtuClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelBtu];
    
    //2.添加确定按钮
    UIButton *subBtu = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-100, 0, 100, 30)];
    [subBtu setTitle:@"确定" forState:UIControlStateNormal];
    [subBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [subBtu addTarget:self action:@selector(subBtuClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:subBtu];
    
    [self addSubview:bgView];
    
    //2.初始化数据
    XMGProvince *province = [self.provinces firstObject];
    self.citys = province.citys;
    
    XMGCity *city = [self.citys firstObject];
    self.areas = city.areas;
}
#pragma mark -- UIPickerViewDelegate and UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        
        return self.provinces.count;
    }else if (component == 1) {
        
        return self.citys.count;
    }else {
        
        return self.areas.count;
    }
}

//每个分区宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.bounds.size.width/3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        //1.更换第一分区数据源
        XMGProvince *province = self.provinces[row];
        self.citys = province.citys;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        //2.更换第二分区的数据源
        XMGCity *city = [self.citys firstObject];
        self.areas = city.areas;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else if (component == 1) {
        XMGCity *city = self.citys[row];
        self.areas = city.areas;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
}

//自定义每一行的视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *lable = [[UILabel alloc] init];
    if (component == 0) {
        XMGProvince *province = self.provinces[row];
        lable.text = province.name;
    }else if (component == 1) {
        XMGCity *city = self.citys[row];
        lable.text = city.name;
    }else {
        XMGArea *area = self.areas[row];
        
        lable.text = area.name;
    }
    //lable.backgroundColor = [UIColor randomColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:16];
    
    return lable;
}

#pragma mark -- 按钮点击事件

//取消按钮点击事件
- (void)cancelBtuClick {
    
}

//确定按钮点击事件
- (void)subBtuClick {
    //block必须要被实现 才会存在 要不为nil
    if (self.finishCallBack) {
        NSInteger provinceIndex = [self.cityPickerView selectedRowInComponent:0];
        NSInteger cityIndex = [self.cityPickerView selectedRowInComponent:1];
        NSInteger areaIndex = [self.cityPickerView selectedRowInComponent:2];
        self.resultStr = [NSString stringWithFormat:@"%@-%@-%@",[self.provinces[provinceIndex] name],[self.citys[cityIndex] name],[self.areas[areaIndex] name]];
        self.finishCallBack(self.resultStr);
    }
}

#pragma mark -- 恢复缓存

- (void)setCachesResultStr:(NSString *)cachesResultStr {
    _cachesResultStr = cachesResultStr;
    
    NSArray *strs = [cachesResultStr componentsSeparatedByString:@"-"];
    if (strs.count == 3) {
        NSInteger provinceIndex = 0;
        NSInteger cityIndex = 0;
        NSInteger areaIndex = 0;
        
        //1.恢复缓存
        for (XMGProvince *province in self.provinces) {
            if ([province.name isEqualToString:strs[0]]) {
                provinceIndex = [self.provinces indexOfObject:province];
                
                for (XMGCity *city in province.citys) {
                    if ([city.name isEqualToString:strs[1]]) {
                        self.citys = province.citys;
                        cityIndex = [province.citys indexOfObject:city];
                        
                        for (XMGArea *area in city.areas) {
                            if ([area.name isEqualToString:strs[2]]) {
                                self.areas = city.areas;
                                areaIndex = [city.areas indexOfObject:area];
                                //找到之后结束循环
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        //2.恢复选择
        [self.cityPickerView reloadAllComponents];
        //我们自己调用这个方法,是不会调用点击方法的
        [self.cityPickerView selectRow:provinceIndex inComponent:0 animated:YES];
        [self.cityPickerView selectRow:cityIndex inComponent:1 animated:YES];
        [self.cityPickerView selectRow:areaIndex inComponent:2 animated:YES];
    }
}

#pragma mark -- 懒加载

- (NSArray *)provinces
{
    if (!_provinces) {
        _provinces = [XMGProvince getAllProvinces];
    }
    return _provinces;
}

@end
