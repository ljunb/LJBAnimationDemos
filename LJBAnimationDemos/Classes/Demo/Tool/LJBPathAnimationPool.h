//
//  LJBPathAnimationPool.h
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/3/10.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LJBPathAnimationPool : NSObject

/**
 *  中心按钮旋转动画
 *
 *  @param fromValue 初始角度
 *  @param toValue   结束角度
 *  @param view      中心按钮
 */
+ (void)springRotationFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view;

/**
 *  仿Path展开动画
 *
 *  @param fromValue 初始位置
 *  @param toValue   结束位置
 *  @param view      执行动画的UIView
 */
+ (void)bloomItemsFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view;

/**
 *  仿Path折叠动画
 *
 *  @param fromValue 初始位置
 *  @param toValue   结束位置
 *  @param view      执行动画的UIView
 */
+ (void)foldItemsFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view;

@end
