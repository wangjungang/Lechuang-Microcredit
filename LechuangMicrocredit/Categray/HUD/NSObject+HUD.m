//
//  NSObject+HUD.m
//  MODAO
//
//  Created by 王静帅 on 16/8/28.
//  Copyright © 2016年 yaqoo. All rights reserved.
//

#import "NSObject+HUD.h"
#define kTipFont [UIFont systemFontOfSize:18]
#define kKeyWinndow [UIApplication sharedApplication].keyWindow
#define kTipBorderW 50
#define kTipTextColor [UIColor whiteColor];

@implementation NSObject (HUD)

#pragma mark - 文本提示
+ (void)wj_showHUDWithTip:(NSString *)tip {
  
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(9999, 9999, 9999, 9999)];
    lbl.alpha = 0.6;
    lbl.text = tip;
    lbl.layer.cornerRadius = 10;
    lbl.clipsToBounds = YES;
    lbl.numberOfLines = 0;
    lbl.backgroundColor = [UIColor blackColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = kTipFont;
    lbl.textColor = kTipTextColor;
    
    [lbl sizeToFit];
    lbl.adjustsFontSizeToFitWidth = YES;

    CGRect rect = [tip boundingRectWithSize:lbl.frame.size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:kTipFont,NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat widthFont;
    CGFloat heightFont;
    if (rect.size.width >= screenWidth) {
        widthFont = screenWidth/1.5;
        heightFont = 80;
        [lbl setFrame:CGRectMake((screenWidth -widthFont - kTipBorderW)/2, (screenHeight - heightFont)/2, widthFont + kTipBorderW,heightFont)];
    } else {
         [lbl setFrame:CGRectMake((screenWidth - rect.size.width - kTipBorderW)/2, (screenHeight - rect.size.height)/2, rect.size.width + kTipBorderW,40)];
    }
    if (kKeyWinndow.subviews.count >= 2) {
        [kKeyWinndow.subviews.lastObject removeFromSuperview];
    }
    [kKeyWinndow addSubview:lbl];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [lbl removeFromSuperview];
    });
}

#pragma mark - 用户选择或者说明
+ (void)wj_selVcWithTitle:(NSString *)title TitleExplain:(NSString *)exp FirstSel:(NSString *)firstSel SecondSel:(NSString *)secondSel SelfVc:(UIViewController *)selfVc PresentStyle:(WJNewPresentStyle)presentStyle FirstOrSureBlock:(wj_FirstSelOrSureBlock) FirstOrSureBlock SecondSelOrCancelBlock:(wj_SecondSelOrCancelBlock) SecondSelOrCancelBlock{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIAlertControllerStyle style;
        if (presentStyle) {
            style = UIAlertControllerStyleAlert;
        } else {
            style = UIAlertControllerStyleActionSheet;
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:exp preferredStyle:style];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FirstOrSureBlock(nil);
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"  style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            SecondSelOrCancelBlock(nil);
        }];
        
        UIAlertAction* otherActionOne;
        if (firstSel) {
            otherActionOne = [UIAlertAction actionWithTitle:firstSel style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                FirstOrSureBlock(firstSel);
            }];
        }
       
        UIAlertAction* otherActionTwo;
        if (secondSel) {
             otherActionTwo = [UIAlertAction actionWithTitle:secondSel style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                SecondSelOrCancelBlock(secondSel);
            }];
        }
        
        if (firstSel) {
            [alertController addAction:otherActionOne];
        }
        if (secondSel) {
            [alertController addAction:otherActionTwo];
        }
        if (!firstSel && !secondSel) {
            [alertController addAction:sureAction];
        }
        [alertController addAction:cancelAction];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            //显示
            [selfVc presentViewController:alertController animated:true completion:nil];
        });
    });
}

+ (void)wj_alterSingleVCWithOneTitle:(NSString *)oneTitle andTwoTitle:(NSString *)twoTitle andSelfVC:(UIViewController *)selfVC
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:oneTitle message:twoTitle preferredStyle:  UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    //弹出提示框；
    [selfVC presentViewController:alert animated:YES completion:nil];
    
}

@end
