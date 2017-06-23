//
//  CATransactionViewController.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "CATransactionViewController.h"

@interface CATransactionViewController ()
@property(nonatomic,strong)CALayer *firstLayer;
@property(nonatomic,strong)CALayer *secondLayer;
@end

@implementation CATransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstLayer = [[CALayer alloc]init];
    _firstLayer.bounds = CGRectMake(0, 0, 200, 200);
    _firstLayer.position = CGPointMake(110, 200);
    _firstLayer.backgroundColor = [UIColor redColor].CGColor;
    _firstLayer.borderColor = [UIColor blackColor].CGColor;
    _firstLayer.borderWidth = 1;
    _firstLayer.opacity = 1.0f;
    [self.view.layer addSublayer:_firstLayer];
    
    _secondLayer = [[CALayer alloc]init];
    _secondLayer.bounds = CGRectMake(300, 0, 100, 100);
    _secondLayer.position = CGPointMake(300, 200);
    _secondLayer.cornerRadius = 50;
    _secondLayer.backgroundColor = [UIColor greenColor].CGColor;
    _secondLayer.borderColor = [UIColor blackColor].CGColor;
    _secondLayer.borderWidth = 1;
    _secondLayer.opacity = 1.0f;
    [self.view.layer addSublayer:_secondLayer];

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((375-200)/2, 500, 200, 50)];
    [btn setTitle:@"点击开始动画" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click_btn) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click_btn{
    
    
    [CATransaction jk_animateWithDuration:5.0 animations:^{

    _firstLayer.cornerRadius = (_firstLayer.cornerRadius == 0.0f) ? 100.0f : 0.0f;
    _firstLayer.opacity = (_firstLayer.opacity == 1.0f) ? 0.5f : 1.0f;
    [_firstLayer setValue:@(0.5) forKeyPath:@"transform.scale"];
        
    } completion:^{
        
    [CATransaction jk_animateWithDuration:5 animations:^{
        
    _firstLayer.position = self.view.center;
    _secondLayer.position = self.view.center;
    _firstLayer.backgroundColor = [UIColor yellowColor].CGColor;
    _secondLayer.backgroundColor = [UIColor redColor].CGColor;
    _firstLayer.cornerRadius = (_firstLayer.cornerRadius == 0.0f) ? 100.0f : 0.0f;
    _firstLayer.opacity = (_firstLayer.opacity == 1.0f) ? 0.5f : 1.0f;
    [_firstLayer setValue:@(1.0) forKeyPath:@"transform.scale"];
        
    } completion:^{
        
    [CATransaction jk_animateWithDuration:3 animations:^{
       
    [_firstLayer setValue:@(50) forKeyPath:@"position.x"];
    [_secondLayer setValue:@(50) forKeyPath:@"position.x"];
        
    } completion:^{
        
    [CATransaction jk_animateWithDuration:3 animations:^{
        
    [_firstLayer setValue:@(40) forKeyPath:@"position.y"];
    [_secondLayer setValue:@(40) forKeyPath:@"position.y"];
        
    } completion:^{
        
    [CATransaction jk_animateWithDuration:5 animations:^{
        
    _firstLayer.position = self.view.center;
    _secondLayer.position =CGPointMake(300, 200);
    _firstLayer.backgroundColor = [UIColor redColor].CGColor;
    _secondLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [_secondLayer setValue:@(1.5) forKeyPath:@"transform.scale"];
    _firstLayer.cornerRadius = (_firstLayer.cornerRadius == 0.0f) ? 100.0f : 0.0f;
    _firstLayer.opacity = (_firstLayer.opacity == 1.0f) ? 0.5f : 1.0f;
    } completion:^{
        
    }];

    }];
        
    }];
    
   }];
}];
}
@end
