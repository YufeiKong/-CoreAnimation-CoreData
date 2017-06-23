//
//  TabBarViewController.m
//  CircleOfFriends
//
//  Created by Content on 17/4/17.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationController.h"
#import "QuartzCoreController.h"
#import "CoreDataController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 执行加载控制器
    [self loadViewControllers];
}

- (void)loadViewControllers {
    
    // QuartzCore
    [self setupChildVC:[[QuartzCoreController alloc] init] title:@"QuartzCore" image:[UIImage imageNamed:@"nav_shoping_"] selectImage:[UIImage imageNamed:@"nav_shoping_selected_"]];
    
    // CoreData
    [self setupChildVC:[[CoreDataController alloc] init] title:@"CoreData" image:[UIImage imageNamed:@"nav_live_"] selectImage:[UIImage imageNamed:@"nav_live_selected_"]];
   
}
#pragma mark - 添加一个子控制器
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage {
    
    NavigationController *mmNav = [[NavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:mmNav];
    vc.tabBarItem.title = title;
   // vc.tabBarItem.image = image;
    //vc.tabBarItem.selectedImage = selectImage;
    vc.view.backgroundColor= [UIColor whiteColor];
}
@end
