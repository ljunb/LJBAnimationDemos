//
//  LJBLoopLoadingView.h
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/21.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBLoopLoadingView : UIView

/**
 *  线条宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor * lineColor;

/**
 *  显示加载动画
 */
- (void)show;

/**
 *  隐藏加载动画
 */
- (void)dismiss;

@end
