//
//  NSObject+MBProgressHUD.m
//  YeWen
//
//  Created by 李壮 on 16/8/6.
//  Copyright © 2016年 李壮 1. All rights reserved.
//

#import "NSObject+MBProgressHUD.h"
//超时
#define kTimeOut  30
//弹出提示时长
#define kDuration  1
@implementation NSObject (MBProgressHUD)
+(MBProgressHUD*)showHUDView:(UIView*)view MBText:(NSString*)text
{
    MBProgressHUD*MB=[MBProgressHUD showHUDAddedTo:view animated:YES];
    MB.labelText = text;
    [MB hide:NO afterDelay:kTimeOut];
    return MB;
}
+ (void)showWarning:(NSString *)warning showHUDView:(UIView*)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = warning;
    [hud hide:YES afterDelay:kDuration];
}
+(MBProgressHUD*)getMBHUDView:(UIView*)view MBText:(NSString*)text
{
    MBProgressHUD*MB=[[MBProgressHUD alloc]initWithView:view];
    MB.labelText = text;
    [view addSubview:MB];
    return MB;
}
@end
