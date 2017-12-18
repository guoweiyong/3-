//
//  CitySelectView.h
//  CitySelect
//
//  Created by x on 2017/12/18.
//  Copyright © 2017年 HLB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finish)(NSString *result);

@interface CitySelectView : UIView

/** 确定block */
@property (nonatomic,copy) finish finishCallBack;

/** 缓存的地址选择 */
@property (nonatomic, strong) NSString *cachesResultStr;
@end
