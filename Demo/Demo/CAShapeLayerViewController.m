//
//  CAShapeLayerViewController.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()
@property(nonatomic,strong)CAShapeLayer *ShapeLayer;
@property(nonatomic,strong)CAShapeLayer *ShapeLayer2;
@property(nonatomic,strong)CAShapeLayer *ShapeLayer3;
@property(nonatomic,strong)CAShapeLayer *ShapeLayer4;
@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    #pragma mark --  尖角图形
    _ShapeLayer = [CAShapeLayer layer];
    _ShapeLayer.frame = CGRectMake(30, 100, 200, 200);
    _ShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充背景色
    _ShapeLayer.strokeColor = [UIColor blueColor].CGColor;//边框颜色
    [_ShapeLayer jk_updateWithBezierPath:[self getBezierPath]];
    [self.view.layer addSublayer:_ShapeLayer];
    
    //动画
    CABasicAnimation *pathAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAniamtion.duration = 5;
    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAniamtion.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAniamtion.toValue = [NSNumber numberWithFloat:1.0];
    pathAniamtion.repeatCount=HUGE;
    [_ShapeLayer addAnimation:pathAniamtion forKey:nil];
    
    #pragma mark --  波纹
    UIView * testView=[[UIView alloc] initWithFrame:CGRectMake(170, 60, 200, 200)];
    [self.view addSubview:testView];
    testView.layer.backgroundColor = [UIColor clearColor].CGColor;
    //CAShapeLayer和CAReplicatorLayer都是CALayer的子类
    //CAShapeLayer的实现必须有一个path，可以配合贝塞尔曲线
    _ShapeLayer4 = [CAShapeLayer layer];
    _ShapeLayer4.frame = testView.layer.bounds;
    [_ShapeLayer4 jk_updateWithBezierPath:[self getBezierPath4]];
    _ShapeLayer4.fillColor = [UIColor greenColor].CGColor;//填充色
    _ShapeLayer4.opacity = 0.0;
    //复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = testView.bounds;
    replicatorLayer.instanceCount = 5;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 1;//复制副本之间的延迟
    [replicatorLayer addSublayer:_ShapeLayer4];
    [testView.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];//透明度
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];//翻转
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.repeatCount = HUGE;
    [_ShapeLayer4 addAnimation:groupAnima forKey:@"groupAnimation"];
    
    #pragma mark --  弧线
    _ShapeLayer2 = [CAShapeLayer layer];
    _ShapeLayer2.frame = CGRectMake((375-300)/2, 300, 300, 200);
    _ShapeLayer2.fillColor = [UIColor clearColor].CGColor;
    _ShapeLayer2.strokeColor = [UIColor redColor].CGColor;
    //_ShapeLayer2.lineWidth = 6;
    //_ShapeLayer2.lineCap = kCALineCapRound;
    [_ShapeLayer2 jk_updateWithBezierPath:[self getBezierPath2]];
    [_ShapeLayer2 addAnimation:pathAniamtion forKey:nil];
    [self.view.layer addSublayer:_ShapeLayer2];
    
    #pragma mark --  旋转
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake((375-100)/2, 550, 100, 100)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    _ShapeLayer3=[CAShapeLayer layer];
    [_ShapeLayer3 jk_updateWithBezierPath:[self getBezierPath3]];
    _ShapeLayer3.fillColor=[UIColor clearColor].CGColor;//填充色
    _ShapeLayer3.strokeColor=[UIColor yellowColor].CGColor;//边框颜色
    _ShapeLayer3.lineWidth=6.0f;
    _ShapeLayer3.lineCap=kCALineCapRound;//线框类型
    [view.layer addSublayer:_ShapeLayer3];

    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration = 0.6;
    animation.repeatCount=HUGE;//永久重复动画
    animation.fillMode=kCAFillModeForwards;//当动画结束后,layer会一直保持着动画最后的状态 与removedOnCompletion属性搭配使用
    animation.removedOnCompletion=NO;//默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。设置为NO,则保存显示后的动画状态
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//速度控制函数
    [view.layer addAnimation:animation forKey:@"animation"];

}
#pragma mark ---尖角图形
-(UIBezierPath *)getBezierPath{

    UIBezierPath *BezierPath = [UIBezierPath bezierPath];
    CGFloat viewWidth = 200;
    CGFloat viewHeight = 200;
    CGFloat rightSpace = 100.;
    CGFloat topSpace = 150.;
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);//100
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);//100 150
    CGPoint point4 = CGPointMake(viewWidth, topSpace);//200 150
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);//100 160
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);//100 200
    CGPoint point7 = CGPointMake(0, viewHeight);//200

    [BezierPath moveToPoint:   point1];
    [BezierPath addLineToPoint:point2];
    [BezierPath addLineToPoint:point3];
    [BezierPath addLineToPoint:point4];
    [BezierPath addLineToPoint:point5];
    [BezierPath addLineToPoint:point6];
    [BezierPath addLineToPoint:point7];
    [BezierPath closePath];
    return BezierPath;
}
#pragma mark ---弧线
-(UIBezierPath *)getBezierPath2{
    
    UIBezierPath *BezierPath = [UIBezierPath bezierPath];
    CGPoint point1= CGPointMake(10, 80);
    CGPoint point2= CGPointMake(10, 200);
    CGPoint point3= CGPointMake(300, 200);
    CGPoint point4= CGPointMake(300, 80);
    [BezierPath moveToPoint:point1];
    [BezierPath addLineToPoint:point2];
    [BezierPath addLineToPoint:point3];
    [BezierPath addLineToPoint:point4];
    //添加弧线  controlPoint：弧线的顶点
    [BezierPath addQuadCurveToPoint:point1 controlPoint:CGPointMake(145, -50)];
    [BezierPath closePath];
    return BezierPath;
}
#pragma mark ---旋转
-(UIBezierPath *)getBezierPath3{
    
    UIBezierPath *BezierPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:-M_PI_2 endAngle:M_PI clockwise:YES];
    return BezierPath;
}
#pragma mark ---旋转
-(UIBezierPath *)getBezierPath4{
    
    UIBezierPath *BezierPath=[UIBezierPath bezierPathWithOvalInRect:_ShapeLayer4.bounds];
    return BezierPath;
}
@end
