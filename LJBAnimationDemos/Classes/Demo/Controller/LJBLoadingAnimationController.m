//
//  LJBAnimationDemo1Controller.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/20.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBLoadingAnimationController.h"
#import "LJBLoadingView.h"

@interface LJBLoadingAnimationController ()

@property (nonatomic, strong) LJBLoadingView * loadingView;

@end

@implementation LJBLoadingAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 灌水动画
    self.loadingView = ({
        LJBLoadingView * view = [[LJBLoadingView alloc] init];
        view.frame = CGRectMake(20, 84, 80, 80);
        [self.view addSubview:view];
        
        view;
    });
    
    // 开启计时器，模拟下载速度
    [NSTimer scheduledTimerWithTimeInterval:0.075
                                     target:self
                                   selector:@selector(updateAnimation)
                                   userInfo:nil
                                    repeats:YES];
}

#pragma mark - 计时器方法
- (void)updateAnimation {
    
    self.loadingView.progress += 0.05;
    
    if (self.loadingView.progress >= 1) {
        self.loadingView.progress = 0;
    }
}

@end
