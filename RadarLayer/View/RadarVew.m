//
//  RadarVew.m
//
//  Created by gengliming on 15/11/26.
//  Copyright © 2015年 glm. All rights reserved.
//

//
// 感谢：http://blog.csdn.net/zhangao0086/article/details/38170359
//
// 思路是借鉴如下网友的，该网友是用swift写的
//

#import "RadarVew.h"
@interface RadarVew() {
    __weak CALayer *_animationLayer;
}
@end
@implementation RadarVew

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    //
    // 防止按下home键再返回时动画卡死
    //
    // 因为按下home键后会移除动画
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resume) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)drawRect:(CGRect)rect{
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    NSInteger pulsingCount = 6;
    NSInteger animationDuration = 4;
    
    CALayer *animationLayer = [[CALayer alloc] init];
    
    for (NSInteger i = 0; i < pulsingCount; i++) {
        CALayer *pulsingLayer = [[CALayer alloc] init];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.borderColor = [UIColor grayColor].CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = rect.size.height /2;
        
        CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup  alloc] init];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + i * animationDuration / pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = INFINITY;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.autoreverses = YES;
        scaleAnimation.fromValue = @0;
        scaleAnimation.toValue = @1.5;
        
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.7, @0];
        opacityAnimation.keyTimes = @[@0, @0.5, @1];
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        
        [pulsingLayer addAnimation:animationGroup forKey:@"radar"];
        [animationLayer addSublayer:pulsingLayer];
    }
    _animationLayer = animationLayer;
    [self.layer addSublayer:_animationLayer];
}

- (void)resume{
    [_animationLayer removeFromSuperlayer];
    [self setNeedsDisplay];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
