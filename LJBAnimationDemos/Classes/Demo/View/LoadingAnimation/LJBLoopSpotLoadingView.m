//
//  LJBLoopSpotLoadingView.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/27.
//  Copyright © 2016年 ljunb. All rights reserved.
//  变速圆点加载动画

#import "LJBLoopSpotLoadingView.h"

static CGFloat const kCircleLineWidth = 1;
static CGFloat const kCirclePadding   = 4;
static CGFloat const kSpotRadius      = 6;

@interface LJBLoopSpotLoadingView ()
{
    UIBezierPath * _circlePath;     // 圆形轨迹
    CAShapeLayer * _circleLayer;
    
    UIView * _spotView;             // 圆点
}

@end

@implementation LJBLoopSpotLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        _circleLayer             = [CAShapeLayer layer];
        _circleLayer.fillColor   = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _circleLayer.lineWidth   = kCircleLineWidth;
        [self.layer addSublayer:_circleLayer];
        
        _spotView                 = [[UIView alloc] init];
        _spotView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_spotView];
    }
    return self;
}

#pragma mark - 显示动画
- (void)show {
    
    CGFloat originX = self.bounds.size.width / 2;
    CGFloat originY = self.bounds.size.height / 2;
    CGFloat radius  = originX - kCirclePadding;
    
    // 圆形轨迹path
    _circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(originX, originY)
                                                 radius:radius
                                             startAngle:M_PI_2 * 3
                                               endAngle:M_PI_2 * 7
                                              clockwise:YES];
    _circleLayer.path = _circlePath.CGPath;
    
    // 圆点frame
    CGFloat centerX = self.bounds.size.width / 2;
    _spotView.frame = CGRectMake(centerX - kSpotRadius / 2,
                                 kCirclePadding - kSpotRadius / 2,
                                 kSpotRadius,
                                 kSpotRadius);
    // 处理圆角
    UIBezierPath * spotCornerPath  = [UIBezierPath bezierPathWithOvalInRect:_spotView.bounds];
    CAShapeLayer * spotCornerLayer = [CAShapeLayer layer];
    spotCornerLayer.path           = spotCornerPath.CGPath;
    _spotView.layer.mask           = spotCornerLayer;
    
    // 添加动画
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath               = @"position";
    animation.path                  = _circlePath.CGPath;
    animation.duration              = 1.5;
    animation.repeatCount           = MAXFLOAT;
    animation.removedOnCompletion   = NO;
    animation.fillMode              = kCAFillModeForwards;
    animation.calculationMode       = kCAAnimationPaced;
    animation.timingFunction        = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 先慢后快再慢
    [_spotView.layer addAnimation:animation forKey:nil];
    
}

#pragma mark - 隐藏动画
- (void)dismiss {
    [self removeFromSuperview];
}


@end
