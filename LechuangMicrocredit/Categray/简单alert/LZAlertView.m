//
//  AlertView.m
//  ddddd
//
//  Created by 李壮 on 2016/11/16.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import "LZAlertView.h"
#import "ViewController.h"
@interface LZAlertView ()
{
    ViewController*Control;
}
@end
@implementation LZAlertView
SINGLETON_FOR_CLASS(LZAlertView)

- (void)getAlertView:(ViewController*)viewControl title:(NSString*)title messgae:(NSString*)messgae alertStyle:(UIAlertControllerStyle)style cancleBtnTitle:(NSString*)cancleTil
{
    Control=viewControl;
    _lzAlert =[UIAlertController alertControllerWithTitle:title message:messgae preferredStyle:style];
    UIAlertAction *cancle=[UIAlertAction actionWithTitle:cancleTil style:0 handler:nil];
    [_lzAlert addAction:cancle];
}
- (void)show
{
    [Control presentViewController:_lzAlert animated:YES completion:nil];
}
@end
