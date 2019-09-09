//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view alpha:(CGFloat)alpha{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.alpha = alpha;
    hud.mode =  MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}



+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view hideState:(BOOL)hideState
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    
    
    if (hideState == YES) {
        
        [hud hideAnimated:YES afterDelay:1.5];
    }
    
    return hud;
}


+ (MBProgressHUD *)showMessag:(NSString *)message
                       toView:(UIView *)view
                    hideState:(BOOL)hideState
                   delayBlock:(NSBlockOperation *)delayBlock
{
    MBProgressHUD *hud = [MBProgressHUD showMessag:message toView:view hideState:hideState];
    
//    
//    if (delayBlock) {
//        
//        
//    }
    
    
    return hud;
}
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message showMinSize:(CGSize)size toView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view==nil?[[UIApplication sharedApplication].windows lastObject]:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.backgroundColor = [UIColor clearColor];
    hud.minSize = size;
    UIImage *image = [[UIImage imageNamed:@"loading_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView* mainImageView= [[UIImageView alloc] initWithImage:image];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i <25; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]];
        [imageArr addObject:image];
    }
    mainImageView.animationImages = (NSArray *)imageArr;
    [mainImageView setAnimationDuration:0.5f];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
    hud.label.text = message;
    hud.customView = mainImageView;
    hud.animationType = MBProgressHUDAnimationFade;
    return hud;
}

@end
