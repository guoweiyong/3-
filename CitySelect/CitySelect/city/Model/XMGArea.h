//
//  XMGArea.h
//  SanFangLianKong
//
//  Created by x on 2017/12/15.
//  Copyright © 2017年 zhaidanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGArea : NSObject

/** 区域的名字 */
@property (nonatomic, strong) NSString *name;

/** 区域的编号 */
@property (nonatomic, strong) NSString *zipcode;


/**
 得到市下面的所有区

 @return <#return value description#>
 */
+ (NSArray *)getCityInAllAreas:(NSArray *)areas;
@end
