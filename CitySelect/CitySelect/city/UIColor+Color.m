
//
//  UIColor+Color.m
//  CitySelect
//
//  Created by x on 2017/12/18.
//  Copyright © 2017年 HLB. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:[self randomNum] green:[self randomNum] blue:[self randomNum] alpha:1.0];
}

+ (CGFloat)randomNum {
    return arc4random_uniform(256)/255.0;
}
@end
