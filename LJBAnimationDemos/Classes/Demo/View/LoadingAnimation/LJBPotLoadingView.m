//
//  LJBLoadingView.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/20.
//  Copyright © 2016年 ljunb. All rights reserved.
//  类罐子注水效果的进度view

#import "LJBPotLoadingView.h"

static CGFloat const kBackgroundCirclePadding     = 4;
static CGFloat const kProgressAndBackgroundMargin = 4;

@interface LJBPotLoadingView ()
{
    UIBezierPath * _backgroundCirclePath;       // 背景view
    CAShapeLayer * _backgroundCircleLayer;
    
    UIBezierPath * _progressCirclePath;         // 进度view
    CAShapeLayer * _progressCircleLayer;
    
}

@end

@implementation LJBPotLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 背景默认为浅灰色
        self.backgroundColor             = [UIColor lightGrayColor];
        
        // 底部圆
        _backgroundCircleLayer           = [[CAShapeLayer alloc] init];
        _backgroundCircleLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_backgroundCircleLayer];
        
        // 进度圆
        _progressCircleLayer             = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:_progressCircleLayer];
    }
    
    return self;
}

#pragma mark - 设置进度
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
    CGFloat radius      = (self.bounds.size.width - (kBackgroundCirclePadding + kProgressAndBackgroundMargin) * 2) / 2;
 
    // 开始&结束角度
    CGFloat startAngle  = M_PI_2 - _progress * M_PI;
    CGFloat endAngle    = M_PI_2 + _progress * M_PI;
    
    _progressCirclePath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                         radius:radius
                                                     startAngle:startAngle
                                                       endAngle:endAngle
                                                      clockwise:YES];
    
    // 透明度随着进度改变
    _progressCircleLayer.fillColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:_progress].CGColor;
    
    // 关联CAShapeLayer
    _progressCircleLayer.path = _progressCirclePath.CGPath;
}


@end
