//
//  LJBLoopScaleLoadingView.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/2/4.
//  Copyright © 2016年 ljunb. All rights reserved.
//  圆点循环放大缩放加载动画

#import "LJBLoopScaleLoadingView.h"

static NSInteger const kReplicatorLayerInstanceCount = 20;
static CGFloat const kSpotLayerWidthAndHeight        = 5;
static CGFloat const kSpotLayerAnimationDuration     = 1.5;

@interface LJBLoopScaleLoadingView ()
{
    CAReplicatorLayer * _repLayer;  // 复制图层
    
    CALayer * _spotLayer;   // 圆点图层
}

@end

@implementation LJBLoopScaleLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        // 复制图层
        _repLayer                   = [CAReplicatorLayer layer];
        _repLayer.instanceCount     = kReplicatorLayerInstanceCount;    // 圆点个数+原始图层
        _repLayer.instanceTransform = CATransform3DMakeRotation(M_PI * 2 / kReplicatorLayerInstanceCount, 0, 0, 1); // 子图层的transform属性 -（围绕圆心旋转）
        _repLayer.instanceDelay     = kSpotLayerAnimationDuration / kReplicatorLayerInstanceCount;  // 子图层的延时时间
        [self.layer addSublayer:_repLayer];
        
        // 圆点图层
        _spotLayer                 = [CALayer layer];
        _spotLayer.cornerRadius    = kSpotLayerWidthAndHeight / 2;
        _spotLayer.masksToBounds   = YES;
        _spotLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _spotLayer.transform       = CATransform3DMakeScale(0, 0, 0);   // 圆点默认不显示
        [_repLayer addSublayer:_spotLayer];
    }
    
    return self;
}

#pragma mark - 显示动画
- (void)show {
    
    // 复制层为当前加载动画视图大小
    _repLayer.frame = self.bounds;
    
    // 初始圆点位置 -（水平居中+顶部下自身高度）
    _spotLayer.frame = CGRectMake(self.bounds.size.width / 2 - kSpotLayerWidthAndHeight / 2,
                                  kSpotLayerWidthAndHeight,
                                  kSpotLayerWidthAndHeight,
                                  kSpotLayerWidthAndHeight);
    
    // 添加动画
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath            = @"transform.scale";
    animation.fromValue          = @1;  // 比例大小从1~0
    animation.toValue            = @0;
    animation.repeatCount        = MAXFLOAT;
    animation.duration           = kSpotLayerAnimationDuration;
    [_spotLayer addAnimation:animation forKey:nil];
    
}


@end
