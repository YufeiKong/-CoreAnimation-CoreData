//
//  UIBarButtonItem+Extension.h
//
//
//  Created by apple on 20/6/8.
//  Copyright (c) 2020年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)highImage targert:(id)targert action:(SEL)action;
@end
