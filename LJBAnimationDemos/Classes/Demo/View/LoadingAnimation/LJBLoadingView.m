//
//  LJBLoadingView.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/20.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBLoadingView.h"

static CGFloat const kBackgroundCirclePadding     = 4;
static CGFloat const kProgressAndBackgroundMargin = 4;

@interface LJBLoadingView ()
{
    UIBezierPath * _backgroundCirclePath;       // 背景view
    CAShapeLayer * _backgroundCircleLayer;
    
    UIBezierPath * _progressCirclePath;         // 进度view
    CAShapeLayer * _progressCircleLayer;
    
}

@end

@implementation LJBLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor             = [UIColor lightGrayColor];
        
        _backgroundCircleLayer           = [[CAShapeLayer alloc] init];
        _backgroundCircleLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_backgroundCircleLayer];
        
        
        _progressCircleLayer             = [[CAShapeLayer alloc] init];
        _progressCircleLayer.fillColor   = [UIColor grayColor].CGColor;
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
    
    CGFloat orginX = kBackgroundCirclePadding;
    CGFloat orginY = kBackgroundCirclePadding;
    CGFloat width  = self.bounds.size.width - kBackgroundCirclePadding * 2;
    CGFloat heigth = width;
    
    _backgroundCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(orginX, orginY, width, heigth)];
    
    _backgroundCircleLayer.path = _backgroundCirclePath.CGPath;
}

#pragma mark - 绘制进度圆
- (void)setProgressCirclePath {
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat radius      = (self.bounds.size.width - (kBackgroundCirclePadding + kProgressAndBackgroundMargin) * 2) / 2;
 
    CGFloat startAngle  = M_PI_2 - _progress * M_PI;
    CGFloat endAngle    = M_PI_2 + _progress * M_PI;
    
    _progressCirclePath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                         radius:radius
                                                     startAngle:startAngle
                                                       endAngle:endAngle
                                                      clockwise:YES];
    _progressCircleLayer.path = _progressCirclePath.CGPath;
}


@end
