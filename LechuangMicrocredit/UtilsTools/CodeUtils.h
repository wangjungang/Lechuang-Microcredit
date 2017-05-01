//
//  CodeUtils.h
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/1.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#ifndef CodeUtils_h
#define CodeUtils_h


#define USER_ID 
//屏幕宽度
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height
//屏幕宽度比
#define WIDTH_SCALE [UIScreen mainScreen].bounds.size.width / 375
//屏幕高度比
#define HEIGHT_SCALE [UIScreen mainScreen].bounds.size.height / 667
//颜色RGBA
#define kCOLOR(R, G, B, A) [UIColor colorWithRed:R /255.0 green:G /255.0 blue:B /255.0 alpha:A]

#define KNAV_Blue kCOLOR(57, 160, 219, 1)

#define Line_Color kCOLOR(210, 210, 210, 0.3)
//根据字体大小取得label的宽高
#define LABEL_SIZE(STR,FONT) [STR sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"AppleGothic" size:FONT]}]


#define kNSUserDefaults [NSUserDefaults standardUserDefaults]
//缓存启动页第一次加载
#define FIRST_LOADING_PATH  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/firstloading.plist"]

#define USERID [NSUserDefaults standardUserDefaults]

#define UID  [USERID valueForKey:@"uid"]
#endif /* CodeUtils_h */
