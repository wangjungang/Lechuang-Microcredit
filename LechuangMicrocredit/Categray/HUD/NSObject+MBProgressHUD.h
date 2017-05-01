//
//  NSObject+MBProgressHUD.h
//  YeWen
//
//  Created by 李壮 on 16/8/6.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MBProgressHUD)
+(MBProgressHUD*)showHUDView:(UIView*)view MBText:(NSString*)text;
+ (void)showWarning:(NSString *)warning showHUDView:(UIView*)view;
+(MBProgressHUD*)getMBHUDView:(UIView*)view MBText:(NSString*)text;
@end
