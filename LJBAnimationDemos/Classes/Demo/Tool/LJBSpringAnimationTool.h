//
//  LJBSpringAnimationTool.h
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/3/8.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  退出动画结束后回调的block
 */
typedef void(^CompletionBlock)();

@interface LJBSpringAnimationTool : NSObject

/**
 *  开始动画
 *
 *  @param fromValue 初始位置
 *  @param toValue   结束位置
 *  @param view      执行动画的UIView
 *  @param delay     延迟时间
 */
+ (void)beginAnimationFromValue:(id)fromValue
                        toValue:(id)toValue
                       withView:(UIView *)view
                          delay:(CFTimeInterval)delay;

/**
 *  退出动画
 *
 *  @param fromValue       初始位置
 *  @param toValue         结束位置
 *  @param view            执行动画的UIView
 *  @param delay           延迟时间
 *  @param completionBlock 动画结束后的回调
 */
+ (void)quitAnimationFromValue:(id)fromValue
                       toValue:(id)toValue
                      withView:(UIView *)view
                         delay:(CFTimeInterval)delay
               completionBlock:(CompletionBlock)completionBlock;

@end
