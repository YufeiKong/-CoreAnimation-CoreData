//
//  CAAnimationViewController.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "CAAnimationViewController.h"

@interface CAAnimationViewController ()

@end

@implementation CAAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置沿y轴偏转180度
    CATransform3D transA = CATransform3DIdentity;
    transA = CATransform3DRotate(transA, M_PI / 1, 0, 1, 0);//X Y Z轴
    //设置沿y轴偏转360度
    CATransform3D transB = CATransform3DIdentity;
    transB = CATransform3DRotate(transB, M_PI*2 /1, 0, 1,0);//X Y Z轴
    //蓝色
    CALayer *blueLayer = [CALayer layer];
    blueLayer.jk_borderColor = [UIColor yellowColor];
    blueLayer.borderWidth = 2;
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.shadowOffset = CGSizeMake(0, 5);
    blueLayer.shadowRadius = 50.0;
    blueLayer.shadowColor = [UIColor redColor].CGColor;
    blueLayer.shadowOpacity = 0.8;
    blueLayer.frame = CGRectMake((375-200)/2, 100, 200, 200);
    [self.view.layer addSublayer:blueLayer];
    [CAAnimation jk_addAnimationToLayer:blueLayer duration:3 transform:transA easingFunction:CAAnimationEasingFunctionEaseInCircular];
   
    //红色
    CALayer *redLayer = [CALayer layer];
    redLayer.jk_borderColor = [UIColor brownColor];
    redLayer.borderWidth = 2;
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    redLayer.shadowOffset = CGSizeMake(0, 5);
    redLayer.shadowRadius = 50.0;
    redLayer.shadowColor = [UIColor greenColor].CGColor;
    redLayer.shadowOpacity = 0.8;
    redLayer.frame = CGRectMake((375-200)/2, 350, 200, 200);
    [self.view.layer addSublayer:redLayer];
    //竖直方向移动
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation jk_animationWithKeyPath:@"position.y" duration:7 from:300 to:660 easingFunction:CAAnimationEasingFunctionEaseInCircular];
    
    CAKeyframeAnimation *animation2 =  [CAKeyframeAnimation jk_transformAnimationWithDuration:7 from:transA to:transB easingFunction:CAAnimationEasingFunctionEaseInCircular];
    animation2.timingFunction = [CAMediaTimingFunction jk_easeOutQuint];//动画的运动效果
    //水平方向移动
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation jk_animationWithKeyPath:@"position.x" duration:7 from:100 to:300 easingFunction:CAAnimationEasingFunctionEaseInCircular];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[animation1, animation2,animation3];
    groupAnima.duration = 7.0;
    groupAnima.repeatCount = HUGE;
    [redLayer addAnimation:groupAnima forKey:@"groupAnimation"];
    
    
  // [CAAnimation jk_addAnimationToLayer:redLayer withKeyPath:@"position.x" duration:30 to:300 easingFunction:CAAnimationEasingFunctionLinear];
 
    
}
@end
