//
//  LJBPathAnimationController.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/3/10.
//  Copyright © 2016年 ljunb. All rights reserved.
//  仿Path菜单展开&收回动画简易版

#import "LJBPathAnimationController.h"
#import "LJBPathAnimationPool.h"

// 平均角度
#define LJBAverageAngle M_PI / (self.itemArray.count + 1)

@interface LJBPathAnimationController ()
/**
 *  “+”按钮
 */
@property (nonatomic, strong) UIButton * operateButton;
/**
 *  动画按钮数组
 */
@property (nonatomic, strong) NSMutableArray * itemArray;
/**
 *  是否展开
 */
@property (nonatomic, assign, getter=isBloom) BOOL bloom;

@end


static CGFloat const kLJBPathItemRadius = 100;  // 按钮距离中心半径

@implementation LJBPathAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupOperateButton];
    
    [self addAllAnimationItems];
}

#pragma mark - 添加“+”按钮
- (void)setupOperateButton {
    
    UIButton * operateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    operateButton.frame = CGRectMake(0, 0, 38, 38);
    operateButton.center = CGPointMake(LJBScreenSize.width * 0.5, LJBScreenSize.height * 0.8);
    [operateButton setBackgroundImage:[UIImage imageNamed:@"chooser-button-tab"] forState:UIControlStateNormal];
    [operateButton setBackgroundImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"] forState:UIControlStateHighlighted];
    [operateButton addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:operateButton];
    self.operateButton = operateButton;
}

#pragma mark - button action
- (void)didClick {
    // 修改展开/折叠状态
    self.bloom = !self.bloom;
    
    // 背景渐变动画
    [UIView animateWithDuration:0.15 animations:^{
        self.view.backgroundColor = self.isBloom ? [UIColor colorWithWhite:1 alpha:0.7] : [UIColor colorWithWhite:1 alpha:1];
    }];
    
    // 展开&折叠动画
    if (self.isBloom) { // 展开
        
        [self bloomAllItems];
        
    } else {            // 折叠
        
        [self foldAllItems];
    }
}

#pragma mark - 展开动画
- (void)bloomAllItems {
    
    // 中心按钮动画
    [LJBPathAnimationPool springRotationFromValue:@(0) toValue:@(M_PI_4) withView:self.operateButton];
    
    // 展开按钮动画
    for (NSInteger index = 0; index < self.itemArray.count; index++) {
        
        // 取出按钮
        UIButton * item = self.itemArray[index];
        item.center = self.operateButton.center;
        [self.view insertSubview:item belowSubview:self.operateButton];
        
        // 开始点
        NSValue * fromValue = [NSValue valueWithCGPoint:self.operateButton.center];
        
        // 计算终点中心位置
        CGFloat centerX = self.operateButton.center.x - kLJBPathItemRadius * cos(LJBAverageAngle * index + LJBAverageAngle);
        CGFloat centerY = self.operateButton.center.y - kLJBPathItemRadius * sin(LJBAverageAngle * index + LJBAverageAngle);
        NSValue * toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
        
        // 执行动画
        [LJBPathAnimationPool bloomItemsFromValue:fromValue toValue:toValue withView:item];
    }
}

#pragma mark - 折叠动画
- (void)foldAllItems {
    
    // 中心按钮动画
    [LJBPathAnimationPool springRotationFromValue:@(M_PI_4) toValue:@(0) withView:self.operateButton];
    
    // 折叠按钮动画
    for (NSInteger index = 0; index < self.itemArray.count; index++) {
        
        // 取出按钮
        UIButton * item = self.itemArray[index];
        
        // 开始点
        CGFloat centerX = self.operateButton.center.x - kLJBPathItemRadius * cos(LJBAverageAngle * index + LJBAverageAngle);
        CGFloat centerY = self.operateButton.center.y - kLJBPathItemRadius * sin(LJBAverageAngle * index + LJBAverageAngle);
        NSValue * fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
        
        // 终点中心位置
        NSValue * toValue = [NSValue valueWithCGPoint:self.operateButton.center];
        
        // 执行动画
        [LJBPathAnimationPool foldItemsFromValue:fromValue toValue:toValue withView:item];
    }

}

#pragma mark - 添加所有动画按钮到数组
- (void)addAllAnimationItems {
    
    [self setupButtonWithNormalImage:@"chooser-moment-icon-music" highlightedImage:@"chooser-moment-icon-music-highlighted"];
    [self setupButtonWithNormalImage:@"chooser-moment-icon-place" highlightedImage:@"chooser-moment-icon-place-highlighted"];
    [self setupButtonWithNormalImage:@"chooser-moment-icon-camera" highlightedImage:@"chooser-moment-icon-camera-highlighted"];
    [self setupButtonWithNormalImage:@"chooser-moment-icon-thought" highlightedImage:@"chooser-moment-icon-thought-highlighted"];
    [self setupButtonWithNormalImage:@"chooser-moment-icon-sleep" highlightedImage:@"chooser-moment-icon-sleep-highlighted"];
}

#pragma mark 添加按钮到数组
- (void)setupButtonWithNormalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage {
   
    UIButton * item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.frame = CGRectMake(0, 0, 36, 36);
    [item setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [item setBackgroundImage:[UIImage imageNamed:@"chooser-moment-button"] forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"] forState:UIControlStateHighlighted];
    
    [self.itemArray addObject:item];
}

#pragma mark - Getter
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end
