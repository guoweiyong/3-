//
//  XMGProvince.m
//  SanFangLianKong
//
//  Created by x on 2017/12/15.
//  Copyright © 2017年 zhaidanhui. All rights reserved.
//

#import "XMGProvince.h"
#import "XMGCity.h"

static NSMutableArray *_provinces;

@implementation XMGProvince
+ (NSArray *)getAllProvinces {
    if (_provinces != nil) {
        return _provinces;
    }else {
        _provinces = [NSMutableArray array];
        //1.加载路径
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"province_data.json" ofType:nil];
        NSDictionary *provinceDic = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:jsonPath] options:0 error:nil];
        NSArray *provinces = [provinceDic objectForKey:@"province"];
        for (NSDictionary *dic in provinces) {
            [_provinces addObject:[[self alloc] initWithDic:dic]];
        }
        return _provinces;
    }
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];

    //判断是不是城市
    if ([key isEqualToString:@"city"]) {
        //解析省下面的城市
        self.citys = [XMGCity getProvinceInAllCitys:value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    NSArray *keys = @[@"name",@"citys"];
    
    return [NSString stringWithFormat:@"%@",[self dictionaryWithValuesForKeys:keys]];
}
@end
