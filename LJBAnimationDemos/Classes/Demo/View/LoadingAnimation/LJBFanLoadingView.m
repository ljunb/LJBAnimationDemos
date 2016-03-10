//
//  LJBFanLoadingView.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/21.
//  Copyright © 2016年 ljunb. All rights reserved.
//  扇形进度view

#import "LJBFanLoadingView.h"

static CGFloat const kBackgroundCirclePadding     = 4;
static CGFloat const kProgressAndBackgroundMargin = 4;

@interface LJBFanLoadingView ()
{
    UIBezierPath * _backgroundCirclePath;   // 背景圆
    CAShapeLayer * _backgroundCircleLayer;
    
    UIBezierPath * _progressCirclePath;     // 进度圆
    CAShapeLayer * _progressCircleLayer;
}


@end

@implementation LJBFanLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 背景默认为浅灰色
        self.backgroundColor = [UIColor lightGrayColor];
        
        // 底部圆
        _backgroundCircleLayer             = [[CAShapeLayer alloc] init];
        _backgroundCircleLayer.fillColor   = [UIColor lightGrayColor].CGColor;
        _backgroundCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _backgroundCircleLayer.lineWidth   = 2;
        [self.layer addSublayer:_backgroundCircleLayer];
        
        // 进度圆
        _progressCircleLayer             = [[CAShapeLayer alloc] init];
        _progressCircleLayer.fillColor   = [UIColor whiteColor].CGColor;
        _progressCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_progressCircleLayer];
    }
    
    return self;
}

#pragma mark - 重写Setter方法
- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    
    [self setBackgroundCirclePath];
    
    [self setProgressCirclePath];
    
}

#pragma mark - 设置背景圆
- (void)setBackgroundCirclePath {
    
    // 设置底部圆位置、大小
    CGFloat orginX = kBackgroundCirclePadding;
    CGFloat orginY = kBackgroundCirclePadding;
    CGFloat width  = self.bounds.size.width - kBackgroundCirclePadding * 2;
    CGFloat heigth = width;
    
    _backgroundCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(orginX, orginY, width, heigth)];
    
    // 关联CAShapeLayer
    _backgroundCircleLayer.path = _backgroundCirclePath.CGPath;
}

#pragma mark - 绘制进度圆
- (void)setProgressCirclePath {
    
    // 设置圆心和半径
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat radius      = (self.bounds.size.width - kBackgroundCirclePadding * 2) / 2;
    
    // 开始&结束角度
    CGFloat startAngle  = M_PI_2 * 3;
    CGFloat endAngle    = M_PI_2 * 3 + _progress * M_PI * 2;
    
    // 为了达到扇形效果，先添加一个起点，并在最后闭合路径
    _progressCirclePath = [UIBezierPath bezierPath];
    
    [_progressCirclePath moveToPoint:centerPoint];
    [_progressCirclePath addArcWithCenter:centerPoint
                                   radius:radius
                               startAngle:startAngle
                                 endAngle:endAngle
                                clockwise:YES];
    [_progressCirclePath closePath];
    
    // 关联CAShapeLayer
    _progressCircleLayer.path = _progressCirclePath.CGPath;
    
}

@end
