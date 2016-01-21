//
//  LJBLoopPieLoadingView.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/21.
//  Copyright © 2016年 ljunb. All rights reserved.
//  管道循环加载动画

#import "LJBLoopPieLoadingView.h"

static CGFloat const kDefaultLineWidth = 4; // 默认宽度

@interface LJBLoopPieLoadingView ()
{
    UIBezierPath * _backgroundPath;     // 背景view
    CAShapeLayer * _backgroundLayer;
    
    UIBezierPath * _loopPath;           // 循环view
    CAShapeLayer * _loopLayer;
}

@end

@implementation LJBLoopPieLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 背景
        _backgroundLayer             = [CAShapeLayer layer];
        _backgroundLayer.frame       = self.bounds;
        _backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _backgroundLayer.fillColor   = [UIColor clearColor].CGColor;
        _backgroundLayer.lineWidth    = kDefaultLineWidth;
        [self.layer addSublayer:_backgroundLayer];
        
        // 循环view
        _loopLayer             = [CAShapeLayer layer];
        _loopLayer.fillColor   = [UIColor clearColor].CGColor;
        _loopLayer.strokeColor = [UIColor redColor].CGColor;
        _loopLayer.lineWidth   = kDefaultLineWidth;
        [self.layer addSublayer:_loopLayer];
    }
    return self;
}

#pragma mark - 设置线条宽度
- (void)setLineWidth:(CGFloat)lineWidth {
    
    _lineWidth = lineWidth;
    
    _backgroundLayer.lineWidth = lineWidth;
    _loopLayer.lineWidth       = lineWidth;
}

#pragma mark - 设置线条颜色
- (void)setLineColor:(UIColor *)lineColor {
    
    _lineColor = lineColor;
    
    _loopLayer.strokeColor = lineColor.CGColor;
}

#pragma mark - 显示动画
- (void)show {
    
    // 背景
    _backgroundPath       = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _backgroundLayer.path = _backgroundPath.CGPath;
    
    // loop view
    _loopPath       = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _loopLayer.lineDashPattern = @[@3, @3];
    _loopLayer.path = _loopPath.CGPath;
    
    // 起始点动画
    CABasicAnimation * startAnimation = [CABasicAnimation animation];
    startAnimation.keyPath            = @"strokeStart";
    startAnimation.fromValue          = @(-0.5);
    startAnimation.toValue            = @1;
    
    // 结束点动画
    CABasicAnimation * endAnimation = [CABasicAnimation animation];
    endAnimation.keyPath            = @"strokeEnd";
    endAnimation.fromValue          = @(0);
    endAnimation.toValue            = @1;
    
    // 动画组
    CAAnimationGroup * group  = [CAAnimationGroup animation];
    group.animations          =  @[startAnimation, endAnimation];
    group.duration            = 1;
    group.repeatCount         = MAXFLOAT;
    group.removedOnCompletion = NO;
    group.fillMode            = kCAFillModeForwards;
    
    [_loopLayer addAnimation:group forKey:nil];
}

#pragma mark - 隐藏动画
- (void)dismiss {

    [self removeFromSuperview];
}


@end
