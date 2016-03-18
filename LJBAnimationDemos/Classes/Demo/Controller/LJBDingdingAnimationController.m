//
//  LJBDingdingAnimationController.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/3/11.
//  Copyright © 2016年 ljunb. All rights reserved.
//  仿钉钉弹出菜单动画

#import "LJBDingdingAnimationController.h"

@interface LJBDingdingAnimationController ()
/**
 *  操作按钮
 */
@property (nonatomic, strong) UIButton * operateButton;
/**
 *  是否展开
 */
@property (nonatomic, assign, getter=isBloom) BOOL bloom;

@end

@implementation LJBDingdingAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self setupOperateButton];
}

#pragma mark - 添加操作按钮
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

#pragma mark - 单击事件
- (void)didClick {
    
    self.bloom = !self.bloom;
    
    if (self.isBloom) { // 展开
        
    } else {            // 折叠
        
    }
}

@end
