//
//  QuartzCoreController.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "QuartzCoreController.h"
#import "CATransactionViewController.h"
#import "CAShapeLayerViewController.h"
#import "CAAnimationViewController.h"
#import "CAAnimationViewController2.h"

@interface QuartzCoreController ()
@property(nonatomic,copy)NSArray *titleArray;

@end

@implementation QuartzCoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"QuartzCore";
    _titleArray = @[@"CATransaction",@"CAShapeLayer",@"CAAnimation",@"CAAnimation2"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        
    CATransactionViewController *vc = [[CATransactionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==1){
    
    CAShapeLayerViewController *vc = [[CAShapeLayerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    }else if (indexPath.row==2){
    
    CAAnimationViewController *vc = [[CAAnimationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
        
    }else{

    CAAnimationViewController2 *vc = [[CAAnimationViewController2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
        
    }

}

@end
