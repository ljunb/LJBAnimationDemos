//
//  LJBSpringAnimationTool.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/3/8.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBSpringAnimationTool.h"
#import <POP.h>

static CGFloat const kLJBSpringFactor = 8;

@implementation LJBSpringAnimationTool

+ (void)beginAnimationFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view delay:(CFTimeInterval)delay {
    
    POPSpringAnimation * animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.springBounciness = kLJBSpringFactor;
    animation.springSpeed = kLJBSpringFactor;
    animation.beginTime = CACurrentMediaTime() + delay;
    [view pop_addAnimation:animation forKey:nil];
}

+ (void)quitAnimationFromValue:(id)fromValue toValue:(id)toValue withView:(UIView *)view delay:(CFTimeInterval)delay completionBlock:(CompletionBlock)completionBlock {
    
    POPBasicAnimation * animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.beginTime = CACurrentMediaTime() + delay;
    [view pop_addAnimation:animation forKey:nil];
    
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL isFinished) {
        if (completionBlock) {
            completionBlock();
        }
    }];
}

@end
