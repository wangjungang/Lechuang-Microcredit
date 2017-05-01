//
//  CustomTabbarViewController.h
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/1.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabbarViewController : UITabBarController
-(void)hideTabbar;
-(void)showTabbar;
///单例tabbar工程唯一
+ (id)instanceTabBar;
//跳转到诊所
//-(void)jumpClinicViewController;
//跳转到药店
//-(void)jumpMedicalViewController;
@property (nonatomic,assign)NSInteger lastBtnTag;

@end
