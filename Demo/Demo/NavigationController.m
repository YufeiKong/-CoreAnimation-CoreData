//
//  NavigationController.m
//  CircleOfFriends
//
//  Created by Content on 17/4/17.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "NavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface NavigationController ()

@end

@implementation NavigationController

//第一次使用就调用
+ (void)initialize
{
    // appearance 设置导航条的背景颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor whiteColor];
    
    // 设置导航控制器标题的颜色
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSForegroundColorAttributeName] = [UIColor whiteColor];
    md[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:md];
}

//重写push 方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果是栈底控制器,则不需要隐藏 tabBar
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //给每个子控制器的左上角添加一个按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil norImage:@"back_arrow_gray_" higImage:nil targert:nil action:@selector(pop)];
    }
    [super pushViewController:viewController animated:YES];
}

//点击item响应方法
- (void)pop{
    
    [self popViewControllerAnimated:YES];
}
@end
