//
//  NSObject+HUD.h
//  MODAO
//
//  Created by 王静帅 on 16/8/28.
//  Copyright © 2016年 yaqoo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WJNewPresentStyle) {
    WJNewPresentFromBottom = 0,
    WJNewPresentFromCenter,
};

typedef void (^wj_FirstSelOrSureBlock)(NSString *userSelStr);
typedef void (^wj_SecondSelOrCancelBlock)(NSString *userSelStr);

@interface NSObject (HUD)

/**
 1, 提供两种选择
 2, 提供解释说明
 */
+ (void)wj_selVcWithTitle:(NSString *)title TitleExplain:(NSString *)exp FirstSel:(NSString *)firstSel SecondSel:(NSString *)secondSel SelfVc:(UIViewController *)selfVc PresentStyle:(WJNewPresentStyle)presentStyle FirstOrSureBlock:(wj_FirstSelOrSureBlock) FirstOrSureBlock SecondSelOrCancelBlock:(wj_SecondSelOrCancelBlock) SecondSelOrCancelBlock;

/**
 文本提示
 */
+ (void)wj_showHUDWithTip:(NSString *)tip;


/**
 目的:单个提示框,仅提示功能
 */
+ (void)wj_alterSingleVCWithOneTitle:(NSString *)oneTitle andTwoTitle:(NSString *)twoTitle andSelfVC:(UIViewController *)selfVC;

@end
