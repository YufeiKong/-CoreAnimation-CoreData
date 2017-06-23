




#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)highImage targert:(id)targert action:(SEL)action
{

    //1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    
    //2.设置图片
    if (norImage != nil && ![norImage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    if (highImage != nil && ![highImage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    
    //3.设置标题
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    //4.自定义调整控件以及子控件 frame
    [btn sizeToFit];
    
    //5.监听按钮的点击事件
    [btn addTarget:targert action:action forControlEvents:UIControlEventTouchUpInside];
    
    //6.创建 item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
