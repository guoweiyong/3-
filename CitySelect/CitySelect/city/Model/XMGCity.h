//
//  XMGCity.h
//  SanFangLianKong
//
//  Created by x on 2017/12/15.
//  Copyright © 2017年 zhaidanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGCity : NSObject

/** 市的名字 */
@property (nonatomic, strong) NSString *name;

/** 市下面的区域 */
@property (nonatomic, strong) NSArray *areas;


/**
 得到省下面的所有市

 @return <#return value description#>
 */
+ (NSArray *)getProvinceInAllCitys:(NSArray *)citys;
@end
