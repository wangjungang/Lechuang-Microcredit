//
//  BXTextField.m
//  BXInsurenceBroker
//
//  Created by JYJ on 16/7/15.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "BXTextField.h"
#import "UIView+BXExtension.h"
#import "UITextField+BXExtension.h"

@interface BXTextField ()
/** X按钮 */
@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, assign) BOOL willShowKeyboard;

@property (nonatomic, assign) BOOL displayingKeyboard;
@end

@implementation BXTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.keyboardType = UIKeyboardTypeNumberPad;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeginShow:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillEndShow:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)dealloc {
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillBeginShow:(NSNotification *)notification {
    if (self.keyboardType != UIKeyboardTypeNumberPad) return;
    self.willShowKeyboard = notification.object == self;
}


- (void)keyboardWillEndShow:(NSNotification *)notification {
    if (self.keyboardType != UIKeyboardTypeNumberPad) return;
    self.willShowKeyboard = NO;
    NSDictionary *userInfo = [notification userInfo];
    CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    // 添加动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    self.doneButton.transform = CGAffineTransformIdentity;
    [self.doneButton removeFromSuperview];
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if (self.keyboardType != UIKeyboardTypeNumberPad) return;
    if (!self.willShowKeyboard) {
        self.displayingKeyboard = YES;
        return;
    }
    NSLog(@"%zd", self.displayingKeyboard);
    [self.doneButton removeFromSuperview];
    self.doneButton = nil;

    NSDictionary *userInfo = [notification userInfo];
    // 动画时间
    CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 键盘的Frame
    CGRect kbEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeight = kbEndFrame.size.height;
    
    // 获取到最上层的window,这句代码很关键
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.0) {
        tempWindow = [[[UIApplication sharedApplication] windows] lastObject];
    }
    
    // 通过图层查看系统的键盘有UIKeyboardAutomatic这个View，第三方的对应位置的view为_UISizeTrackingView
    // 只有iOS 8.0以上需要
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        if (![UIView ff_foundViewInView:tempWindow clazzName:@"UIKeyboardAutomatic"]) return;
    }
    
    // 这里因为用了第三方的键盘顶部，所有加了44
    if (self.adjustTextFeildH) {
        kbHeight = kbEndFrame.size.height - 44;
    }

    // 动画的轨迹
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    // 按钮的位置计算
    CGFloat doneButtonX = 0;
    CGFloat doneButtonW = 0;
    CGFloat doneButtonH = 0;
    // 为了适配不同屏幕
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        doneButtonW = ([UIScreen mainScreen].bounds.size.width - 6) / 3;
        doneButtonH = (kbHeight - 2) / 4;
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        doneButtonW = ([UIScreen mainScreen].bounds.size.width - 8) / 3;
        doneButtonH = (kbHeight - 2) / 4;
    } else if ([UIScreen mainScreen].bounds.size.width == 414) {
        doneButtonW = ([UIScreen mainScreen].bounds.size.width - 7) / 3;
        doneButtonH = kbHeight / 4;
    }
    CGFloat doneButtonY = 0;
    if (self.displayingKeyboard) {
        doneButtonY = [UIScreen mainScreen].bounds.size.height - doneButtonH;
    } else {
        doneButtonY = [UIScreen mainScreen].bounds.size.height + kbHeight - doneButtonH;
    }
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(doneButtonX, doneButtonY, doneButtonW, doneButtonH)];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:27];
    [doneButton setTitle:@"X" forState:(UIControlStateNormal)];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton = doneButton;
    // 添加按钮
    [tempWindow addSubview:doneButton];
    
    if (!self.displayingKeyboard) {
        // 添加动画
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:animationCurve];
        doneButton.transform = CGAffineTransformTranslate(doneButton.transform, 0, -kbHeight);
        [UIView commitAnimations];
    }
    self.displayingKeyboard = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (self.keyboardType != UIKeyboardTypeNumberPad) return;
    self.displayingKeyboard = NO;
}

#pragma mark - 私有方法
/**
 *  完成按钮点击
 */
- (void)doneButton:(UIButton *)doneButton{
    // 获得光标所在的位置
    NSUInteger insertIndex = [self selectedRange].location;
    
    NSMutableString *string = [NSMutableString stringWithString:self.text];
    
    [string replaceCharactersInRange:self.selectedRange withString:doneButton.currentTitle];
    
    // 重新赋值
    self.text = string;
    
    // 让光标回到插入文字后面
    [self setSelectedRange:NSMakeRange(insertIndex + 1, 0)];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[UIDevice currentDevice] playInputClick];
    });
}

/**
 *  用颜色返回一张图片
 */
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
