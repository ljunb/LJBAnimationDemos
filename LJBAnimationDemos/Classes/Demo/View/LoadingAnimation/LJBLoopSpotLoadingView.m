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

- (void)show {
    
    CGFloat originX = kCirclePadding;
    CGFloat originY = kCirclePadding;
    CGFloat width   = self.bounds.size.width - kCirclePadding * 2;
    CGFloat height  = width;
    
    // 圆形轨迹path
    _circlePath       = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(originX, originY, width, height)];
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
    [_spotView.layer addAnimation:animation forKey:nil];
    
}

- (void)dismiss {
    [self removeFromSuperview];
}


@end
