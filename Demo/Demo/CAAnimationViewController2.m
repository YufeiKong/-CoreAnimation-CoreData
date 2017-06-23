//
//  CAAnimationViewController2.m
//  Demo
//
//  Created by Content on 2017/5/10.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "CAAnimationViewController2.h"

@interface CAAnimationViewController2 ()

@end

@implementation CAAnimationViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //path 绿色
    CGMutablePathRef path = CGPathCreateMutable();
    //起点
    CGPathMoveToPoint(path,NULL,50,120);
    //下面5行添加5条直线的路径到path中
    CGPathAddLineToPoint(path,NULL, 60, 160);
    CGPathAddLineToPoint(path,NULL, 100, 200);
    CGPathAddLineToPoint(path, NULL, 200, 300);
    CGPathAddLineToPoint(path, NULL, 250, 400);
    CGPathAddLineToPoint(path, NULL, 300, 500);
    //下面四行添加四条曲线路径到path
    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
    
    // 创建实例
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.duration = 7;
    animation.repeatCount = HUGE;
    CFRelease(path);
    
    CALayer *greenLayer = [CALayer layer];
    greenLayer.jk_borderColor = [UIColor yellowColor];
    greenLayer.borderWidth = 2;
    greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    greenLayer.shadowOffset = CGSizeMake(0, 3);
    greenLayer.shadowColor = [UIColor redColor].CGColor;
    greenLayer.shadowOpacity = 0.8;
    greenLayer.frame = CGRectMake((375-200)/2, 100, 200, 200);
    greenLayer.shadowRadius = 8;
    [self.view.layer addSublayer:greenLayer];
    [greenLayer addAnimation:animation forKey:NULL];
    
    
    //values 红色
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation2.duration = 7;
    animation2.repeatCount = HUGE;
    
    CALayer *redLayer = [CALayer layer];
    redLayer.jk_borderColor = [UIColor brownColor];
    redLayer.borderWidth = 2;
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    redLayer.shadowOffset = CGSizeMake(0, 3);
    redLayer.shadowRadius = 5.0;
    redLayer.shadowColor = [UIColor greenColor].CGColor;
    redLayer.shadowOpacity = 0.8;
    redLayer.frame = CGRectMake((375-200)/2, 350, 200, 200);
    [self.view.layer addSublayer:redLayer];
  
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(300, 100)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(300, 400)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 400)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSArray *values=[NSArray arrayWithObjects:value1,value2,value3,value4,value5, nil];
    [animation2 setValues:values];
    [redLayer addAnimation:animation2 forKey:nil];
 
}



@end
