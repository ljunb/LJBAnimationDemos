//
//  LJBSpringAnimationController.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/3/8.
//  Copyright © 2016年 ljunb. All rights reserved.
//  基于pop的一个动画Demo

#import "LJBSpringAnimationController.h"
#import "LJBSpringAnimationTool.h"


@interface LJBSpringAnimationController ()
/**
 *  开始/结束动画按钮
 */
@property (nonatomic, strong) UIButton * operateButton;

@end

static NSInteger const kLJBSubviewCount = 6;            // 子控件个数
static NSInteger const kLJBSubviewColumn = 3;           // 列数
static CGFloat const kLJBSubviewWidthAndHeight = 60;    // 子控件长/宽度

static CGFloat const kLJBAnimationDelay = 0.075;        // 动画延迟时间

@implementation LJBSpringAnimationController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupOperateButton];
}


#pragma mark - 添加“+”按钮
- (void)setupOperateButton {
    
    UIButton * operateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    operateButton.frame = CGRectMake(0, 0, 40, 40);
    [operateButton setBackgroundImage:[UIImage imageNamed:@"btn_topic_community_add"] forState:UIControlStateNormal];
    operateButton.center = CGPointMake(LJBScreenSize.width * 0.5, LJBScreenSize.height * 0.9);
    [operateButton addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:operateButton];
    self.operateButton = operateButton;

}

#pragma mark - 点击+按钮
- (void)didClick {
    
    // 修改按钮状态
    self.operateButton.selected = !self.operateButton.selected;
    
    if (!self.operateButton.selected) { // 退出动画
        
        // 按钮复位
        [UIView animateWithDuration:kLJBSubviewCount * kLJBAnimationDelay animations:^{
            self.operateButton.transform = CGAffineTransformIdentity;
        }];
        
        // 退出动画
        [self startQuitAnimation];
        
    } else {    // 开始动画
        
        // 旋转按钮
        [UIView animateWithDuration:kLJBSubviewCount * kLJBAnimationDelay animations:^{
            self.operateButton.transform = CGAffineTransformRotate(self.operateButton.transform, M_PI_4*3);
        }];
        
        // 开始动画
        [self startBeginAnimation];
        
    }
    
}

#pragma mark - 开始动画
- (void)startBeginAnimation {
    
    // 计算间距
    CGFloat horizontalMargin = (LJBScreenSize.width - kLJBSubviewWidthAndHeight * kLJBSubviewColumn) / (kLJBSubviewColumn + 1);
    
    CGFloat verticalInitial = 200;  // 垂直初始位置
    CGFloat verticalMargin = 10;    // 子控件垂直间距
    
    
    // 添加UIView
    for (NSInteger index = 0; index < kLJBSubviewCount; index++) {
        
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        view.layer.cornerRadius = kLJBSubviewWidthAndHeight * 0.5;
        view.layer.masksToBounds = YES;
        [self.view addSubview:view];
        
        
        // 计算坐标
        NSInteger col = index % kLJBSubviewColumn;
        NSInteger row = index / kLJBSubviewColumn;
        
        CGFloat originX = horizontalMargin + col * (horizontalMargin + kLJBSubviewWidthAndHeight);
        CGFloat originBeginY = -kLJBSubviewWidthAndHeight;
        CGFloat originEndY = verticalInitial + row * (verticalMargin + kLJBSubviewWidthAndHeight);
        
        
        // 初始位置
        NSValue * fromValue = [NSValue valueWithCGRect:CGRectMake(originX,
                                                                  originBeginY,
                                                                  kLJBSubviewWidthAndHeight,
                                                                  kLJBSubviewWidthAndHeight)];
        // 结束位置
        NSValue * toValue = [NSValue valueWithCGRect:CGRectMake(originX,
                                                                originEndY,
                                                                kLJBSubviewWidthAndHeight,
                                                                kLJBSubviewWidthAndHeight)];
        // 延迟时间
        CGFloat delay = index * kLJBAnimationDelay;
        
        // 开始动画
        [LJBSpringAnimationTool beginAnimationFromValue:fromValue
                                                toValue:toValue
                                               withView:view
                                                  delay:delay];
    }
}

#pragma mark - 退出动画
- (void)startQuitAnimation {
    
    // 结束中心点
    CGFloat centerEndY = LJBScreenSize.height + kLJBSubviewWidthAndHeight / 2;
    
    // 依次结束动画
    NSInteger index = 0;
    for (UIView * view in self.view.subviews) {
        
        if (![view isKindOfClass:[UIButton class]]) {
            
            NSValue * fromValue = @(view.center.y);     // 默认位置
            NSValue * toValue = @(centerEndY);          // 移出屏幕外
            CGFloat delay = index * kLJBAnimationDelay; // 延迟时间
            
            // 退出动画
            [LJBSpringAnimationTool quitAnimationFromValue:fromValue
                                                   toValue:toValue
                                                  withView:view
                                                     delay:delay
                                           completionBlock:^{
                                               [view removeFromSuperview]; // for-in取出subViews，故动画结束后就移除
                                           }];
            
            index++;
        }
    }
}

@end
