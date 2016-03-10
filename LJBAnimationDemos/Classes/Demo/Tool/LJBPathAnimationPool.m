//
//  LJBPathAnimationPool.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/3/10.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBPathAnimationPool.h"
#import <pop/POP.h>

static CGFloat const kLJBSpringFactor = 10;        // 弹簧因素
static CGFloat const kLJBItemWidthAndHeight = 36; // 按钮大小

@implementation LJBPathAnimationPool

+ (void)springRotationFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view {
    
    // 角度
    POPSpringAnimation * rotationAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnim.fromValue = fromValue;
    rotationAnim.toValue = toValue;
    rotationAnim.springBounciness = kLJBSpringFactor;
    rotationAnim.springSpeed = kLJBSpringFactor;
    [view.layer pop_addAnimation:rotationAnim forKey:@"rotation"];
}

#pragma mark - 展开动画方法
+ (void)bloomItemsFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view {
    
    // 位移
    POPSpringAnimation * positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnim.fromValue = fromValue;
    positionAnim.toValue = toValue;
    positionAnim.springBounciness = kLJBSpringFactor;
    positionAnim.springSpeed = kLJBSpringFactor;
    [view.layer pop_addAnimation:positionAnim forKey:@"position"];
    
    // 大小
    POPSpringAnimation * sizeAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    sizeAnim.fromValue = [NSValue valueWithCGSize:CGSizeZero];
    sizeAnim.toValue = [NSValue valueWithCGSize:CGSizeMake(kLJBItemWidthAndHeight, kLJBItemWidthAndHeight)];
    [view pop_addAnimation:sizeAnim forKey:@"size"];
    
    // 角度
    POPSpringAnimation * rotationAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnim.fromValue = @(0);
    rotationAnim.toValue = @(M_PI * 2);
    [view.layer pop_addAnimation:rotationAnim forKey:@"rotation"];
}

#pragma mark - 折叠动画方法
+ (void)foldItemsFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view {
    
    // 位移
    POPSpringAnimation * positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnim.fromValue = fromValue;
    positionAnim.toValue = toValue;
    positionAnim.springBounciness = kLJBSpringFactor;
    positionAnim.springSpeed = kLJBSpringFactor;
    [positionAnim setCompletionBlock:^(POPAnimation * animation, BOOL isFinished) {
        [view removeFromSuperview];
    }];
    [view.layer pop_addAnimation:positionAnim forKey:@"position"];
    
    // 大小
    POPSpringAnimation * sizeAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    sizeAnim.fromValue = [NSValue valueWithCGSize:CGSizeMake(kLJBItemWidthAndHeight, kLJBItemWidthAndHeight)];
    sizeAnim.toValue = [NSValue valueWithCGSize:CGSizeZero];
    [view pop_addAnimation:sizeAnim forKey:@"size"];
    
    // 角度
    POPSpringAnimation * rotationAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnim.fromValue = @(0);
    rotationAnim.toValue = @(M_PI * 2);
    [view.layer pop_addAnimation:rotationAnim forKey:@"rotation"];
    
}

@end
