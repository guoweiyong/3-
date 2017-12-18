//
//  XMGArea.m
//  SanFangLianKong
//
//  Created by x on 2017/12/15.
//  Copyright © 2017年 zhaidanhui. All rights reserved.
//

#import "XMGArea.h"

@implementation XMGArea

+ (NSArray *)getCityInAllAreas:(NSArray *)areas {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in areas) {
        [array addObject:[[XMGArea alloc] initWithDic:dic]];
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    NSArray *keys = @[@"name",@"zipcode"];
    return [NSString stringWithFormat:@"%@",[self dictionaryWithValuesForKeys:keys]];
}
@end


