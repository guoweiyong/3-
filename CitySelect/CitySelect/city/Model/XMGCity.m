//
//  XMGCity.m
//  SanFangLianKong
//
//  Created by x on 2017/12/15.
//  Copyright © 2017年 zhaidanhui. All rights reserved.
//

#import "XMGCity.h"
#import "XMGArea.h"

@implementation XMGCity

+ (NSArray *)getProvinceInAllCitys:(NSArray *)citys {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in citys) {
        [array addObject:[[XMGCity alloc] initWithDic:dic]];
    }
    return array;
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
    
    //解析市下面的区
    if ([key isEqualToString:@"district"]) {
        self.areas = [XMGArea getCityInAllAreas:value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    NSArray *keys = @[@"name",@"areas"];
    return [NSString stringWithFormat:@"%@",[self dictionaryWithValuesForKeys:keys]];
}
@end
