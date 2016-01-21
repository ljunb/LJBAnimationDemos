//
//  LJBLoopLoadingView.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/21.
//  Copyright © 2016年 ljunb. All rights reserved.
//  循环加载动画

#import "LJBLoopLoadingView.h"

static CGFloat const kBackgroundCirclePadding = 4;
static CGFloat const kDefaultLineWidth        = 4; // 默认宽度

@interface LJBLoopLoadingView ()
{
    UIBezierPath * _backgroundPath;     // 背景view
    CAShapeLayer * _backgroundLayer;
    
    UIBezierPath * _loopPath;           // 循环view
    CAShapeLayer * _loopLayer;
    
    UILabel * _loadingLabel;
}
@end

@implementation LJBLoopLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        // 背景圆
        _backgroundLayer             = [CAShapeLayer layer];
        _backgroundLayer.fillColor   = [UIColor lightGrayColor].CGColor;
        _backgroundLayer.strokeColor = [UIColor whiteColor].CGColor;
        _backgroundLayer.lineWidth   = kDefaultLineWidth;
        [self.layer addSublayer:_backgroundLayer];
        
        // 循环圆
        _loopLayer             = [CAShapeLayer layer];
        _loopLayer.fillColor   = [UIColor clearColor].CGColor;
        _loopLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _loopLayer.lineWidth   = kDefaultLineWidth;
        [self.layer addSublayer:_loopLayer];
        
        // Loading...文本
        _loadingLabel               = [[UILabel alloc] init];
        _loadingLabel.font          = [UIFont systemFontOfSize:14];
        _loadingLabel.textColor     = [UIColor whiteColor];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.text          = @"Loading...";
        [self addSubview:_loadingLabel];
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
    
    CGFloat originX = kBackgroundCirclePadding;
    CGFloat originY = kBackgroundCirclePadding;
    CGFloat width   = self.bounds.size.width - kBackgroundCirclePadding * 2;
    CGFloat height  = self.bounds.size.height - kBackgroundCirclePadding * 2;
    
    // 加载提示文本
    _loadingLabel.frame = CGRectMake(originX, originY, width, height);
    
    // 背景
    _backgroundPath       = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(originX, originY, width, height)];
    _backgroundLayer.path = _backgroundPath.CGPath;
    
    // loop view
    _loopPath            = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(originX, originY, width, height)];
    _loopLayer.strokeEnd = 0.05;
    _loopLayer.path      = _loopPath.CGPath;
    
    // 添加动画
    // 起始点动画
    CABasicAnimation * startAnimation = [CABasicAnimation animation];
    startAnimation.keyPath            = @"strokeStart";
    startAnimation.fromValue          = @0;
    startAnimation.toValue            = @1;
    
    // 结束点动画
    CABasicAnimation * endAnimation = [CABasicAnimation animation];
    endAnimation.keyPath            = @"strokeEnd";
    endAnimation.fromValue          = @0.05;
    endAnimation.toValue            = @1.05;
    
    // 动画组
    CAAnimationGroup * group  = [CAAnimationGroup animation];
    group.animations          =  @[startAnimation, endAnimation];
    group.duration            = 0.6;
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
