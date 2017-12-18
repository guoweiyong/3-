//
//  XMGProvince.h
//  SanFangLianKong
//
//  Created by x on 2017/12/15.
//  Copyright © 2017年 zhaidanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGProvince : NSObject

/** 省的名字 */
@property (nonatomic, strong) NSString *name;

/** 省下面的市 */
@property (nonatomic, strong) NSArray *citys;


/**
 得到所有的市

 @return <#return value description#>
 */
+ (NSArray *)getAllProvinces;
@end
