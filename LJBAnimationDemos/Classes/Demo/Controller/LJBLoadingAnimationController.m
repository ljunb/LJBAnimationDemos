//
//  LJBAnimationDemo1Controller.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/20.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBLoadingAnimationController.h"
#import "LJBPotLoadingView.h"
#import "LJBFanLoadingView.h"
#import "LJBLoopPieLoadingView.h"
#import "LJBLoopLoadingView.h"
#import "LJBLoopSpotLoadingView.h"

@interface LJBLoadingAnimationController ()
/**
 *  注水动画
 */
@property (nonatomic, strong) LJBPotLoadingView * potLoadingView;
/**
 *  扇形动画
 */
@property (nonatomic, strong) LJBFanLoadingView * fanLoadingView;
/**
 *  管道循环加载动画
 */
@property (nonatomic, strong) LJBLoopPieLoadingView * loopPieLoadingView;
/**
 *  循环加载动画
 */
@property (nonatomic, strong) LJBLoopLoadingView * loopLoadingView;
/**
 *  圆点加载动画
 */
@property (nonatomic, strong) LJBLoopSpotLoadingView * loopSpotLoadingView;

@end

@implementation LJBLoadingAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、灌水动画
    self.potLoadingView = ({
        LJBPotLoadingView * view = [[LJBPotLoadingView alloc] init];
        view.frame  = CGRectMake(20, 84, 80, 80);
        [self.view addSubview:view];
        
        view;
    });
    
    // 2、扇形动画
    self.fanLoadingView = ({
        LJBFanLoadingView * view = [[LJBFanLoadingView alloc] init];
        view.frame = CGRectMake(CGRectGetMaxX(self.potLoadingView.frame) + 20, 84, 80, 80);
        [self.view addSubview:view];
        
        view;
    });
    
    // 3、管道循环加载动画
    self.loopPieLoadingView = ({
        LJBLoopPieLoadingView * view = [[LJBLoopPieLoadingView alloc] init];
        view.frame = CGRectMake(CGRectGetMaxX(self.fanLoadingView.frame) + 20, 84, 80, 80);
        [self.view addSubview:view];
        
        view;
    });
    self.loopPieLoadingView.lineColor = [UIColor whiteColor];
    // 显示动画
    [self.loopPieLoadingView show];
    
    // 隐藏动画
    [self performSelector:@selector(removeAnimation) withObject:nil afterDelay:3];
    
    // 4、循环加载动画
    self.loopLoadingView = ({
        LJBLoopLoadingView * view = [[LJBLoopLoadingView alloc] init];
        view.frame = CGRectMake(20, CGRectGetMaxY(self.potLoadingView.frame) + 20, 80, 80);
        [self.view addSubview:view];
        
        view;
    });
    [self.loopLoadingView show];

    // 5、圆形轨迹圆点加载动画
    self.loopSpotLoadingView = ({
        LJBLoopSpotLoadingView * view = [[LJBLoopSpotLoadingView alloc] init];
        view.frame = CGRectMake(CGRectGetMaxX(self.loopLoadingView.frame) + 20, CGRectGetMinY(self.loopLoadingView.frame), 80, 80);
        [self.view addSubview:view];
        
        view;
    });
    [self.loopSpotLoadingView show];
    
    // 开启计时器，模拟下载速度
    [NSTimer scheduledTimerWithTimeInterval:0.075
                                     target:self
                                   selector:@selector(updateAnimation)
                                   userInfo:nil
                                    repeats:YES];
}

#pragma mark - 移除动画
- (void)removeAnimation {
//    [self.loopPieLoadingView dismiss];
}

#pragma mark - 计时器方法
- (void)updateAnimation {
    
    self.potLoadingView.progress += 0.02;
    
    if (self.potLoadingView.progress >= 1) {
        self.potLoadingView.progress = 0;
    }
    
    self.fanLoadingView.progress += 0.02;
    
    if (self.fanLoadingView.progress >= 1) {
        self.fanLoadingView.progress = 0;
    }
}

@end
