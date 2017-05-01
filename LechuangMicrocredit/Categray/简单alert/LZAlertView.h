//
//  AlertView.h
//  ddddd
//
//  Created by 李壮 on 2016/11/16.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import <UIKit/UIKit.h>
@interface LZAlertView : NSObject
@property (nonatomic,strong)UIAlertController*lzAlert;
SINGLETON_FOR_CLASS_HEADER(LZAlertView)
- (void)getAlertView:(UIViewController*)viewControl title:(NSString*)title messgae:(NSString*)messgae alertStyle:(UIAlertControllerStyle)style cancleBtnTitle:(NSString*)cancleTil;
- (void)show;
@end
